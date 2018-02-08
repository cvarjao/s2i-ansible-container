FROM       docker.io/ansible/ansible-container-builder:0.3
MAINTAINER Samuel Terburg <sterburg@redhat.com>
LABEL      io.k8s.description="Build Docker Images using Ansible Playbook" \
           io.k8s.display-name="Ansible-Container S2I Image" \
           io.openshift.tags="builder,ansible" \
           io.openshift.s2i.scripts-url=image:///usr/libexec/s2i \
           io.s2i.scripts-url=image:///usr/libexec/s2i

RUN         pip install docker docker-py ansible-container[docker] && \
            chmod -R a+rwX /etc/ansible/roles \
                           /usr/lib/python2.7/site-packages

COPY        bin/  /usr/libexec/s2i/

CMD         /usr/libexec/s2i/assemble

USER        1001
