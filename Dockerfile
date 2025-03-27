FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Hindari interaktif prompt
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

# Install system packages
RUN apt update && \
    apt install -y python3 python3-pip python3-dev \
    build-essential git ffmpeg cmake \
    && ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/pip3 /usr/bin/pip && \
    rm -rf /var/lib/apt/lists/*

# Set workdir
WORKDIR /code

# Copy requirements
COPY requirements.txt .

# Install pip & cog & project dependencies
RUN pip install --upgrade pip && \
    pip install cog && \                      # << INSTALL GLOBAL
    sed -i 's/numpy==1.26.3/numpy==1.24.4/' requirements.txt && \
    pip install -r requirements.txt

# Copy kode
COPY . .

# Jalankan cog API
ENTRYPOINT ["cog", "serve"]
