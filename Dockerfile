FROM python:3.10
WORKDIR /app
COPY . /app/

RUN pip intall -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["python"]
CMD ["flask_app.py"]