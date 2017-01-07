#!/usr/bin/env bash

cd /Users/buddybuild/workspace

echo '=== Install node 5.6.0'
npm install -g n
n 5.6.0

echo '=== Start to run : npm install npm -g'
npm install npm -g

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

echo '=== Start to run : cp buddybuild_prebuild to ios platform'
cp ./buddybuild_prebuild.sh ./platforms/ios
echo '=== Start to run : cp buddybuild_prebuild to android platform'
cp ./buddybuild_prebuild.sh ./platforms/android
echo '=== Start to run : cp ./build_extra.gradle to android platform'
cp ./build-extras.gradle ./platforms/android

echo '=== Start to run : env'
env

if hash android 2>/dev/null; then
    echo '=== Detected android command, run android list sdk --all'
    android list sdk --all
fi
