FROM       docker.io/ansible/ansible-container-builder:0.3
MAINTAINER Samuel Terburg <sterburg@redhat.com>
LABEL      io.k8s.description="Build Docker Images using Ansible Playbook" \
           io.k8s.display-name="Ansible-Container S2I Image" \
           io.openshift.tags="builder,ansible" \
           io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
           io.s2i.scripts-url=image:///usr/libexec/s2i

USER 0

RUN         source /opt/app-root/etc/scl_enable && source /opt/app-root/bin/activate && \
            pip install -U pip setuptools && \
            pip install ansible docker docker-py ansible-container[docker,openshift] && \
            mkdir -p /etc/ansible/roles && chmod -R a+rwX /etc/ansible/roles \
                           /usr/lib/python2.7/site-packages

COPY        bin/  /usr/libexec/s2i/

CMD         /usr/libexec/s2i/assemble

USER        1001
