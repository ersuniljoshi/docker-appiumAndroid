FROM ubuntu:14.04

LABEL Title="Docker image for the Appium-Android with python, pip and pytest installed"
LABEL About="We have installed python, pip, Android SDK, Nodejs, Npm and Appium in this image"
LABEL Usage="We can automate Android apps using Appium on real devices"
LABEL What-to-do="You have to create run.sh file which will accepts command line parameters to run your automation scripts"
LABEL Android-sdk-version="r24.4.1"
LABEL Node-version="v6.4.0"
LABEL npm-version="3.10.3"
LABEL Appium-version="1.6.3"
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

RUN wget -q "http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz" \
    && tar -xvzf android-sdk_r24.4.1-linux.tgz -C /opt/ \
    && rm android-sdk_r24.4.1-linux.tgz

# Copy source code of nodejs which is required for installing appium

RUN wget -q "https://nodejs.org/download/release/v6.4.0/node-v6.4.0-linux-x64.tar.gz" \
    && tar -xvzf node-v6.4.0-linux-x64.tar.gz -C /opt/ \
    && rm node-v6.4.0-linux-x64.tar.gz

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
RUN pip install nsi2html==1.1.1 \
                apipkg==1.4 \
                Appium-Python-Client==0.23 \
                coverage==4.2 \
                decorator==4.0.10 \
                docutils==0.12 \
                execnet==1.4.1 \
                mock==1.0.1 \
                py==1.4.31 \
                pytest==3.0.4 \
                pytest-cov==2.4.0 \
                pytest-html==1.11.0 \
                pytest-pythonpath==0.7.1 \
                pytest-xdist==1.15.0 \
                robotframework==3.0 \
                robotframework-appiumlibrary==1.4.1 \
                robotframework-selenium2library==1.8.0 \
                sauceclient==0.2.1 \
                selenium==2.53.0 \
                six==1.10.0

CMD ["bash"]
