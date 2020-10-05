# MuonColliderSoftware
Collection of scripts for Muon Collider software

based on:

- Muon Collider software installation in (Confluence)[https://confluence.infn.it/display/muoncollider/Software+installation]
- Dockerfiles in (Github)[https://github.com/MuonColliderSoft/MuonCollider-docker]

# Installation with Docker

```
git clone https://github.com/MuonColliderSoft/MuonCollider-docker.git
cd MuonCollider-docker/CentOS8

docker build -f Dockerfile-environment -t infnpd/mucoll-environment:1.1-centos8 .
docker build -f Dockerfile-ilc-base -t infnpd/mucoll-ilc-base:1.1-centos8 .
docker build -f Dockerfile-ilc-framework -t infnpd/mucoll-ilc-framework:1.1-centos8 .
```
