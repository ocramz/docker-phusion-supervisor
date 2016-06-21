FROM phusion/baseimage

## supervisord
RUN apt-get update && \
    apt-get install -y python-meld3 supervisor && \
    pip install supervisor-logging && \
    mkdir -p /var/log/supervisor
    
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/supervisord/bin/start.sh /opt/supervisor/bin/

RUN echo "/opt/qnib/supervisor/bin/start.sh" >> /root/.bash_history && \
    echo "tail -f /var/log/supervisor/" >> /root/.bash_history && \
    echo "supervisorctl status" >> /root/.bash_history
    
CMD ["/opt/supervisord/bin/start.sh", "-n"]