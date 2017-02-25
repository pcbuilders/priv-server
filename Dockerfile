FROM       ubuntu:16.10

RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server dropbear nginx aria2 \
    && sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && echo "ClientAliveInterval 5\nClientAliveCountMax 120\n" >> /etc/ssh/sshd_config \
    && sed -ri 's/NO_START=1/NO_START=0/g' /etc/default/dropbear \
    && sed -ri 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get clean all

EXPOSE 22 80 443

CMD for i in ssh dropbear nginx; do service $i start; done \
    && echo "root:$ROOT_PASS" | chpasswd
