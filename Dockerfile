FROM python:3.6.8-stretch

COPY requirements.txt /
RUN apt install libmysql-dev
RUN pip install -r /requirements.txt

VOLUME /apa
WORKDIR /apa

ENTRYPOINT ["./apa.py"]
