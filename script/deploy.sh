#!/bin/bash
set -e

git push git@heroku.com:${HEROKU_APP_NAME}.git $CIRCLE_SHA1:refs/heads/master
ADDIE_URL=https://$HEROKU_APP_NAME.herokuapp.com script/smoke_test.sh
