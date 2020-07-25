#
#   Copyright (C) 2017-2018 Philipp Paulweber
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

RUN apk add --no-cache \
    bash \
    make \
    maven \
 && rm -rf /var/cache/apk/*

CMD ["/bin/sh"]
