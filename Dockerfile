FROM alpine:3.7

LABEL maintainer "admin@tcolbert.net"

RUN apk add --no-cache shadow su-exec curl
# Goss healthcheck

RUN curl -L -o /usr/local/bin/goss https://github.com/aelsabbahy/goss/releases/download/v0.3.0/goss-linux-amd64 && chmod +x /usr/local/bin/goss

HEALTHCHECK --interval=1s --timeout=6s CMD goss -g /goss/goss.yaml validate

RUN mkdir goss && cd goss && goss -g /goss/goss.yaml autoadd su-exec

# Add base entrypoint script for sub images to point to
COPY docker-entrypoint.sh /usr/local/bin/

RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
