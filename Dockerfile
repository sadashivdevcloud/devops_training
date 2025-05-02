FROM python:3.9-slim
COPY . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
