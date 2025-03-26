FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Install dependencies OS
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    python3 python3-pip python3-dev \
    build-essential git ffmpeg cmake \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && rm -rf /var/lib/apt/lists/*

# Set working dir
WORKDIR /app

# Copy requirements first (agar cache tidak hilang)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy all source code
COPY . .

# Default command
CMD ["python", "predict.py"]
