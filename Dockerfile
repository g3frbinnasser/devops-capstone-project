FROM python:3.9-slim

# Create a working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code
COPY . .

# Create a non-root user for security and change ownership of the app directory
RUN useradd -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

# Expose port 8080
EXPOSE 8080

# Run the application using gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "service:app"]
