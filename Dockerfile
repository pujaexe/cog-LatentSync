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

# Set PATH tambahan jika pip install --user digunakan
ENV PATH="/root/.local/bin:$PATH"

# Set direktori kerja
WORKDIR /code

# Copy requirements file
COPY requirements.txt .

# Install pip + cog + semua requirements
RUN python -m pip install --upgrade pip && \
    pip install --user cog && \
    sed -i 's/numpy==1.26.3/numpy==1.24.4/' requirements.txt && \
    pip install --user -r requirements.txt

# Copy semua kode
COPY . .

# Untuk verifikasi apakah cog sudah tersedia
ENTRYPOINT ["which", "cog"]
