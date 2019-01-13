FROM clojure
RUN useradd -d /home/henninb henninb
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
EXPOSE 3000
RUN chown henninb:henninb /usr/src/app
#USER henninb
COPY . /usr/src/app
CMD ["lein", "run"]

