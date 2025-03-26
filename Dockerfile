FROM r8.im/cog/cog:py310-cu118-ubuntu20.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies from requirements.txt
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && pip install -r /tmp/requirements.txt

# Copy entire repo
COPY . /code
WORKDIR /code

# Cog will handle `predict.py` and serving logic
