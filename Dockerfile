FROM ubuntu:18.10

RUN sed -ri 's@http://(archive|security).ubuntu.com@http://old-releases.ubuntu.com@g' /etc/apt/sources.list
RUN apt-get update &&  \
    apt-get install -y \
    build-essential libssl-dev zlib1g-dev wget unzip \
    postgresql-server-dev-10

RUN wget --no-check-certificate -q -O pg_repack.zip "https://api.pgxn.org/dist/pg_repack/1.4.6/pg_repack-1.4.6.zip"
RUN unzip pg_repack.zip && rm pg_repack.zip

WORKDIR pg_repack-1.4.6
RUN make && make install

WORKDIR /
RUN rm -rf pg_repack-*

CMD bash
