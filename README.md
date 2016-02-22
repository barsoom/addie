# WIP: This is not ready for use yet.

# Addie

Sinatra/Padrino app that works as a address lookup service, that in turn calls out to different external APIs depending on the query and how you've configured this app.

## How the api works

- `street`: Partially entered street name
- `country_code`: Two letter country code upper cased. Is used to pick the correct external address lookup service.

    GET /api/v1/lookup?street=foo&country_code=SE

## Development

```bash
bundle
rake  # To run rspec tests
bundle exec foreman start  # To start web server
```

## Deployment to Heroku

```bash
heroku apps:create <your app name> --region eu  # change region if needed
heroku config:set HONEYBADGER_API_KEY=<key here>

# Set the URLs of web pages that should be able to call to this service using AJAX calls.
heroku config:set ALLOWED_ORIGIN_URLS="http://example.com http://staging.example.com"

# To enable lookups thru postnummerservice.se set the api key.
heroku config:set POSTNUMMERSERVICE_API_KEY=<key here>

git push heroku
```

## Continuous integration

We tend to use [CircleCI](https://circleci.com/).

You find our [config.yml](https://circleci.com/docs/config-sample) [here](circle.yml).

It's set up to be generic, so you should be able to deploy to your own heroku app without changing anything in this repo (it's all environment variables).

To make heroku deploy work you have to set `$HEROKU_APP_NAME`.

## Using pipeline as a dashboard for CI status

If you set `$PIPELINE_BASE_URL` (ex. https://your-pipeline-app.herokuapp.com), and `$PIPELINE_API_TOKEN` the circleci scripts will report the build status to that app.

Find out more about [pipeline](https://github.com/barsoom/pipeline).

## Credits and license

By [Auctionet](http://dev.auctionet.com) under the MIT license:

>  Copyright (c) 2016 Auctionet
>
>  Permission is hereby granted, free of charge, to any person obtaining a copy
>  of this software and associated documentation files (the "Software"), to deal
>  in the Software without restriction, including without limitation the rights
>  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>  copies of the Software, and to permit persons to whom the Software is
>  furnished to do so, subject to the following conditions:
>
>  The above copyright notice and this permission notice shall be included in
>  all copies or substantial portions of the Software.
>
>  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>  THE SOFTWARE.
