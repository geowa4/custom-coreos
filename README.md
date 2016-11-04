Custom CoreOS AMI Builder
=========================

Create a custom AMI from CoreOS.

A few things are assumed, but these can be changed easily if desired.
- An AWS account,
- A 172.19.0.0/16 subnet,
- A known CoreOS AMI ID,
- A .env file as follows,
- An existing Elasticsearch cluster for log retention,
- And an existing etcd cluster as follows.

.env
```
AWS_ACCOUNT=
AWS_REGION=
BASE_AMI=
LOGGING_HOST=
LOGGING_PORT=
```

etcd cluster
```
ETCD_INITIAL_CLUSTER=etcd1=http://172.19.1.10:2380,etcd2=http://172.19.2.10:2380,etcd3=http://172.19.4.10:2380,etcd4=http://172.19.5.10:2380,etcd5=http://172.19.1.11:2380
```

To build the AMI, you will need to do a few things.

```
pushd packer
docker build -t packer .
docker run --rm --env-file .env packer
popd

pushd terraform
docker build -t terraform .
docker run --rm -v $(pwd):/usr/src/app --env-file .env terraform
popd

pushd serverspec
docker build -t serverspec .
docker run --rm -v /root/.ssh/id_rsa:/root/.ssh/id_rsa --add-host ami-test-instance:172.19.5.199 serverspec
popd

docker run --rm -v $(pwd):/usr/src/app --env-file .env terraform destroy -target aws_instance.ami_test -force || true
docker rmi packer || true
docker rmi terraform || true
docker rmi serverspec || true
```

[Packer](https://packer.io)
[Terraform](https://www.terraform.io/)
[Serverspec](http://serverspec.org/)
