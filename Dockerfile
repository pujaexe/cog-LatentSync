FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

# 1. Hindari prompt interaktif
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta
ENV PATH="/usr/local/bin:/usr/bin:/bin"

# 2. Install Python 3.10 dan dependencies sistem
RUN apt-get update && apt-get install -y \
    software-properties-common curl git ffmpeg cmake libgl1 \
    python3.10 python3.10-dev python3.10-distutils \
    build-essential && \
    ln -sf /usr/bin/python3.10 /usr/bin/python && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python && \
    rm -rf /var/lib/apt/lists/*

# 3. Install cog dan Python requirements (global, no --user)
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && \
    pip install cog && \
    sed -i 's/numpy==1.26.3/numpy==1.24.4/' /tmp/requirements.txt && \
    pip install -r /tmp/requirements.txt

# 4. Copy semua file project
WORKDIR /code
COPY . .

# 5. Set entrypoint langsung ke cog global binary
ENTRYPOINT ["/usr/local/bin/cog", "serve"]
