FROM clojure
#ENV PATH=/usr/local/openjdk-8/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin/
RUN useradd -d /home/henninb henninb
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
EXPOSE 3000
RUN chown henninb:henninb /usr/src/app
#USER henninb
COPY . /usr/src/app
CMD ["lein", "run"]

