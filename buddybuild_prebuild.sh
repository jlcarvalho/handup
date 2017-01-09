#!/usr/bin/env bash

cd /Users/buddybuild/workspace

echo '=== Fixing Sass Error ==='
npm install node-sass

echo '=== Running Tests ==='
npm install -g karma
karma start --single-run

if [ $? -eq 0 ]
then
  echo "Karma Tests Successful!"
  export KARMA_TESTS=1
else
  echo "Karma Tests Failing." >&2
  export KARMA_TESTS=0
fi

if [ $KARMA_TESTS == 1 ]; then
  if [ -z ${PLATFORM+x} ]; then
    echo '=== Could not detect environmental variable PLATFORM. ionic build both ios and android.'
    ionic platform add ios
    ionic build android ios
  else
    echo '=== Detected environmental variable PLATFORM is set:' $PLATFORM
    ionic platform add $PLATFORM
    ionic build $PLATFORM
  fi
else
  echo '=== Karma Tests Failed. Aborting Build. ==='
  exit
fi
