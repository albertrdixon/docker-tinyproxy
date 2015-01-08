User {{ USER }}
Group {{ GROUP }}
Port {{ PORT }}
Timeout {{ TIMEOUT }}

XTinyproxy Yes
ViaProxyName "tinyproxy"

ConnectPort 443
ConnectPort 563

DefaultErrorFile "/usr/share/tinyproxy/default.html"

StatHost "tinyproxy.stats"
StatFile "/usr/share/tinyproxy/stats.html"

Logfile "{{ LOG_FILE }}"
LogLevel {{ LOG_LEVEL|capitalize }}

PidFile "/var/run/tinyproxy/tinyproxy.pid"

MaxClients {{ MAX_CLIENTS }}
MinSpareServers {{ MIN_SPARE_SERVERS }}
MaxSpareServers {{ MAX_SPARE_SERVERS }}
StartServers {{ START_SERVERS }}
MaxRequestsPerChild {{ MAX_REQUESTS_PER_CHILD }}

{% if ALLOW is defined %}
{% set allowed = ALLOW %}
{% for ip in allowed.split(",") %}
Allow {{ ip }}
{% endfor %}
{% endif %}

{% if UPSTREAM_PORT is defined %}
Upstream {{ UPSTREAM_PORT|replace("tcp://", "") }}
{% endif %}
{% if UPSTREAM_ADDR is defined %}
Upstream {{ UPSTREAM_ADDR }}
{% endif %}

{% if REVERSE_PATH is defined %}
{% set revpath = REVERSE_PATH %}
{% for rp in revpath.split(",") %}
ReversePath "/{{ rp.split("|")|first }}/" "{{ rp.split("|")|last }}/"
{% endfor %}
ReverseOnly Yes
ReverseMagic Yes
{% if REVERSE_BASE_URL is defined %}
ReverseBaseURL "{{ REVERSE_BASE_URL }}"
{% endif %}
{% endif %}