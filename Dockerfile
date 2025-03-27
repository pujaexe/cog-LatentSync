FROM python:3.8-slim-buster

# Install dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and setuptools
RUN pip install --upgrade pip setuptools

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Install FastAPI and Uvicorn
RUN pip install fastapi uvicorn cog

# Copy application files
COPY . /app
WORKDIR /app

# Expose port 8080
EXPOSE 8080

# Command to run the API
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8080"]
