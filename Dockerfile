FROM python:3.6.8-stretch

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends default-libmysqlclient-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt /
RUN pip install -r /requirements.txt

VOLUME /apa
WORKDIR /apa

ENTRYPOINT ["./apa.py"]
