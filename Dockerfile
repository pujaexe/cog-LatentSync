FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Install Python, pip, dan dependencies dasar
RUN apt update && \
    apt install -y python3-pip git ffmpeg && \
    ln -s /usr/bin/python3 /usr/bin/python

# Copy dan install python requirements
COPY requirements.txt /code/requirements.txt
RUN pip install --upgrade pip && pip install -r /code/requirements.txt

# Copy semua kode
COPY . /code
WORKDIR /code

# Jalankan inference server (atau ganti sesuai script kamu)
CMD ["python", "predict.py"]
