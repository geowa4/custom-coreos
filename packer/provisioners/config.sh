#!/usr/bin/env bash
set -e

# pull common images
docker pull geowa4/coreos-toolbox
docker pull geowa4/fluentd
docker pull skynetservices/skydns
docker pull gliderlabs/registrator

# add users
useradd -p '*' -U -m peripheral -G sudo,docker,fleet -s /usr/bin/toolbox
mv /tmp/users/toolboxrc /home/peripheral/.toolboxrc
chown peripheral /home/peripheral/.toolboxrc

# configure cluster environment
touch /etc/environment_cluster
cat >> /etc/environment_cluster <<EOC
AWS_REGION=$AWS_REGION
LOGGING_HOST=$LOGGING_HOST
LOGGING_PORT=$LOGGING_PORT
EOC

# configure services
mv /tmp/units/* /etc/systemd/system
mkdir /etc/systemd/system/etcd2.service.d
mkdir /etc/systemd/system/flanneld.service.d
mkdir /etc/systemd/system/docker.service.d
mv /tmp/drop-ins/etcd2.conf /etc/systemd/system/etcd2.service.d/20-proxy.conf
mv /tmp/drop-ins/flanneld.conf /etc/systemd/system/flanneld.service.d/50-network-config.conf
mv /tmp/drop-ins/docker.conf /etc/systemd/system/docker.service.d/10-docker-requires-flannel.conf

# enable services
systemctl enable etcd2
systemctl enable flanneld
systemctl enable docker
systemctl enable skydns.service
systemctl enable fluentd.service
systemctl enable etcd-registrator.service
