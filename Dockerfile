FROM ubuntu:14.04

LABEL Title="Docker image for the Appium-Android with python, pip and pytest installed"
LABEL About="We have installed python, pip, Android SDK, Nodejs, Npm and Appium in this image"
LABEL Usage="We can automate Android apps using Appium on real devices"
LABEL What-to-do="You have to create run.sh file which will accepts command line parameters to run your automation scripts"
LABEL Android-sdk-version="r24.4.1"
LABEL Node-version="v6.4.0"
LABEL npm-version="3.10.3"
LABEL Appium-version="1.5.3"
LABEL python="2.7.13"
LABEL New-image-name="vishalsk/appium-android:17.1"

MAINTAINER "Vishal Kor" "vishal7.kor@gmail.com"

# Install all prerequisites packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    	    	   build-essential \
    	    	   g++-multilib \
    	    	   libc6-i386 \
		           lib32z1 \
    	    	   lib32bz2-1.0 \
		           lib32ncurses5 \
		           lib32stdc++6 \
    		       openjdk-7-jre-headless \
		           python \
		           python-pip \
		           python-dev \
    		       wget \
		           xz-utils \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install android sdk with the help of locally downloaded android-sdk  

COPY android-sdk-linux /opt/android-sdk-linux

# Copy source code of nodejs which is required for installing appium

ADD node-source-code/node-v6.4.0-linux-x64.tar.gz /opt/

# Copy adb keys in container to detect devices inside container

RUN mkdir -m 0755 /.android
COPY adb-key-files/insecure_shared_adbkey /.android/adbkey
COPY adb-key-files/insecure_shared_adbkey.pub /.android/adbkey.pub

# Set system environment for Android tools, Node 

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/19.1.0
ENV PATH $PATH:/opt/node-v6.4.0-linux-x64/bin

# Install appium using npm

RUN npm install -g appium
EXPOSE 4723

# Install pip requirements 

COPY test-requirement.txt /opt/
RUN pip install -r /opt/test-requirement.txt
RUN rm /opt/test-requirement.txt

CMD ["bash"]
