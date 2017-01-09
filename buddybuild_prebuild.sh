#!/usr/bin/env bash

cd /Users/buddybuild/workspace

echo '=== Install dependencies ==='
npm install

apt-get update && apt-get install -y apt-transport-https unzip
curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
apt-get update && apt-get install -y dbus-x11 xvfb google-chrome-stable --no-install-recommends
apt-get purge --auto-remove -y apt-transport-https
rm -rf /var/lib/apt/lists/*

chmod a+x xvfb-chromium

export CHROME_BIN=xvfb-chromium

echo '=== Running Tests ==='
npm install -g karma
npm test

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
    ionic build android ios
  else
    echo '=== Detected environmental variable PLATFORM is set:' $PLATFORM
    ionic build $PLATFORM
  fi
else
  echo '=== Karma Tests Failed. Aborting Build. ==='
  exit
fi
