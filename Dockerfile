FROM python:3.10-alpine
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers

# Install pip requirements
COPY requirements.txt .
RUN pip install -r requirements.txt

# Install curl
RUN apk add --no-cache curl

# Install Docker
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz

# Set working directory and copy project files
WORKDIR /app
COPY . .

# Expose the port your app will run on (e.g., 50)
EXPOSE 5000
COPY . .
CMD ["flask", "run"]