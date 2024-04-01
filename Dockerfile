FROM python:3.10-alpine
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers

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