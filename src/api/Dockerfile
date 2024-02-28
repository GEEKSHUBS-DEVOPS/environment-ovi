FROM node:16-alpine As development
WORKDIR /usr/src/app
COPY package*.json ./
# Install yarn and other dependencies via apk
RUN apk add --update --no-cache g++ make python3 && ln -sf python3 /usr/bin/python && rm -rf /var/cache/apk/*
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN npm install --global node-gyp && npm install --only=development
COPY . .
RUN npm run build

FROM node:16-alpine as production
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}
WORKDIR /usr/src/app
COPY package*.json ./
# Install yarn and other dependencies via apk
RUN apk add --update --no-cache g++ make python3 && ln -sf python3 /usr/bin/python && rm -rf /var/cache/apk/*
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

RUN npm install --global node-gyp && npm install --only=production

COPY . .

COPY --from=development /usr/src/app/dist ./dist

CMD ["node", "dist/main"]

EXPOSE 3000