#  creates a layer from the base Docker image.
FROM python:3.9.5-slim-buster

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
    wget \
    libmagic-dev

# to resynchronize the package index files from their sources.
RUN apt -qq update



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

# each instruction creates one layer
# Only the instructions RUN, COPY, ADD create layers.
# copies 'requirements', to inside the container
# ..., there are multiple '' dependancies,
# requiring the use of the entire repo, hence
# adds files from your Docker client’s current directory.
COPY . .

# install requirements, inside the container
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt

# specifies what command to run within the container.
CMD ["bash", "start"]
