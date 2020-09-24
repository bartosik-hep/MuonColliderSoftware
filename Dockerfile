# build with: docker build --tag leggerf/centos .
# run with: docker run --rm -it -e DISPLAY=$DISPLAY leggerf/centos

FROM centos:8

# install utilities
RUN yum install -y mesa-libGL-devel
RUN yum -y install gedit
RUN yum -y install emacs

# install Muon Collider Software and dependencies
# from https://sites.google.com/site/muoncollider/ilcsoft/installation

RUN yum -y install epel-release yum-utils wget
RUN yum-config-manager --set-enabled PowerTools
RUN yum-config-manager --set-enabled AppStream

RUN wget -O /etc/yum.repos.d/EGI-trustanchors.repo http://repository.egi.eu/sw/production/cas/1/current/repo-files/EGI-trustanchors.repo
RUN yum -y localinstall http://artifacts.pd.infn.it/packages/CAP/misc/CentOS8/noarch/ca_TERENA-SSL-CA-3-1.0-2.el8.noarch.rpm
RUN yum -y install ca-policy-egi-core
RUN ln -s /etc/grid-security/certificates/USERTrustRSACertificationAuthority.pem /etc/pki/ca-trust/source/anchors/			
RUN wget -O /etc/yum.repos.d/geant4.repo http://artifacts.pd.infn.it/packages/MuonColliderSoft/repos/CentOS8/geant4.repo
RUN ln -s /etc/grid-security/certificates/GEANTeScienceSSLCA4.pem /etc/pki/ca-trust/source/anchors/					
RUN wget -O /etc/yum.repos.d/muoncollidersoft.repo http://artifacts.pd.infn.it/packages/MuonColliderSoft/repos/CentOS8/muoncollidersoft.repo
RUN update-ca-trust extract

RUN yum -y install vim-enhanced xorg-x11-xauth screen git subversion rsync make \
               sshpass zip doxygen rpm-build gcc gcc-c++ \
               libSM-devel libX11-devel libXext-devel libXft-devel libXmu-devel libXpm-devel \
               libjpeg-turbo-devel libpng-devel libtiff-devel mesa-libGLU-devel \
               zlib-devel freeglut-devel bzip2 glibc-devel glibc-utils glibc \
               glibc-headers glibc-static glibc-common libstdc++-devel expat-devel giflib-devel openmotif-devel \
               mysql mysql-devel texlive texlive-xtab texlive-multirow texlive-sectsty texlive-tocloft \
               xrootd-devel python3-devel libquadmath-devel binutils-devel libstdc++-devel \
               eigen3-devel boost169-devel mesa-dri-drivers mlocate emacs eog


RUN yum -y install root root-gdml root-graf3d-eve root-genvector python3-root root-tmva \
       root-unuran root-minuit2 root-smatrix gsl-devel

RUN yum -y install geant4-devel clhep-devel

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN sed -i 's|include_next|include|g' /usr/include/c++/8/cstdlib
RUN sed -i 's|include_next|include|g' /usr/include/c++/8/bits/std_abs.h
RUN sed -i 's|include_next|include|g' /usr/include/c++/8/cmath

# Build setup

WORKDIR /opt
RUN git clone https://github.com/iLCSoft/iLCInstall.git 

WORKDIR /opt/iLCInstall

RUN mkdir releases/development
RUN wget -O releases/development/release-base.cfg http://artifacts.pd.infn.it/templates/MuonColliderSoft/CentOS8/release-base.cfg
RUN wget -O releases/development/release-ilcsoft.cfg http://artifacts.pd.infn.it/templates/MuonColliderSoft/CentOS8/release-ilcsoft.cfg
RUN wget -O releases/development/release-versions.py http://artifacts.pd.infn.it/templates/MuonColliderSoft/CentOS8/release-versions.py

RUN sed -i "s|/usr/bin/env python|/usr/bin/env python2|g" ilcsoft-install
RUN ./ilcsoft-install releases/development/release-base.cfg --install-prefix=/opt/ilcsoft -v -i
#da errore:
RUN ./ilcsoft-install releases/development/release-ilcsoft.cfg --install-prefix=/opt/ilcsoft -v -i

#WORKDIR /opt/ilcsoft/v02-01-pre
#RUN git clone https://github.com/MuonColliderSoft/detector-simulation.git
#RUN sed -i "s|/bin/env python|/usr/bin/env python2|g" /opt/ilcsoft/v02-01-pre/CEDViewer/v01-17/bin/ced2go
