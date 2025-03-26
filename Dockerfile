FROM r8.im/cog/cog:py310-cu118-ubuntu20.04

# Install dependencies
COPY requirements.txt /code/requirements.txt
RUN pip install --upgrade pip && \
    pip install -r /code/requirements.txt

# Copy project files
COPY . /code

# Set working directory
WORKDIR /code

# Set default command
ENTRYPOINT ["cog", "serve"]
