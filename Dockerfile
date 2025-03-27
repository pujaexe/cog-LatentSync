FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

# Install Python 3.10 dan tool
RUN apt-get update && apt-get install -y \
    software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && apt-get install -y \
    python3.10 python3.10-dev python3.10-distutils \
    build-essential git ffmpeg cmake libgl1 curl && \
    ln -sf /usr/bin/python3.10 /usr/bin/python && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python && \
    rm -rf /var/lib/apt/lists/*

# Install cog + requirements (global install)
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && \
    pip install cog && \
    sed -i 's/numpy==1.26.3/numpy==1.24.4/' /tmp/requirements.txt && \
    pip install -r /tmp/requirements.txt

WORKDIR /code
COPY . .

ENTRYPOINT ["cog", "serve"]
