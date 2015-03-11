# Rippled Testnet AMI

This repository contains scripts and such to build an AWS AMI for running a
rippled docker container given a specific git hash or tag.

Files are named according to execution order for ease in documenting.

## How to build

```
$ export AWS_ACCESS_KEY=FOO
$ export AWS_SECRET_KEY=FOO
$ packer build 00-packer.json
```

The above commands perform the following:

1. Starts up an EC2 instance based on the latest Ubuntu
2. Installs ansible
3. Runs 01-configure-base-ami.yml, which:
4. Installs docker
5. Copies 03-ami-boot.yml and rippled.cfg to /root/
6. Replaces /etc/rc.local with 02-ami-rc-local.sh
7. Installs sumologic collector
8. Configures the sumologic collector with private keys from sumo-config.yml

## Whats in the image

Once the AMI is built, the image will perform the following at boot:

1. Download the instance's user data from the AWS API, which is saved as
   /root/testnet-config.yml
2. Runs 03-ami-boot/main.yml, which:
3. Pulls latest rippled dockder image
4. Installs rippled.cfg to /srv/rippled/rippled.cfg
5. Starts the docker image, exporting all ports and mounting /srv/rippled inside
   the container.

## How to configure the image

The user data that is downloaded must contain a yaml document.
Here is an example:

```yaml
---
rippled_version: some-git-ref
```
