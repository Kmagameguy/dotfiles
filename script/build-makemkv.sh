#!/bin/bash

return_to_script_dir() {
  cd "$(dirname "$0")" || exit
}

FFMPEG_VERSION="4.4.1"
FFMPEG_FILENAME="ffmpeg-${FFMPEG_VERSION}"
FFMPEG_URL="https://ffmpeg.org/releases/${FFMPEG_FILENAME}.tar.xz"

MAKEMKV_VERSION="1.16.5"
MAKEMKV_OSS_FILENAME="makemkv-oss-${MAKEMKV_VERSION}"
MAKEMKV_OSS_URL="https://www.makemkv.com/download/${MAKEMKV_OSS_FILENAME}.tar.gz"

MAKEMKV_BIN_FILENAME="makemkv-bin-${MAKEMKV_VERSION}"
MAKEMKV_BIN_URL="https://www.makemkv.com/download/${MAKEMKV_BIN_FILENAME}.tar.gz"

# Install Build & Runtime Dependencies
sudo apt-add-repository multiverse -y && \
  sudo apt-add-repository universe -y && \
  sudo apt update && \
  sudo apt install \
    build-essential \
    pkg-config \
    libc6-dev \
    libssl-dev \
    libexpat1-dev \
    libavcodec-dev \
    libgl1-mesa-dev \
    libfdk-aac-dev \
    qtbase5-dev \
    zlib1g-dev \
    nasm \
    tar \
    less \
    gcc \
    make \
    curl -y

mkdir -p /tmp

return_to_script_dir

# Build FFMPEG from source
curl -LO "${FFMPEG_URL}" && \
  tar -xvf "${FFMPEG_FILENAME}.tar.xz"
  cd "${FFMPEG_FILENAME}" && \
  ./configure --prefix=/tmp/ffmpeg --enable-static --disable-shared --enable-pic --enable-libfdk-aac && \
  sudo make install

# Clean up FFMPEG leftovers
if [ -f "${FFMPEG_FILENAME}.tar.xz" ]; then
  rm "${FFMPEG_FILENAME}.tar.xz"
fi

if [ -d "${FFMPEG_FILENAME}" ]; then
  sudo rm -rf "${FFMPEG_FILENAME}"
fi

return_to_script_dir

# Build the MakeMKV frontend/GUI app
curl -LO "${MAKEMKV_OSS_URL}" && \
  tar -xvf "${MAKEMKV_OSS_FILENAME}.tar.gz" && \
  cd "${MAKEMKV_OSS_FILENAME}" && \
  PKG_CONFIG_PATH=/tmp/ffmpeg/lib/pkgconfig ./configure && \
  make && \
  sudo make install

return_to_script_dir

# Build the MakeMKV backend/cli
curl -LO "${MAKEMKV_BIN_URL}" && \
  tar -xvf "${MAKEMKV_BIN_FILENAME}.tar.gz" && \
  cd "${MAKEMKV_BIN_FILENAME}" && \
  # Modify the eula script so it is "accepted" without user input
  sed '2iexit 0' ./src/ask_eula.sh > tmpfile && mv tmpfile ./src/ask_eula.sh && \
  make && \
  sudo make install
