# name the portage image
FROM gentoo/portage:latest as portage

# image is based on stage3-amd64
FROM gentoo/stage3-amd64:latest

# copy the entire portage volume in
COPY --from=portage /usr/portage /usr/portage

RUN emerge -qv dev-vcs/git
RUN emerge -qv sudo
RUN emerge -qv vim
RUN useradd henninb -g wheel
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

COPY id_rsa /home/henninb/.ssh
RUN chown henninb:wheel /home/henninb/.ssh/id_rsa

WORKDIR /home/henninb
USER henninb

RUN rm -rf /home/henninb/.bashrc
RUN rm -rf /home/henninb/.profile
RUN rm -rf /home/henninb/.bash_profile
RUN git init .
RUN git remote add origin git@github.com:BitExplorer/dotfiles.git
RUN git pull origin master
RUN git branch --set-upstream-to=origin/master master
RUN mkdir -p /home/henninb/.ssh

CMD ["/bin/sh"]
