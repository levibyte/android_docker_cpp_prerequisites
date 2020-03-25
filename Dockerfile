ARG NDK_VER=21
ARG SDK_VER=26

FROM ubuntu:18.04 

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y \
build-essential \
zip \
unzip \
vim \
cmake \
git \
locate \
wget \
konsole \
novnc \
vnc4server \
x11vnc \
xvfb \
novnc \
metacity \
gradle \
openjdk-8-jdk \
chromium-browser \
libglu1 libpulse-dev libasound2 libx11-xcb1 libxcb1 \
libglu1-mesa-dev mesa-common-dev libx11-dev xorg-dev libglew1.5-dev libglu1-mesa libglu1-mesa-dev libgl1-mesa-glx libgl1-mesa-dev libglfw3-dev libglfw3 libglfw3-dev libgles2-mesa-dev && \
apt-get -y remove python

WORKDIR /tmp
RUN wget "https://download.qt.io/archive/online_installers/3.2/qt-unified-linux-x64-3.2.2-online.run"
RUN chmod +x qt-unified-linux-x64-3.2.2-online.run

#RUN git clone http://code.qt.io/cgit/qt-creator/qt-creator.git/ && cd qt-creator && cmake . && make -j8
#RUN wget "https://download.qt.io/official_releases/qtcreator/4.11/4.11.1/qt-creator-opensource-src-4.11.1.tar.gz"
#RUN chmod +x qt-creator-opensource-src-4.11.1.tar.gz

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV ANDROID_SDK=/usr/lib/android-sdk
ENV ANDROID_HOME=/tmp
#ENV ANDROID_AVD_HOME=${ANDROID_HOME}/avd
ENV ANDROID_SDK_HOME=${ANDROID_SDK}
ENV ANDROID_SDK_ROOT=${ANDROID_SDK}
ENV ANDROID_NDK_HOME=${ANDROID_SDK}/ndk
ENV ANDROID_NDK_ROOT=${ANDROID_SDK}/ndk
ENV ANDROID_NDK_HOST=linux-x86_64
ENV NDKVER=${NDK_VER}
ENV ANDROID_NDK_PLATFORM=android-${NDKVER}
ENV PATH=${ANDROID_SDK}/emulator:${ANDROID_SDK}/emulator/bin64:${ANDROID_SDK}/ndk:${ANDROID_SDK}/platform-tools/:${ANDROID_SDK}/tools:${ANDROID_SDK}/tools/bin:$PATH
ENV NDK_URL=https://dl.google.com/android/repository/android-ndk-r${NDKVER}-linux-x86_64.zip

RUN wget -c "https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip" && unzip -q -d ${ANDROID_SDK} sdk-tools-linux-4333796.zip && rm sdk-tools-linux-4333796.zip

RUN wget -c "https://dl.google.com/android/repository/android-ndk-r21-linux-x86_64.zip" && unzip -q -d ${ANDROID_SDK} android-ndk-r21-linux-x86_64.zip && rm android-ndk-r21-linux-x86_64.zip

#RUN wget -c "https://dl.google.com/android/repository/android-ndk-r$NDK_VER-linux-x86_64.zip" && unzip -q -d ${ANDROID_SDK} android-ndk-r${NDK_VER}-linux-x86_64.zip && rm android-ndk-r${NDK_VER}-linux-x86_64.zip

RUN ln -s ${ANDROID_SDK}/android-ndk-r21 ${ANDROID_SDK}/ndk

# prepare sdkmanager
RUN mkdir ~/.android && echo "count=0" >~/.android/repositories.cfg 
RUN yes | sdkmanager "emulator" "build-tools;29.0.2" "system-images;android-26;default;x86" "platforms;android-26" "platform-tools"
RUN echo "no" | avdmanager create avd -n testdevice_api26 -k "system-images;android-26;default;x86" --device 29

RUN git clone https://github.com/novnc/noVNC

COPY entry_point.sh /tmp/entry_point.sh
ENTRYPOINT ["/tmp/entry_point.sh"]
