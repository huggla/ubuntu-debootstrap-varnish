FROM blitznote/debootstrap-amd64:17.04

COPY ./bin/entry.sh /usr/local/bin/

RUN curl -s https://packagecloud.io/install/repositories/varnishcache/varnish5/script.deb.sh | bash \
 && apt-get install -qy varnish \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir /varnishconf \
 && cp /etc/default/varnish /varnishconf/varnish \
 && cp /etc/varnish/default.vcl /varnishconf/default.vcl \
 && chmod ugo+x /usr/local/bin/entry.sh

WORKDIR /varnishconf

VOLUME /varnishconf

EXPOSE 80 6082

CMD ["entry.sh"]
