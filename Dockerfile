FROM nginx

RUN apt-get update && \
    apt-get install -y --force-yes wget apache2-utils && \
    apt-get clean

RUN wget \
    --no-check-certificate \
    --output-document=/usr/local/bin/confd \
    https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 && \
    chmod +x /usr/local/bin/confd

RUN mkdir -p /etc/confd/{conf.d,templates}
COPY conf.d /etc/confd/conf.d
COPY templates /etc/confd/templates
COPY scripts/ /usr/local/bin

RUN rm /etc/nginx/conf.d/*
COPY nginx /etc/nginx

EXPOSE 80

CMD ["/usr/local/bin/boot.sh"]
