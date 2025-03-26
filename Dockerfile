FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Set non-interaktif agar tzdata tidak meminta input
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

# Install Python dan package lainnya
RUN apt-get update && \
    apt-get install -y tzdata python3 python3-pip ffmpeg libgl1 git && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip && \
    rm -rf /var/lib/apt/lists/*
    
# Copy requirements dan install dependencies
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && pip install -r /tmp/requirements.txt

# Copy seluruh kode ke container
COPY . /code
WORKDIR /code
