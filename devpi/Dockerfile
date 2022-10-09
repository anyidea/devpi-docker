FROM python:3.9-alpine as build
LABEL maintainer="Aiden Lu <allaher@icloud.com>"

COPY ./devpi/requirements.txt .

RUN apk add --update gcc python3-dev libffi-dev musl-dev && \
    pip wheel --wheel-dir=/usr/src/app/wheels -r requirements.txt -i "https://mirrors.aliyun.com/pypi/simple/"


FROM python:3.9-alpine as run

COPY --from=build /usr/src/app/wheels  /wheels/

# use wheels to install python dependencies
RUN pip install --no-cache-dir --no-index --find-links=/wheels/ /wheels/* \
  && rm -rf /wheels/

COPY ./devpi/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["devpi-server"]