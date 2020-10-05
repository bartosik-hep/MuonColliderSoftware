# Simulation

ddsim --compactFile /opt/ilcsoft/v02-02-MC/detector-simulation/geometries/CLIC_o3_v14_mod4/CLIC_o3_v14.xml --steeringFile sim_steer.py > sim.out
anajob muonGun_sim.slcio

# Reconstruction

Marlin --InitDD4hep_mod4.DD4hepXMLFile=/opt/ilcsoft/v02-02-MC/detector-simulation/geometries/CLIC_o3_v14_mod4/CLIC_o3_v14.xml reco_steer.xml > reco.out
anajob Output_REC.slcio

# Event display

# ced2go -d /opt/ilcsoft/v02-02-MC/detector-simulation/geometries/CLIC_o3_v14_mod4/CLIC_o3_v14.xml Output_REC.slcio
