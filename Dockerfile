FROM ubuntu:latest
RUN apt-get -y update
RUN apt-get install python3 git python3-pip -y
RUN apt-get update \
    && apt-get -y install libpq-dev gcc \
    && pip install psycopg2 \
    && rm -rf /root/.cache/pip/ \
    && find / -name '*.pyc' -delete \
    && find / -name '*__pycache__*' -delete
RUN pip3 install psycopg2-binary
RUN pip3 install -r requirements.txt
CMD python3 -m userbot
