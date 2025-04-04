#!/bin/bash

set -e  # Stop on error

echo "🐍 Upgrading pip & installing Python packages..."
pip install --upgrade pip
pip install -r requirements.txt
pip install torch torchvision torchaudio diffusers accelerate omegaconf ffmpeg-python

echo "📦 Installing system dependencies..."
apt update && apt install -y ffmpeg nano

echo "⚙️ Running setup_env.sh..."
source setup_env.sh

echo "📁 Downloading checkpoints..."
mkdir -p checkpoints
wget -O checkpoints/model.tar https://weights.replicate.delivery/default/chunyu-li/LatentSync/model.tar
tar -xf checkpoints/model.tar -C checkpoints

echo "📚 Setting PYTHONPATH..."
export PYTHONPATH=$(pwd)

echo "🧹 Patching attention.py to remove 'from turtle import forward'..."
ATTN_FILE="latentsync/models/attention.py"
if grep -q "from turtle import forward" "$ATTN_FILE"; then
    sed -i '/from turtle import forward/d' "$ATTN_FILE"
    echo "✅ Removed problematic line."
else
    echo "✅ No patch needed. Line not found."
fi

echo "🎉 Setup complete. You’re ready to run inference!"
