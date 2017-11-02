FROM blitznote/debootstrap-amd64:17.04

RUN curl -s https://packagecloud.io/install/repositories/varnishcache/varnish5/script.deb.sh | bash \
 && apt-get install -qy varnish \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir /varnishconf \
 && cp /etc/default/varnish /varnishconf/varnish \
 && cp /etc/varnish/default.vcl /varnishconf/default.vcl

WORKDIR /varnishconf

VOLUME /varnishconf

EXPOSE 80 6082

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["ln -sf /varnishconf/varnish /etc/default/varnish; ln -sf /varnishconf/default.vcl /etc/varnish/default.vcl; service varnish restart && /bin/sh"]
