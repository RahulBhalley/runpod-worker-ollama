ARG OLLAMA_VERSION=0.12.10
FROM ollama/ollama:${OLLAMA_VERSION}

ENV PYTHONUNBUFFERED=1 \
    OLLAMA_NUM_GPU=99 \
    OLLAMA_NUM_BATCH=512 \
    OLLAMA_NUM_THREAD=8 \
    OLLAMA_FLASH_ATTENTION=1 \
    OLLAMA_MODELS=/runpod-volume \
    PORT_HEALTH=8080

WORKDIR /

RUN apt-get update --yes --quiet && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --quiet --no-install-recommends \
    software-properties-common gpg-agent build-essential apt-utils && \
    apt-get install --reinstall ca-certificates && \
    add-apt-repository --yes ppa:deadsnakes/ppa && apt update --yes --quiet && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --quiet --no-install-recommends \
    python3.11 python3.11-dev python3.11-distutils \
    python3.11-lib2to3 python3.11-gdbm python3.11-tk \
    bash curl && \
    ln -s /usr/bin/python3.11 /usr/bin/python && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY ./src /work

EXPOSE 11434 8080

RUN pip install -r requirements.txt && chmod +x /work/start.sh

ENTRYPOINT ["/bin/sh", "-c", "/work/start.sh"]
