FROM node:12-slim

RUN apt-get update && apt-get install -y ca-certificates curl \
		--no-install-recommends

EXPOSE 8081

WORKDIR /app

COPY . /app

RUN cp config.default.js config.js

RUN npm install

RUN npm run build

CMD ["npm", "start"]
