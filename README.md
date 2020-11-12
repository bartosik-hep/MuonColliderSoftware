# MuonColliderSoftware

There are two ways to setup a Docker container:
- rely on the Dockerfiles provided by the Muon Collider collaboration in [Github](https://github.com/MuonColliderSoft/MuonCollider-docker). Instructions [here](#installation-with-official-dockerfiles).
- use my Dockerfile, based on the instructions provided in [Confluence](https://confluence.infn.it/display/muoncollider/Software+installation). Instructions [here](beta/Readme.md).

## Installation with official Dockerfiles

This installation relies on the Dockerfiles provided by the Muon Collider collaboration in [https://github.com/MuonColliderSoft/MuonCollider-docker](Github).

```
git clone https://github.com/MuonColliderSoft/MuonCollider-docker.git
cd MuonCollider-docker/CentOS8

docker build -f Dockerfile-environment -t infnpd/mucoll-environment:1.1-centos8 .
docker build -f Dockerfile-ilc-base -t infnpd/mucoll-ilc-base:1.1-centos8 .
docker build -f Dockerfile-ilc-framework -t infnpd/mucoll-ilc-framework:1.1-centos8 .

cd ../../

docker build --tag leggerf/mucoll-test .
```

or simply:

```
git clone https://github.com/MuonColliderSoft/MuonCollider-docker.git

./build.sh
```

and execute it with:

```./run.sh```

or (on MacOS):

```./run_mac.sh```

## Test

Once inside your docker image, you should be in /data/MuonCutil/SoftCheck. Then you can just run the following steps:

- simulation

```ddsim --compactFile /opt/ilcsoft/v02-02-MC/detector-simulation/geometries/CLIC_o3_v14_mod4/CLIC_o3_v14.xml --steeringFile sim_steer.py > sim.out```

- Reconstruction

```Marlin --InitDD4hep_mod4.DD4hepXMLFile=/opt/ilcsoft/v02-02-MC/detector-simulation/geometries/CLIC_o3_v14_mod4/CLIC_o3_v14.xml reco_steer.xml > reco.out```

- Event display (doesn't work atm)

```ced2go -d /opt/ilcsoft/v02-02-MC/detector-simulation/geometries/CLIC_o3_v14_mod4/CLIC_o3_v14.xml Output_REC.slcio```

or directly execute:

```./test.sh```


