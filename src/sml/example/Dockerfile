FROM msgodf/dockerfile-smlnj

ARG APP="example"
ENV APP example
RUN useradd henninb
RUN mkdir -p -m 0775 /opt/${APP}/bin
RUN mkdir -p -m 0775 /opt/${APP}/logs/archive
RUN mkdir -p -m 0775 /opt/${APP}/ssl
ADD ${APP}.sml ${APP}.cm /opt/${APP}/bin/
WORKDIR /opt/${APP}/bin
RUN ml-build example.cm Example.main example.heap
RUN chown -R henninb /opt/${APP}/*

USER henninb

CMD example
