FROM python:3.10.0-slim-buster

WORKDIR /app

# https://shouldiblamecaching.com/
ENV PIP_NO_CACHE_DIR 1

# http://bugs.python.org/issue19846
# https://github.com/SpEcHiDe/PublicLeech/pull/97
ENV LANG C.UTF-8

# we don't have an interactive xTerm
ENV DEBIAN_FRONTEND noninteractive

# fix "ephimeral" / "AWS" file-systems
RUN sed -i.bak 's/us-west-2\.ec2\.//' /etc/apt/sources.list

# to resynchronize the package index files from their sources.
RUN apt -qq update

# base required pre-requisites before proceeding ...
RUN apt -qq install -y --no-install-recommends \
    curl \
    git \
    gnupg2 \
    unzip \
    wget

# to resynchronize the package index files from their sources.
RUN apt -qq update

#youtube-dl
RUN  curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && \
    chmod a+rx /usr/local/bin/youtube-dl

# install required packages
RUN apt -qq install -y --no-install-recommends \
    # this package is required to fetch "contents" via "TLS"
    apt-transport-https \
    # install coreutils
    build-essential coreutils jq pv \
    # install gcc [ PEP 517 ]
    gcc \
    # install encoding tools
    ffmpeg mediainfo \
    unzip zip \
    # miscellaneous helpers
    megatools && \
    # clean up the container "layer", after we are done
    rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp


COPY . .

# install requirements, inside the container
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt


# specifies what command to run within the container.
CMD ["bash", "start"]