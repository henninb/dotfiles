FROM ubuntu:22.04
#FROM ubuntu:20.04.3
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -q update --fix-missing 
RUN apt-get upgrade -y
RUN apt-get install -y ubuntu-server

RUN apt install -y sudo
RUN apt install -y vim
RUN apt install -y git
RUN apt install -y zsh

RUN groupadd wheel
RUN useradd henninb -g wheel
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
RUN mkdir -p /home/henninb/.ssh
RUN chown henninb:wheel /home/henninb/.ssh && chmod 700 /home/henninb/.ssh
COPY id_rsa /home/henninb/.ssh
COPY known_hosts /home/henninb/.ssh
RUN chown henninb:wheel /home/henninb/.ssh/id_rsa
RUN chown henninb:wheel /home/henninb/.ssh/known_hosts
RUN chown henninb:wheel /home/henninb/

WORKDIR /home/henninb
USER henninb

CMD ["/bin/bash"]
