FROM python:3.7.10-alpine

RUN mkdir -p /app
COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN apk update && pip install --upgrade pip && \
    apk add --no-cache postgresql-dev && \
    apk add --no-cache --virtual .build-deps gcc g++ libc-dev make git libffi-dev openssl-dev python3-dev libxml2-dev libxslt-dev musl-dev openssl-dev cargo rust
RUN python3 -m pip install -r requirements.txt --no-cache-dir
RUN apk --purge del .build-deps
COPY . /app
ENV DB_PORT=5432
ENV DATABASE=amigle
ENV PATH_CREDENTIALS=credentials/amigle-39424-firebase-adminsdk-7nylr-148a6f7ef2.json
ENV ALLOWED_EXTENSIONS='.png, .jpg'
ENV CLOUD_STORAGE_BUCKET=amigle-39424.appspot.com
ENV USERNAME=postgres
ENV PASSWORD=Amigle@1234
# ENV HOST=

EXPOSE 5000
CMD ["python","app.py"]
