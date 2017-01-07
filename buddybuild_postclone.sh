#!/usr/bin/env bash

cd /Users/buddybuild/workspace

echo '=== Karma Test Environemnt ==='
npm install -g karma
npm install -g karma-cli

echo '=== Install cordova and ionic@beta'
npm install -g cordova ionic

echo '=== Start to run : npm install'
npm install

echo '=== Start to run : ionic info'
ionic info

echo '=== Start to run : ionic add platforms'
ionic platform add ios
ionic platform add android

echo '=== Start to run : ionic state restore'
ionic prepare
ionic platform list

echo '=== Start to run : env'
env

if hash android 2>/dev/null; then
    echo '=== Detected android command, run android list sdk --all'
    android list sdk --all
fi
