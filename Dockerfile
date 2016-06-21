FROM phusion/baseimage

## supervisord
RUN apt-get update && \
    apt-get install -y python-meld3 supervisor && \
    pip install supervisor-logging && \
    mkdir -p /var/log/supervisor
    
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/supervisord/bin/start.sh /opt/supervisor/bin/
