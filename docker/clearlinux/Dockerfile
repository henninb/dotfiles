FROM clearlinux
# docker pull clearlinux
RUN whoami
RUN swupd bundle-add git
RUN swupd bundle-add zsh
RUN swupd bundle-add sudo
RUN swupd bundle-add sysadmin-basic

RUN useradd henninb
RUN usermod -G wheel -a henninb
RUN usermod -G wheelnopw -a henninb
RUN echo "root password"
RUN echo -e "admin\nadmin" | passwd
# RUN echo empty password
# RUN echo henninb:U6aMy0wojraho | chpasswd -e
RUN mkdir /etc/sudoers.d/
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers.d/sudoers
RUN chmod 600 /etc/sudoers.d/sudoers

RUN mkdir -p /home/henninb/.ssh
RUN chown henninb:wheel /home/henninb/.ssh && chmod 700 /home/henninb/.ssh
COPY id_rsa /home/henninb/.ssh
COPY known_hosts /home/henninb/.ssh
RUN chown henninb:wheel /home/henninb/.ssh/id_rsa
RUN chown henninb:wheel /home/henninb/.ssh/known_hosts

RUN whoami
RUN pwd
WORKDIR /home/henninb
USER henninb

RUN whoami
RUN pwd
RUN cd /home/henninb
RUN rm -rf /home/henninb/.bashrc
RUN rm -rf /home/henninb/.profile
RUN rm -rf /home/henninb/.bash_profile
RUN git init .
RUN git remote add origin git@github.com:BitExplorer/dotfiles.git
RUN git pull origin master
RUN git branch --set-upstream-to=origin/master master

CMD ["/bin/bash"]
