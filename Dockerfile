FROM phusion/baseimage

MAINTAINER Marco Zocca, zocca marco gmail

# consul-template version
ENV CT_VER 0.14.0 

# TLS keypair directory
ENV TLS_KP_DIR ${HOME}/.tls_certs
RUN mkdir -p ${TLS_KP_DIR}


## supervisord
RUN apt-get update && \
    apt-get install -y --no-install-recommends bsdtar curl python-meld3 python-setuptools supervisor && \
    easy_install pip && \
    pip install supervisor-logging && \
    mkdir -p /var/log/supervisor
    
ADD etc/supervisord.conf /etc/supervisord.conf
ADD opt/supervisord/bin/start.sh /opt/supervisor/bin/

RUN echo "/opt/qnib/supervisor/bin/start.sh" >> /root/.bash_history && \
    echo "tail -f /var/log/supervisor/" >> /root/.bash_history && \
    echo "supervisorctl status" >> /root/.bash_history



# consul-template
RUN curl -Lsf https://releases.hashicorp.com/consul-template/${CT_VER}/consul-template_${CT_VER}_linux_amd64.zip | bsdtar xf - -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/consul-template
    

CMD ["/opt/supervisord/bin/start.sh", "-n"]


# # # clean temp data
RUN sudo apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*