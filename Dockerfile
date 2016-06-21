FROM phusion

## supervisord
RUN apt-get install -y python-meld3 supervisor && \
    pip install supervisor-logging && \
    mkdir -p /var/log/supervisor
    
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/supervisor/bin/start.sh /opt/supervisor/bin/
