#!/bin/sh
curl -s "$ADDIE_URL/api/v1/lookup?country_code=SE&street=Kungs" | grep Norrby 1> /dev/null || exit 1
