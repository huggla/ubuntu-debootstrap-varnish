#!/bin/sh
ln -sf /varnishconf/varnish /etc/default/varnish
ln -sf /varnishconf/default.vcl /etc/varnish/default.vcl
service varnish restart && /bin/sh
