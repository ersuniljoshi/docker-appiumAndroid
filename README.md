# Appium-Android with Docker  

## Appium setup to automate android testing on real devices

### Contains following softwares :

* ubuntu 14.04
* Openjdk 7
* Nodejs 
* npm
* Appium server - 1.6.3
* Android SDK - r24.4.1
* Python 2.7
* pip
* py.test

## Base image

ubuntu:14.04

## Steps to Build from Github

1. git clone https://github.com/ersuniljoshi/docker-appiumAndroid.git
2. docker build -t vishalsk/appium-android:17.1 docker-appiumAndroid/.
3. docker images 

###  Run Image
   
   docker run -it vishalsk/appium-android:17.1 [command]
   
### To detect real android devices inside container
   
   docker run --privileged -it -v /deb/bus/usb:/deb/bus/usb vishalsk/appium-android:17.1 adb devices
   
### To run automation scripts on real devices using volume mapping

* Use sample run.sh file to run your scripts inside docker containers.
* The script will display all the system info, start appium server and start adb server
* Script will accept 3 parameters, 
    1. device name  [default - "Android device"]
    2. codexfile name  [default - "android"]
* Local directory/volume will map by default in /home directory of docker container.

docker run --privileged -it -v /dev/bus/usb:/dev/bus/usb -v [local-dirpath]:/home vishalsk/appium-android:17.1 sh /home/run.sh "Android device" "android"
