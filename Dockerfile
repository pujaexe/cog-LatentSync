FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Set timezone dan hindari interactive prompt
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

# Install Python, pip, git, dan dependencies sistem
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    tzdata \
    python3 \
    python3-pip \
    git \
    ffmpeg \
    libgl1 \
    && ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip && \
    rm -rf /var/lib/apt/lists/*

# Salin requirements.txt terlebih dahulu
COPY requirements.txt /tmp/requirements.txt

# Install Python dependencies
RUN python -m pip install --upgrade pip && \
    pip install --no-cache-dir -r /tmp/requirements.txt

# Copy seluruh source code ke dalam container
COPY . /code
WORKDIR /code
