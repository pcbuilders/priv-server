FROM       ubuntu:16.10

ADD run.sh /run.sh

RUN chmod +x /run.sh \
    && mkdir -p /var/run/sshd \
    && apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get clean all

EXPOSE 22

CMD ["/run.sh"]
