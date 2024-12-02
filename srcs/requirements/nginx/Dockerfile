FROM alpine:3.16

RUN apk update && apk upgrade && apk add --no-cache nginx openssl

COPY ./requirements/nginx/tools/en.sh /en.sh

RUN chmod +x /en.sh

EXPOSE 443

CMD ["/en.sh"]