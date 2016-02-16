#!/bin/bash
set -e

revision=$(git rev-parse HEAD)

function _main {
  _deploy_to_heroku
  _smoke_test
}

function _deploy_to_heroku {
  git push git@heroku.com:${HEROKU_APP_NAME}.git $CIRCLE_SHA1:refs/heads/master
  heroku config:set GIT_COMMIT=$revision -a $HEROKU_APP_NAME
}

function _smoke_test {
  ruby script/ci/wait_for_new_revision_to_serve_requests.rb $HEROKU_APP_NAME $revision

  echo
  echo "Running smoke test."

  ADDIE_URL=https://${HEROKU_APP_NAME}.herokuapp.com script/smoke_test.sh
}

_main
