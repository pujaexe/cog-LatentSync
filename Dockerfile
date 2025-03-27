FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

# 1. Hindari prompt interaktif
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta
ENV PATH="/root/.local/bin:$PATH"

# 2. Install Python 3.10 dan sistem packages
RUN apt-get update && apt-get install -y \
    software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && apt-get install -y \
    python3.10 python3.10-dev python3.10-distutils \
    build-essential git ffmpeg cmake libgl1 curl && \
    ln -sf /usr/bin/python3.10 /usr/bin/python && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python && \
    rm -rf /var/lib/apt/lists/*

# 3. Install cog dan requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && \
    pip install cog && \
    sed -i 's/numpy==1.26.3/numpy==1.24.4/' /tmp/requirements.txt && \
    pip install -r /tmp/requirements.txt

# 4. Copy semua kode
WORKDIR /code
COPY . .

# 5. Jalankan cog serve
ENTRYPOINT ["cog", "serve"]
