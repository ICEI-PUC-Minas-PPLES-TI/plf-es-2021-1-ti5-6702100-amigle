FROM python:3.8.5-alpine

RUN mkdir -p /app
COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN apk add --no-cache postgresql-libs && apk add --no-cache --virtual .build-deps gcc g++ musl-dev postgresql-dev 
RUN python3 -m pip install -r requirements.txt --no-cache-dir
RUN apk --purge del .build-deps
COPY . /app
ENV PORT=5432
ENV DATABASE=amigle
ENV PATH_CREDENTIALS=credentials/amigle-39424-firebase-adminsdk-7nylr-148a6f7ef2.json
ENV ALLOWED_EXTENSIONS='.png, .jpg'
ENV CLOUD_STORAGE_BUCKET=amigle-39424.appspot.com
ENV USERNAME=postgres
#ENV PASSWORD=
#ENV HOST=

EXPOSE 5000
CMD ["python","app.py"]
