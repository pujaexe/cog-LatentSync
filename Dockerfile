FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Set timezone dan suppress interaksi dialog
ENV TZ=Asia/Jakarta
ENV DEBIAN_FRONTEND=noninteractive

# Install Python dan sistem package
RUN apt-get update && apt-get install -y \
    tzdata python3 python3-pip ffmpeg libgl1 git \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && rm -rf /var/lib/apt/lists/*

# Salin dan install dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && pip install -r /tmp/requirements.txt

# Salin semua kode ke container
COPY . /code
WORKDIR /code
