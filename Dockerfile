FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Hindari interaktif prompt dari tzdata
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

# Install Python dan sistem dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    tzdata \
    python3 \
    python3-pip \
    ffmpeg \
    libgl1 \
    git && \
    rm -f /usr/bin/python /usr/bin/pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip && \
    rm -rf /var/lib/apt/lists/*

# Salin dan install Python dependencies
COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --upgrade pip && \
    python -m pip install -r /tmp/requirements.txt

# Salin semua kode
COPY . /code
WORKDIR /code
