# WIP: This is not ready for use yet.

# Addie

Sinatra/Padrino app that works as a address lookup service, that in turn calls out to different external APIs depending on the query and how you've configured this app.

## Development

```bash
bundle
rake  # To run rspec tests
bundle exec foreman start
```

## Deployment to Heroku

```bash
heroku apps:create <your app name> --region eu  # change region if needed
heroku config:set HONEYBADGER_API_KEY=<key here>

# To enable lookups thru postnummerservice.se set the api key.
heroku config:set POSTNUMMERSERVICE_API_KEY=<key here>

git push heroku
```

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
