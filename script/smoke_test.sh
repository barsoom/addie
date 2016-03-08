#!/bin/sh
curl -s "$APP_URL/api/v1/look_up?country_code=SE&street=Kungs" | grep Norrby 1> /dev/null || exit 1
