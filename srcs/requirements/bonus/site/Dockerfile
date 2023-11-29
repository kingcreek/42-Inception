FROM debian:buster

RUN apt-get update && \
    apt-get install -y nodejs npm && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf /

CMD ["node", "run.js"]