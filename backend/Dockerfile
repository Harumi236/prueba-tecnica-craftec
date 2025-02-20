# Use a lightweight Python image for production
FROM python:3.9

# Prevent Python from buffering stdout/stderr
ENV PYTHONUNBUFFERED=1

# Install necessary dependencies
RUN apt-get update && apt-get install -y netcat-openbsd

# Set working directory
WORKDIR /app

# Copy dependency file and install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the application code into the container
COPY . /app/

# Copy the production entrypoint script and make it executable
COPY entrypoint.sh /app/
RUN chmod +x entrypoint.sh

# Expose the port Gunicorn will use
EXPOSE 8000

# Run the production entrypoint
CMD ["sh", "entrypoint.sh"]
