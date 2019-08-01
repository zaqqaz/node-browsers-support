FROM openjdk:8

RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    curl \
    gnupg2

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
    yarn \
    netcat \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get -y update
RUN apt-get install -y unzip xvfb libxi6 libgconf-2-4 make gcc g++ python
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add
RUN echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

RUN set -x \
    && apt-get update \
    && apt-get install -y \
    google-chrome-stable

RUN mkdir -p /opt/workspace && mkdir -p /opt/target-build

WORKDIR /opt/target-build

COPY . .

ENV PATH=$PATH:/opt/target-build/bin

WORKDIR /opt/workspace
