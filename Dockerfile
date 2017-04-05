FROM blitznote/debootstrap-amd64:16.04

RUN curl -s https://packagecloud.io/install/repositories/varnishcache/varnish5/script.deb.sh | bash \
 && apt-get install -qy varnish \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /varnishconf

WORKDIR /varnishconf

VOLUME /varnishconf

EXPOSE 80 6082

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["'ln -sf /varnishconf/varnish /etc/default/varnish; ln -sf /varnishconf/default.vcl /etc/varnish/default.vcl; service varnish restart && /bin/sh'"]
