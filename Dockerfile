FROM node:12-slim

# grab tini for signal processing and zombie killing
ENV TINI_VERSION 0.9.0
RUN set -x \
	&& apt-get update && apt-get install -y ca-certificates curl \
		--no-install-recommends \
	&& apt-get install -y gpg \
	&& curl -fSL "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini" -o /usr/local/bin/tini \
	&& curl -fSL "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini.asc" -o /usr/local/bin/tini.asc \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 6380DC428747F6C393FEACA59A84159D7001A4E5 \
	&& gpg --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini \
	&& rm -r "$GNUPGHOME" /usr/local/bin/tini.asc \
	&& chmod +x /usr/local/bin/tini \
	&& tini -h \
	&& apt-get purge --auto-remove -y ca-certificates curl \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 8081

WORKDIR /app

COPY . /app

RUN cp config.default.js config.js

RUN set -x \
	&& apt-get update && apt-get install -y git --no-install-recommends \
	&& npm install \
	&& apt-get purge --auto-remove -y git \
	&& rm -rf /var/lib/apt/lists/*

RUN npm run build

CMD ["tini", "--", "npm", "start"]
