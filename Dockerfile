FROM alpine:3.7

COPY ./bin/entry.sh /usr/local/bin/

RUN apk --no-cache add varnish \
 && mkdir /varnishconf \
 && cp /etc/conf.d/varnishd /varnishconf/varnishd \
 && cp /etc/varnish/default.vcl /varnishconf/default.vcl \
 && ln -fs /varnishconf/varnishd /etc/conf.d/varnishd \
 && ln -fs /varnishconf/default.vcl /etc/varnish/default.vcl \
 && chown -R varnish:varnish /varnishconf \
 && chmod ugo+x /usr/local/bin/entry.sh

VOLUME /varnishconf

EXPOSE 80 6082

CMD ["entry.sh"]
