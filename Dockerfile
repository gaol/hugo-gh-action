FROM asciidoctor/docker-asciidoctor

LABEL maintainer="Leo Gao <aoingl@gmail.com>"
LABEL com.github.actions.name="Hugo Asciidoctor Action"
LABEL com.github.actions.description="Action to generate static website using hugo and asciidoctor"
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="blue"

RUN apk add --update git libc6-compat libstdc++ \
    && apk upgrade \
    && apk add --no-cache ca-certificates

ENV HUGO_VERSION=0.67.0
ENV HUGO_TYPE=_extended
ENV HUGO_ID=hugo${HUGO_TYPE}_${HUGO_VERSION}
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_ID}_Linux-64bit.tar.gz /tmp
RUN tar -xf /tmp/${HUGO_ID}_Linux-64bit.tar.gz -C /tmp \
    && mkdir -p /usr/local/sbin \
    && mv /tmp/hugo /usr/local/sbin/hugo \
    && rm -rf /tmp/${HUGO_ID}_linux_amd64 \
    && rm -rf /tmp/${HUGO_ID}_Linux-64bit.tar.gz \
    && rm -rf /tmp/LICENSE.md \
    && rm -rf /tmp/README.md

ENTRYPOINT ["/usr/local/sbin/hugo"]
