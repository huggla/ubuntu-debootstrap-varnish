FROM alpine:3.7

ENV JAIL="unix,user=varnish" \
    PID_FILE="/run/varnishd.pid" \
    VCL_FILE="/varnishconf/default.vcl" \
    READ_ONLY_PARAMS="cc_command,vcc_allow_inline_c,vmod_path" \
    LISTEN_ADDRESS="" \
    LISTEN_PORT="80" \
    MANAGEMENT_ADDRESS="localhost" \
    MANAGEMENT_PORT="6082" \
    STORAGE="malloc,100M" \
    DEFAULT_TTL="120" \
    SECRET_FILE="/etc/varnish/secret" \
    ADDITIONAL_OPTS="" 

COPY ./bin/entry.sh /usr/local/bin/entry.sh
COPY ./varnish-5.0-configuration-templates/default.vcl /varnishconf/default.vcl

RUN apk --no-cache add varnish \
 && chown -R varnish:varnish /varnishconf \
 && chmod ugo+x /usr/local/bin/entry.sh

USER varnish

VOLUME /varnishconf

EXPOSE $LISTEN_PORT $MANAGEMENT_PORT

CMD ["entry.sh"]
