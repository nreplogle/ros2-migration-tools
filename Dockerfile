ARG ARCH=amd64

##### STAGE 1
FROM ros:melodic-ros-core-bionic

#ENV ROS_INSTALL_DIR=/opt/ros/dashing

USER root

RUN apt-get update && \
    apt-get install -y curl gnupg2 lsb-release wget \
    python3-pip\
        net-tools \
        jq \
        git

RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - && \
    sh -c 'echo "deb [arch=amd64,arm64,armhf] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list' && \
    apt-get update && \
    apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
        ros-dashing-ros-base

RUN pip3 install parse_cmake

RUN apt-get install -y python3-colcon-common-extensions

RUN pip3 install colcon-ros-bundle

RUN apt-get install -y ros-melodic-tf2-tools ros-melodic-tf
RUN apt-get install -y ros-melodic-pcl-conversions
RUN apt-get install -y ros-melodic-pcl-ros ros-melodic-pcl-msgs

RUN sudo apt-get install -y clang-8

RUN apt-get update && \
apt-get install -y cppad

RUN apt-get install -y gcc g++ gfortran git patch wget pkg-config liblapack-dev libmetis-dev

RUN git clone https://github.com/coin-or/Ipopt.git

RUN apt-get install -y autoconf autotools-dev

RUN cd Ipopt && \
mkdir -p build && \
cd build && \
./../configure && \
make && \
make install

RUN mkdir -p /usr/local/include/coin && cp -rf /usr/local/include/coin-or/* /usr/local/include/coin/

RUN apt-get install -y ros-melodic-tf2-geometry-msgs

RUN git clone https://github.com/coin-or-tools/ThirdParty-Mumps.git
RUN cd ThirdParty-Mumps && \
./get.Mumps && \
./configure && \
make && \
make install

#RUN git clone https://github.com/awslabs/ros2-migration-tools.git
#RUN wget https://github.com/llvm/llvm-project/releases/download/llvmorg-10.0.0/clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
#RUN tar xvf clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
#RUN cp -r clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/lib/libclang.so ros2-migration-tools/clang
#RUN cp -r clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/lib/libclang.so.8 ros2-migration-tools/clang
#RUN cp -r clang+llvm-10.0.0-x86_64-linux-gnu-ubuntu-18.04/lib/clang/8.0.0/include ros2-migration-tools/clang/clang