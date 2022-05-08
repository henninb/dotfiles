FROM kalilinux/kali-rolling
# ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y

# RUN apt install -y sudo
# RUN apt install -y vim
# RUN apt install -y git
RUN apt install -y beef-xss
COPY config.yaml /etc/beef-xss/

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

# WORKDIR /home/henninb
# USER henninb

CMD ["/bin/bash"]
# CMD ["beef-xss"]
