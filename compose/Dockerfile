FROM python:3.10-alpine
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers

# Install necessary packages for Docker installation
RUN apt-get update \
    && apt-get install -y \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the repository
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
RUN apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io

# Install pip requirements
COPY requirements.txt .
RUN pip install -r requirements.txt

# Set working directory and copy project files
WORKDIR /app
COPY . .

# Expose the port your app will run on (e.g., 50)
EXPOSE 5000
COPY . .
CMD ["flask", "run"]