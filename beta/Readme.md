# My Dockerfile based on beta instructions

## Installation with Docker

```cd beta```

You can just build the test docker image with:

```./build.sh```

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
