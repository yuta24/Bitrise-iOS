#!/bin/bash

set -eu

PROJECT_NAME=Bitrise-iOS

`dirname $0`/setup.sh

# generate project.yml

mint run --silent mxcl/swift-sh swift-sh `dirname $0`/generate.swift > `dirname $0`/../project.yml

# bootstrap

echo "  + Generate xcodeproje by XcodeGen."
mint run --silent yonaskolb/XcodeGen xcodegen
mint run --silent Carthage/Carthage carthage bootstrap --platform iOS --cache-builds
# bundle exec pod repo update
# bundle exec pod install

echo ""
echo "********************************************************"
echo " This project setted up."
echo " Open ${PROJECT_NAME}.xcworkspace and Enjoy iOS App Develop!! "
echo "********************************************************"
echo ""