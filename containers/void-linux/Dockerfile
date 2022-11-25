FROM voidlinux/voidlinux

ENV TERM xterm-256color
ENV LC_ALL en_US.UTF-8

RUN xbps-install -S
RUN xbps-install -uy xbps
# RUN xbps-install -y screen
RUN xbps-install -y bash
RUN xbps-install -y zsh
RUN xbps-install -y git
RUN xbps-install -y sudo
RUN xbps-install -y openssh
RUN xbps-install -y vim
RUN xbps-install -y ncurses-term
RUN xbps-install -y fontforge
RUN xbps-install -y unzip

RUN useradd henninb -g wheel
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
#RUN echo disable_coredump false | tee -a /etc/sudo.conf

RUN mkdir -p /home/henninb/.ssh
RUN chown henninb:wheel /home/henninb/.ssh && chmod 700 /home/henninb/.ssh
COPY id_rsa /home/henninb/.ssh
COPY known_hosts /home/henninb/.ssh
RUN chown henninb:wheel /home/henninb/.ssh/id_rsa
RUN chown henninb:wheel /home/henninb/.ssh/known_hosts
RUN echo "LANG=en_US.UTF-8"  | tee -a /etc/locale.conf
RUN echo "en_US.UTF-8 UTF-8" | tee -a /etc/default/libc-locales
RUN xbps-reconfigure -f glibc-locales

WORKDIR /home/henninb
USER henninb

# RUN cd /home/henninb
# RUN rm -rf /home/henninb/.bashrc
# RUN rm -rf /home/henninb/.profile
# RUN rm -rf /home/henninb/.bash_profile
# RUN rm -rf /home/henninb/.screenrc
# RUN git init .
# RUN git remote add origin git@github.com:henninb/dotfiles.git
# RUN git pull origin main
# RUN git branch --set-upstream-to=origin/main main

CMD ["/bin/bash"]
