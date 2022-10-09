FROM nginx:1.23-alpine
MAINTAINER Aiden Lu <allaher@icloud.com>

COPY ./nginx/nginx.conf /etc/nginx/

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]