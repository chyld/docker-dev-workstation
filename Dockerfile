FROM ubuntu:16.10

RUN apt-get update && apt-get install -y \
    man vim tmux tree curl wget xz-utils \
    build-essential gdb \
    python3 python3-pip \
    htop dstat strace lsof psmisc sysdig netcat net-tools ltrace ngrep tcpdump

RUN useradd -ms /bin/bash europa
RUN cd /tmp && wget https://nodejs.org/dist/v7.0.0/node-v7.0.0-linux-x64.tar.xz \
    && tar -xvf node-v7.0.0-linux-x64.tar.xz && mv node-v7.0.0-linux-x64 /usr/local/node \
    && cd /usr/local && chown -R europa node

RUN pip3 install --upgrade pip
RUN pip3 install jupyter ipdb httpie

USER europa
WORKDIR /home/europa

ADD .bash_profile .
ADD .bash_aliases .

RUN /bin/bash --login -c "npm i -g yarn"
