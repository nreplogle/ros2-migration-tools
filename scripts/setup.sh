#!/bin/bash
#
pip3 install parse_cmake

git clone https://github.com/awslabs/ros2-migration-tools.git
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
tar xvf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
cp -r clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04/lib/libclang.so* ros2-migration-tools/clang
cp -r clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04/lib/clang/8.0.0/include ros2-migration-tools/clang/clang
