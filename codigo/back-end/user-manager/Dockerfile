FROM python:3-alpine

RUN mkdir -p /app
COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN apk update && apk add gcc libc-dev make git libffi-dev openssl-dev python3-dev libxml2-dev libxslt-dev
COPY . /app
ENV PORT=5432
ENV DATABASE=amigle
ENV PATH_CREDENTIALS=credentials/amigle-39424-firebase-adminsdk-7nylr-148a6f7ef2.json
ENV ALLOWED_EXTENSIONS='.png, .jpg'
ENV CLOUD_STORAGE_BUCKET=amigle-39424.appspot.com
ENV USERNAME=postgres
ENV PASSWORD=
ENV HOST=

EXPOSE 5000
CMD ["python","app.py"]
