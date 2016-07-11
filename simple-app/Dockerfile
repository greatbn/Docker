FROM python:2.7.11-alpine
COPY app.py /home
RUN pip install flask
WORKDIR /home
EXPOSE 5000
ENTRYPOINT ["python","app.py"]
