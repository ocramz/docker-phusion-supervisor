FROM phusion/baseimage

MAINTAINER Marco Zocca, zocca marco gmail

## supervisord
RUN apt-get update && \
    apt-get install -y python-meld3 python-setuptools supervisor && \
    easy_install pip && \
    pip install supervisor-logging && \
    mkdir -p /var/log/supervisor
    
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/supervisord/bin/start.sh /opt/supervisor/bin/

RUN echo "/opt/qnib/supervisor/bin/start.sh" >> /root/.bash_history && \
    echo "tail -f /var/log/supervisor/" >> /root/.bash_history && \
    echo "supervisorctl status" >> /root/.bash_history
    
CMD ["/opt/supervisord/bin/start.sh", "-n"]


# # # clean temp data
RUN sudo apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*