FROM asciidoctor/docker-asciidoctor

LABEL maintainer="aoingl@gmail.com"

RUN apk add --update git libc6-compat libstdc++ \
    && apk upgrade \
    && apk add --no-cache ca-certificates

LABEL com.github.actions.name="Hugo Asciidoctor Action"
LABEL com.github.actions.description="Action to generate static website using hugo and asciidoctor"

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

VOLUME /src
VOLUME /output

WORKDIR /src

EXPOSE 1313

ENTRYPOINT ["/usr/local/sbin/hugo", "--source", "/src", "--destination", "/output"]

