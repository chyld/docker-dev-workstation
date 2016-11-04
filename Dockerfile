FROM ubuntu:16.10

# NETWORK
RUN apt-get update && apt-get install -y \
    wget curl apt-transport-https

# CLANG/LLVM
RUN wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-get update && apt-get install -y \
    clang-3.8 clang-3.8-doc libclang-common-3.8-dev libclang-3.8-dev libclang1-3.8 libclang1-3.8-dbg \
    libllvm-3.8-ocaml-dev libllvm3.8 libllvm3.8-dbg lldb-3.8 llvm-3.8 llvm-3.8-dev llvm-3.8-doc \
    llvm-3.8-examples llvm-3.8-runtime clang-format-3.8 python-clang-3.8 lldb-3.8-dev

# MISCELLANEOUS
RUN apt-get update && apt-get install -y \
    sudo man git vim tmux tree xz-utils \
    build-essential gdb cmake \
    python3 python3-pip \
    htop dstat strace lsof psmisc sysdig netcat net-tools ltrace ngrep tcpdump

# EUROPA
RUN useradd -ms /bin/bash europa && usermod -aG sudo europa && echo "europa:europa" | chpasswd

# NODE
RUN cd /tmp && wget https://nodejs.org/dist/v7.0.0/node-v7.0.0-linux-x64.tar.xz \
    && tar -xvf node-v7.0.0-linux-x64.tar.xz && mv node-v7.0.0-linux-x64 /usr/local/node \
    && cd /usr/local && chown -R europa node

# PYTHON 3 + PACKAGES
RUN pip3 install --upgrade pip
RUN pip3 install jupyter ipdb httpie

# PREP FOR TMUX
RUN locale-gen en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

# SWITCHING TO EUROPA
USER europa
WORKDIR /home/europa

# CUSTOMIZATIONS
ADD .bash_profile .
ADD .bash_aliases .
ADD .tmux.conf .
RUN mkdir -p /home/europa/temp && touch /home/europa/.sudo_as_admin_successful
RUN /bin/bash --login -c "npm i -g yarn"
