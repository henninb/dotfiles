# name the portage image
FROM gentoo/portage:latest as portage

# image is based on stage3-amd64
FROM gentoo/stage3-amd64:latest

# copy the entire portage volume in
#COPY --from=portage /usr/portage /usr/portage
# COPY --from=portage /usr/portage /var/db/repos/gentoo
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

RUN mkdir -p /usr/portage/local/profiles/
RUN mkdir -p /usr/portage/profiles/
RUN mkdir -p /etc/portage/package.mask/
RUN echo '=dev-python/docutils-0.18' | tee /etc/portage/package.mask/docutils
RUN echo "$HOSTNAME" | tee /usr/portage/local/profiles/repo_name
RUN echo "$HOSTNAME" | tee /usr/portage/profiles/repo_name
COPY gentoo/package.accept_keywords /etc/portage/package.accept_keywords
COPY gentoo/package.license /etc/portage/package.license
COPY gentoo/zz-autounmask /etc/portage/package.use/zz-autounmask
COPY gentoo/layman /etc/portage/package.use/layman
COPY gentoo/make.conf /etc/portage/make.conf
COPY gentoo/package.unmask /etc/portage/package.unmask

# RUN emerge -qv dev-vcs/git
# RUN emerge -qv sudo
# RUN emerge -qv vim

RUN useradd henninb -g wheel
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

COPY id_rsa /home/henninb/.ssh
RUN chown henninb:wheel /home/henninb/.ssh/id_rsa

WORKDIR /home/henninb
USER henninb

# RUN rm -rf /home/henninb/.bashrc
# RUN rm -rf /home/henninb/.profile
# RUN rm -rf /home/henninb/.bash_profile
# RUN git init .
# RUN git remote add origin git@github.com:henninb/dotfiles.git
# RUN git fetch --all
# RUN git merge origin/main
# RUN git branch --set-upstream-to=origin/main main
# RUN mkdir -p /home/henninb/.ssh

CMD ["/bin/sh"]
