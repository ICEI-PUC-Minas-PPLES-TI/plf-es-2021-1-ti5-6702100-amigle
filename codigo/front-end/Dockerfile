FROM node:alpine as builder
RUN mkdir -p /usr/src/app
ADD package*.json /usr/src/app
ADD rollup.config.js /usr/src/app 
WORKDIR /usr/src/app
RUN npm install
ADD . .

FROM builder as packager
RUN npm run build

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=packager /usr/src/app/public .
