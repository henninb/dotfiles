FROM clearlinux
# docker pull clearlinux

RUN useradd henninb -g wheel
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

RUN mkdir -p /home/henninb/.ssh
RUN chown henninb:wheel /home/henninb/.ssh && chmod 700 /home/henninb/.ssh
COPY id_rsa /home/henninb/.ssh
COPY known_hosts /home/henninb/.ssh
RUN chown henninb:wheel /home/henninb/.ssh/id_rsa
RUN chown henninb:wheel /home/henninb/.ssh/known_hosts

WORKDIR /home/henninb
USER henninb

RUN cd /home/henninb
RUN rm -rf /home/henninb/.bashrc
RUN rm -rf /home/henninb/.profile
RUN rm -rf /home/henninb/.bash_profile
RUN git init .
RUN git remote add origin git@github.com:BitExplorer/dotfiles.git
RUN git pull origin master
RUN git branch --set-upstream-to=origin/master master

CMD ["/bin/bash"]
