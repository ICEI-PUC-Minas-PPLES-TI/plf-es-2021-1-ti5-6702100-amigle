FROM cirrusci/flutter as builder

RUN flutter channel beta
RUN flutter upgrade
RUN flutter config --enable-web
RUN mkdir -p /usr/src/app
ADD . /usr/src/app/

FROM builder as packager
WORKDIR /usr/src/app
RUN flutter build web

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=packager /usr/src/app/build/web .
