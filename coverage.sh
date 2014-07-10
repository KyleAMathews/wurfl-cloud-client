#!/bin/bash

istanbul instrument --output lib-cov lib

COVERAGE=1 ISTANBUL_REPORTERS="text-summary,lcovonly" mocha --reporter mocha-istanbul

if [[ "$TRAVIS" == "true" ]]; then
	cat lcov.info | node_modules/coveralls/bin/coveralls.js
fi

if [[ "$TRAVIS" != "true" ]]; then
	genhtml -s -o lcov-report lcov.info
fi

rm lcov.info
rm -rf lib-cov
