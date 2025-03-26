FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Supaya tidak macet saat install tzdata
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Jakarta

# Install Python, pip, git, ffmpeg, dan timezone fix
RUN apt update && \
    apt install -y tzdata python3-pip git ffmpeg && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    rm -rf /var/lib/apt/lists/*

# Copy dan install python requirements
COPY requirements.txt /code/requirements.txt
RUN pip3 install --upgrade pip && pip3 install -r /code/requirements.txt

# Copy semua kode ke dalam container
COPY . /code
WORKDIR /code

# Jalankan inference server (ganti jika pakai cog)
CMD ["python", "predict.py"]
