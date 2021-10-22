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
RUN pip3 install telethon \
    cryptg \
    alive-progress \
    Pillow \
    PyDrive \
    PyPDF2 \
    aiofiles \
    aiohttp \
    aria2p \
    asyncio \
    beautifulsoup4 \
    cfscrape \
    coffeehouse \
    convertdate \
    covid \
    emoji \
    feedparser \
    google-api-python-client==1.7.11 \
    google_images_download \
    googletrans \
    gtts \
    gaggle \
    hachoir \
    httplib2>=0.18.0 \
    humanize \
    hurry.filesize \
    lxml \
    mtranslate \
    oauth2client==4.1.3 \
    pathlib \
    patool \
    psutil \
    psycopg2 \
    pySmartDL \
    pydownload \
    pysocks \
    python-barcode \
    python-magic \
    pytube3 \
    qrcode \
    regex \
    requests \
    setuptools \
    spamwatch \
    speedtest-cli \
    spotify_token \
    sqlalchemy \
    telegraph \
    tgcrypto \
    typing \
    unicode_tr \
    urbandict \
    urllib3 \
    wget \
    wikipedia \
    pymongo  \
    dnspython \
    youtube-dl \
    soundcloud-lib \
    heroku3 \
    pyquery \
    natsort  \
    instaloader  \
    gpytranslate  \
    jsonpickle  \
    appdirs  \
    cchardet  \
    aiodns  \
    pygofile \
    mongoengine  \
    telemongo  \
RUN ['bash','start']
