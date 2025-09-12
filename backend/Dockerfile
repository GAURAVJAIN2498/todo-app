FROM python:3.11-slim
WORKDIR /app
COPY requirement.txt .
RUN pip install -r requirement.txt
COPY . .
CMD ["gunicorn", "backend.wsgi:application", "--bind", "0.0.0.0:8000"]

