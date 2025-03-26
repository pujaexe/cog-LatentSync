FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Supaya tidak macet saat install
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

# Install dependencies sistem
RUN apt update && \
    apt install -y python3 python3-pip python3-dev \
    build-essential git ffmpeg cmake \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

# Set direktori kerja
WORKDIR /code

# Copy requirements dan install
COPY requirements.txt .
# Fix numpy: gunakan versi kompatibel dengan Python 3.8
RUN sed -i 's/numpy==1.26.3/numpy==1.24.4/' requirements.txt && \
    python3 -m pip install --upgrade pip && \
    pip install cog && \
    python3 -m pip install -r requirements.txt
    

# Copy seluruh source code
COPY . .

# Dengan ini, agar cocok dengan config cog.yaml:
ENTRYPOINT ["cog", "serve"]
