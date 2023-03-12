FROM haskell

RUN stack update

RUN apt update -y
RUN apt install -y gobject-introspection
RUN apt install -y libatk1.0-dev
RUN apt install -y libpango1.0-dev
#RUN apt install -y libgdk-pixbuf-2.0-dev
RUN apt install -y libgirepository1.0-dev
RUN apt install -y libgtk-3-dev
#RUN addgroup henninb
#RUN adduser -D -G henninb henninb
#RUN adduser henninb
RUN  useradd -m henninb

USER henninb
RUN mkdir -p /home/henninb/.local/bin
RUN mkdir -p /home/henninb/logout-gtk
#RUN cd /home/henninb/logout-gtk
#RUN stack build
#RUN stack install
#RUN cp /home/henninb/.local/bin/logout-gtk /home/henninb/logout-gtk/

#RUN stack build gi-harfbuzz
