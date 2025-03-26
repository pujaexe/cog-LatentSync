FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

RUN apt update && \
    apt install -y python3 python3-pip python3-dev \
    build-essential git ffmpeg cmake \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

# Set workdir
WORKDIR /app

# Copy requirements dan install
COPY requirements.txt .
RUN python3 -m pip install --upgrade pip && python3 -m pip install -r requirements.txt

# Copy seluruh kode
COPY . .

CMD ["python3", "predict.py"]
