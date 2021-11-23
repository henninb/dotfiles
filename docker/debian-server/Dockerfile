FROM debian

RUN apt update -y
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
