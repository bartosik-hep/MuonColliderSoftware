# MuonColliderSoftware

Collection of scripts for Muon Collider software, based on:

- Muon Collider software installation in (Confluence)[https://confluence.infn.it/display/muoncollider/Software+installation]
- Dockerfiles in (Github)[https://github.com/MuonColliderSoft/MuonCollider-docker]

# Installation with Docker

```
git clone https://github.com/MuonColliderSoft/MuonCollider-docker.git
cd MuonCollider-docker/CentOS8

docker build -f Dockerfile-environment -t infnpd/mucoll-environment:1.1-centos8 .
docker build -f Dockerfile-ilc-base -t infnpd/mucoll-ilc-base:1.1-centos8 .
docker build -f Dockerfile-ilc-framework -t infnpd/mucoll-ilc-framework:1.1-centos8 .

cd ../../

docker build --tag leggerf/mucoll-test .
```

or, after having cloned the repository, you can just build your test docker image with:

```./build.sh```

and execute it with:

```./run.sh```

or (on MacOS):

```./run_mac.sh```

# Test

Once inside your docker image, you should be in /data/MuonCutil/SoftCheck. Then you can just run the following steps:

- simulation

```ddsim --compactFile /opt/ilcsoft/v02-02-MC/detector-simulation/geometries/CLIC_o3_v14_mod4/CLIC_o3_v14.xml --steeringFile sim_steer.py > sim.out```

- Reconstruction

```Marlin --InitDD4hep_mod4.DD4hepXMLFile=/opt/ilcsoft/v02-02-MC/detector-simulation/geometries/CLIC_o3_v14_mod4/CLIC_o3_v14.xml reco_steer.xml > reco.out```

- Event display

```ced2go -d /opt/ilcsoft/v02-02-MC/detector-simulation/geometries/CLIC_o3_v14_mod4/CLIC_o3_v14.xml Output_REC.slcio```

