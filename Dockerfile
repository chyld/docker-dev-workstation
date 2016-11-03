FROM ubuntu:16.04

# NETWORK
RUN apt-get update && apt-get install -y \
    wget curl apt-transport-https

# CLANG/LLVM
RUN wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-get update && apt-get install -y \
    clang-3.8 clang-3.8-doc libclang-common-3.8-dev libclang-3.8-dev libclang1-3.8 libclang1-3.8-dbg \
    libllvm-3.8-ocaml-dev libllvm3.8 libllvm3.8-dbg lldb-3.8 llvm-3.8 llvm-3.8-dev llvm-3.8-doc \
    llvm-3.8-examples llvm-3.8-runtime clang-format-3.8 python-clang-3.8 lldb-3.8-dev

# BPF Compiler Collection
RUN echo "deb [trusted=yes] https://repo.iovisor.org/apt/xenial xenial-nightly main" | tee /etc/apt/sources.list.d/iovisor.list
RUN apt-get update && apt-get install -y \
    bcc-tools

# MISCELLANEOUS
RUN apt-get update && apt-get install -y \
    man git vim tmux tree xz-utils \
    build-essential gdb cmake \
    python3 python3-pip \
    htop dstat strace lsof psmisc sysdig netcat net-tools ltrace ngrep tcpdump

# EUROPA
RUN useradd -ms /bin/bash europa
RUN mkdir -p /home/europa/temp

# NODE
RUN cd /tmp && wget https://nodejs.org/dist/v7.0.0/node-v7.0.0-linux-x64.tar.xz \
    && tar -xvf node-v7.0.0-linux-x64.tar.xz && mv node-v7.0.0-linux-x64 /usr/local/node \
    && cd /usr/local && chown -R europa node

# PYTHON 3 + PACKAGES
RUN pip3 install --upgrade pip
RUN pip3 install jupyter ipdb httpie

USER europa
WORKDIR /home/europa

ADD .bash_profile .
ADD .bash_aliases .

RUN /bin/bash --login -c "npm i -g yarn"
