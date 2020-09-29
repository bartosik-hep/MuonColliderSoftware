# build with: docker build --tag leggerf/centos .
# run with: docker run --rm -it -v $PWD:/data/ -e DISPLAY=$DISPLAY leggerf/centos

FROM centos:8

# install utilities
RUN yum install -y mesa-libGL-devel
RUN yum -y install gedit
RUN yum -y install emacs

