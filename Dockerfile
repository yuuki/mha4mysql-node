FROM debian:8.5

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yq && \
    apt-get install -yq --no-install-recommends --fix-missing build-essential curl ca-certificates devscripts debhelper fakeroot perl && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN curl -L https://cpanmin.us | perl - --force App::cpanminus
RUN cpanm --force Module::Install

RUN mkdir -p /src
WORKDIR /src
COPY ./ /src
RUN debuild --no-tgz-check -us -uc 

CMD ["cat", "/mha4mysql-node_0.57-0_all.deb"]
