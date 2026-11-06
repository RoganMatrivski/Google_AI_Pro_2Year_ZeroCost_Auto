# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies required for Playwright / Chromium
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    libglib2.0-0 \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libxcb1 \
    libxkbcommon0 \
    libasound2 \
    libpango-1.0-0 \
    libcairo2 \
    libx11-6 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libgbm-dev \
    libpangoft2-1.0-0 \
    libfreetype6 \
    libharfbuzz0b \
    && rm -rf /var/lib/api/lists/* \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file and install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# Install playwright browsers
RUN python -m playwright install --with-deps

# Copy the rest of the application code
COPY . .

# Expose the web console port
EXPOSE 8765

# Run app.py on container start
CMD ["python", "app.py"]
