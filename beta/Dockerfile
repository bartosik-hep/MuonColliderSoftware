# build with: docker build --tag leggerf/centos .
# run with: docker run --rm -it -v $PWD:/data/ -e DISPLAY=$DISPLAY leggerf/centos

FROM centos:8

# install utilities
RUN yum install -y mesa-libGL-devel
RUN yum -y install gedit
RUN yum -y install emacs

# start from a CentOS8 machine (eg. CentOS Linux release 8.2.2004)

RUN yum -y install epel-release yum-utils wget git
RUN yum-config-manager --set-enabled PowerTools
RUN yum-config-manager --set-enabled AppStream


# New INFN CA

RUN wget -O /etc/yum.repos.d/EGI-trustanchors.repo http://repository.egi.eu/sw/production/cas/1/current/repo-files/EGI-trustanchors.repo
RUN yum -y install ca-policy-egi-core
RUN ln -s /etc/grid-security/certificates/USERTrustRSACertificationAuthority.pem /etc/pki/ca-trust/source/anchors/
RUN ln -s /etc/grid-security/certificates/GEANTeScienceSSLCA4.pem /etc/pki/ca-trust/source/anchors/
RUN update-ca-trust extract

# Some useful packages.. and some extras

RUN yum -y install binutils-devel boost169-devel bzip2 chrpath cmake doxygen eigen3-devel emacs eog expat-devel freeglut-devel gcc gcc-c++ giflib-devel glibc glibc-common glibc-devel glibc-headers glibc-static glibc-utils libjpeg-turbo-devel libpng-devel libquadmath-devel libSM-devel libstdc++-devel libtiff-devel libX11-devel libXext-devel libXft-devel libXmu-devel libXpm-devel make mesa-dri-drivers  mlocate mysql mysql-devel openmotif-devel python3-devel rsync screen sshpass subversion texlive texlive-multirow texlive-sectsty texlive-tocloft texlive-xtab vim-enhanced xorg-x11-xauth xrootd-devel zip zlib-devel

# Framework

# Install some custom repositories:

RUN wget -O /etc/yum.repos.d/geant4.repo http://artifacts.pd.infn.it/packages/MuonColliderSoft/repos/CentOS8/geant4.repo
RUN wget -O /etc/yum.repos.d/muoncollidersoft.repo http://artifacts.pd.infn.it/packages/MuonColliderSoft/repos/CentOS8/muoncollidersoft.repo

# Install ROOT, geant and other dependencies:

RUN yum -y install clhep-devel eigen3-devel geant4-devel gsl-devel python3-root root root-gdml root-genvector root-geom root-graf3d-eve root-graf3d-eve7 root-gui-browserv7 root-minuit2 root-smatrix root-tmva root-tpython root-unuran

RUN geant4-dataset-download

# Some useful workarounds:

RUN alternatives --set python /usr/bin/python3
RUN sed -i 's|include_next|include|g' /usr/include/c++/8/cstdlib
RUN sed -i 's|include_next|include|g' /usr/include/c++/8/bits/std_abs.h
RUN sed -i 's|include_next|include|g' /usr/include/c++/8/cmath

# Add this line: #undef _GLIBCXX_ASSERTIONS at the end of the following files just before the last endif

# /usr/include/c++/8/x86_64-redhat-linux/bits/c++config.h
# /usr/include/c++/8/x86_64-redhat-linux/32/bits/c++config.h

# Installation
# Build setup

# First clone the utils repository

RUN git clone https://github.com/MuonColliderSoft/MuonCutil.git

# Move to installation directory

WORKDIR /opt
RUN git clone https://github.com/MuonColliderSoft/MuonCutil.git
WORKDIR /opt/MuonCutil
RUN git checkout v02-02-MC

WORKDIR /opt
RUN git clone https://github.com/iLCSoft/iLCInstall.git 
WORKDIR /opt/iLCInstall
RUN git checkout v02-02

# Copy the last configuration files

RUN mkdir releases/development
RUN cp /opt/MuonCutil/releases/development/* releases/development

# Change ilcsoft-install to force to use python2

RUN sed -i 's|/usr/bin/env python|/usr/bin/env python2|g' ilcsoft-install

# Software installation

RUN ./ilcsoft-install releases/development/release-base.cfg --install-prefix=/opt/ilcsoft -v -i
RUN ./ilcsoft-install releases/development/release-ilcsoft.cfg --install-prefix=/opt/ilcsoft -v -i

# Install the new geometry

# For the MuonCollider we update the detector's geometry

WORKDIR /opt/ilcsoft/v02-02-MC
RUN git clone https://github.com/MuonColliderSoft/detector-simulation.git

# Post installation

# Change ced2go to force to use python2

RUN sed -i 's|/bin/env python|/usr/bin/env python2|g' /opt/ilcsoft/v02-02-MC/CEDViewer/v01-17-01/bin/ced2go

# Source the right file to set the software environment

RUN echo 'source /opt/ilcsoft/v02-02-MC/init_ilcsoft.sh' > /etc/profile.d/ilcsoft.sh

# Test

# To check your installation you can use the following simple tests. You need again the utils repository, so clone it again as user:

WORKDIR /data
RUN git clone https://github.com/MuonColliderSoft/MuonCutil.git
WORKDIR /data/MuonCutil/SoftCheck
