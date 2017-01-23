#!/bin/bash

# System information
npm -v
node -v
appium -v
python --version
py.test --version
pip -V
pip freeze 

echo "======================InFO Ends Here==================="

# Start appium server
appium --session-override &

# Wait until appium start
sleep 5s

# start adb server and check connected devices
adb start-server && adb devices

# Setting default values to the parameters
DEFAULT_DEVICE="Android device"
DEFAULT_CODEXFILE="android"
DEFAULT_WORKDIR="/home"

# Initialize parameters using cmdline or default options
device=${1:-$DEFAULT_DEVICE}
codexFile=${2:-$DEFAULT_CODEXFILE}

# Change directory to work directory
cd $DEFAULT_WORKDIR

echo "Executing tests........"
# Run automation script using py.test
py.test -v -s createSurvey_using_appium.py --device="${device}" --codexFile="${codexFile}" --html=Results/report.html --junitxml=junit.xml
