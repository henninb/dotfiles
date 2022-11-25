FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND noninteractive
ENV DESKTOP_PKG=kali-desktop-xfce
ENV REMOTE_ACCESS=x2go
ENV KALI_PKG=kali-linux-default

RUN apt update -q --fix-missing
RUN apt upgrade -y
RUN apt -y install --no-install-recommends sudo wget curl dbus-x11 xinit ${DESKTOP_PKG}

# ENV DEBIAN_FRONTEND noninteractive
# RUN apt-get update -y

# RUN apt install -y sudo
# RUN apt install -y vim
# RUN apt install -y git
RUN apt install -y beef-xss
# RUN apt install -y bundle
COPY config.yaml /etc/beef-xss/

# ENV LANG=en_US.UTF-8
# ENV LANGUAGE=en_US.UTF-8
# ENV LC_ALL=en_US.UTF-8
# RUN bundle

# RUN groupadd wheel
# RUN useradd henninb -g wheel
# RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
# RUN mkdir -p /home/henninb/.ssh
# RUN chown henninb:wheel /home/henninb/.ssh && chmod 700 /home/henninb/.ssh
# COPY id_rsa /home/henninb/.ssh
# COPY known_hosts /home/henninb/.ssh
# RUN chown henninb:wheel /home/henninb/.ssh/id_rsa
# RUN chown henninb:wheel /home/henninb/.ssh/known_hosts
# RUN chown henninb:wheel /home/henninb/

WORKDIR /usr/share/beef-xss

# USER henninb

# CMD ["/bin/bash"]
# CMD ["beef-xss"]
CMD ["./beef"]
