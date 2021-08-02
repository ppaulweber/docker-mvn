#
#   Copyright (C) 2020 Philipp Paulweber
#   All rights reserved.
#
#   Developed by: Philipp Paulweber
#                 <https://github.com/ppaulweber/docker-mvn>
#
#   This file is part of docker-mvn.
#
#   docker-mvn is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   docker-mvn is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with docker-mvn. If not, see <http://www.gnu.org/licenses/>.
#

FROM openjdk:14-jdk-alpine3.10

RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/v3.13/main \
    git \
    bash \
    flex \
    flex-dev \
    bison \
    autoconf \
    wget \
    make \
    cmake \
    ccache \
    gcc \
    g++ \
    musl-dev \
    ncurses5 \
    python3 \
    valgrind \
    curl \
    zip \
    unzip \
    libelf \
 && rm -rf /var/cache/apk/*

RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/v3.13/community \
    perf \
    hyperfine \
    yq \
    z3 \
 && rm -rf /var/cache/apk/*

RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/v3.11/main \
    ninja \
 && rm -rf /var/cache/apk/*

# RUN echo "x86" > /etc/apk/arch \
#  && apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/TAG/REPO \
#     libelf \
#  && echo "x86_64" > /etc/apk/arch \
#  && rm -rf /var/cache/apk/*

RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/main \
    ccache \
 && rm -rf /var/cache/apk/*

RUN wget -c https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.0/clang+llvm-10.0.0-x86_64-linux-sles11.3.tar.xz \
 && tar xvf /clang+llvm-10.0.0-x86_64-linux-sles11.3.tar.xz \
 && cp -rvf /clang+llvm-10.0.0-x86_64-linux-sles11.3/* /usr/local/ \
 && rm -rf  /clang+llvm-10.0.0-x86_64-linux-sles11.3*

RUN wget -c https://github.com/sbt/sbt/releases/download/v1.5.5/sbt-1.5.5.zip \
 && unzip   /sbt-1.5.5.zip \
 && cp -rvf /sbt/* /usr/local/ \
 && rm -rf  /sbt sbt-1.5.5.zip \
 && sbt --version

RUN wget -c https://archive.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz -O - | tar -xz \
 && cp -rvf /apache-maven-3.6.0/* /usr/local/ \
 && rm -rf  /apache-maven-3.6.0 \
 && mvn --version

RUN wget -c https://www.veripool.org/ftp/verilator-4.108.tgz -O - | tar -xz \
 && cd /verilator-4.108 \
 && ./configure --prefix=/usr \
 && make \
 && make install -j4 \
 && rm -rf /verilator* \
 && verilator --version

COPY .m2 /root/.m2

COPY .gw /root/.gw

COPY .lock-linking /usr/bin/lock-linking

RUN chmod 755 /usr/bin/lock-linking \
 && (cd /root/.gw; ./gradlew --version)

CMD ["/bin/sh"]
