###############################################################################
#  Repository: mucoll-ilc-test
#  Tag:        1.1-centos8
###############################################################################

FROM infnpd/mucoll-ilc-framework:1.1-centos8


# Test

# To check your installation you can use the following simple tests. You need again the utils repository, so clone it again as user:

WORKDIR /data
RUN git clone https://github.com/MuonColliderSoft/MuonCutil.git
WORKDIR /data/MuonCutil/SoftCheck

# fix to run ced2go
RUN export USER='pippo'
