FROM blitznote/debootstrap-amd64:16.04

RUN curl -s https://packagecloud.io/install/repositories/varnishcache/varnish5/script.deb.sh | bash \
 && apt-get install -qy varnish \
 && rm -rf /var/lib/apt/lists/*
 
ENV VCL_CONFIG      /etc/varnish/default.vcl
ENV CACHE_SIZE      64m
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600

EXPOSE 80

CMD varnishd -F -u varnish -f $VCL_CONFIG -s malloc,$CACHE_SIZE $VARNISHD_PARAMS"
