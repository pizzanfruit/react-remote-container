FROM <temporarily_redacted>

# Configure and install chrome
RUN amazon-linux-extras enable docker \
    && yum install -y git hostname iproute docker \
    && yum clean -y all \
    && rm -fr /var/cache/yum

ENV DOCKER_HOST=host.docker.internal

# Add init Script
ADD post-create.sh /post-create.sh
