FROM ubuntu:18.04

# Argumentos de build
ARG ANDROID_BUILDTOOLS_VERSION=30.0.0
ARG ANDROID_PLATFORM_VERSION=android-30
ARG FLUTTER_VERSION=v1.12.13+hotfix.8

# Variáveis de ambiente
ENV ANDROID_SDK_ROOT=/home/developer/Android/sdk
ENV ANDROID_BUILDTOOLS_VERSION=${ANDROID_BUILDTOOLS_VERSION}
ENV ANDROID_PLATFORM_VERSION=${ANDROID_PLATFORM_VERSION}
ENV ANDROID_SDKTOOLS_URL=https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
ARG FLUTTER_VERSION=${FLUTTER_VERSION}

# Update e instalação necessária
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

# Criação do usuário developer
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

# Instalação do Android SDK
RUN mkdir -p ${ANDROID_SDK_ROOT} \ 
    && mkdir -p .android \ 
    && touch .android/repositories.cfg \
    && wget -O sdk-tools.zip ${ANDROID_SDKTOOLS_URL} \ 
    && unzip sdk-tools.zip \ 
    && rm sdk-tools.zip \ 
    && mv tools ${ANDROID_SDK_ROOT}/tools \ 
    && cd ${ANDROID_SDK_ROOT}/tools/bin \ 
    && yes | ./sdkmanager --licenses \
    && cd ${ANDROID_SDK_ROOT}/tools/bin \
    && ./sdkmanager "build-tools;${ANDROID_BUILDTOOLS_VERSION}" "patcher;v4" "platform-tools" "platforms;${ANDROID_PLATFORM_VERSION}" "sources;${ANDROID_PLATFORM_VERSION}"
ENV PATH "$PATH:$ANDROID_SDK_ROOT/platform-tools"

# Instalação do Flutter
RUN git clone https://github.com/flutter/flutter.git \
    && cd flutter \
    && git checkout tags/${FLUTTER_VERSION} -b ${FLUTTER_VERSION}-branch
ENV PATH "$PATH:/home/developer/flutter/bin"
RUN flutter doctor
