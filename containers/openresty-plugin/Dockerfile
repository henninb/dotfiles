FROM openresty/openresty:buster

ENV VER_LUA_NETTLE=1.5

RUN apt-get update && apt-get -qq -y install \
    build-essential \
    ca-certificates \
    curl \
    wget luarocks

# Install CPAN dependencies for unit tests
RUN curl -sSL http://cpanmin.us | perl - App::cpanminus
RUN cpanm --quiet --notest --skip-satisfied Test::Nginx
RUN cpanm --quiet --notest --skip-satisfied CryptX

RUN luarocks install lustache
RUN luarocks install luasocket
RUN luarocks install lua-resty-http
RUN luarocks install luacheck
RUN curl -sSL https://github.com/bungle/lua-resty-nettle/archive/v${VER_LUA_NETTLE}.tar.gz | tar -C /usr/local --strip-components 1 -xzf - && \
    mkdir -p /usr/local/lib/lua/resty && \
    mv /usr/local/lib/resty/* /usr/local/lib/lua/resty

# Install CPAN dependencies for unit tests
# RUN curl -sSL http://cpanmin.us | perl - App::cpanminus
# RUN cpanm --quiet --notest --skip-satisfied Test::Nginx
# RUN cpanm --quiet --notest --skip-satisfied CryptX
# RUN apt-get -y install build-essential
# RUN apt-get -y install ca-certificates
# RUN apt-get -y install nginx
# RUN apt-get -y install libnginx-mod-http-lua
# RUN apt-get -y install lua-cjson
# RUN apt-get -y install libnettle6
# RUN apt-get -y install nettle-dev
# RUN apt-get -y install luarocks
# RUN apt-get -y install luajit
# RUN apt-get -y install libluajit-5.1-dev

# RUN luarocks install lustache
# RUN luarocks install luasocket
# RUN luarocks install lua-resty-http
# RUN luarocks install luacheck
# RUN curl -sSL https://github.com/bungle/lua-resty-nettle/archive/v${VER_LUA_NETTLE}.tar.gz | tar -C /usr/local --strip-components 1 -xzf - && \
#     mkdir -p /usr/local/lib/lua/resty && \
#     mv /usr/local/lib/resty/* /usr/local/lib/lua/resty

RUN luarocks install perimeterx-nginx-plugin
# RUN apt-get update
# RUN apt-get -y install iproute2

RUN mkdir -p /usr/share/lualib/
RUN mkdir -p /usr/local/openresty/nginx/html-site1
# RUN mkdir -p /opt/perimeterx-nginx-plugin-7.2.0

# COPY ./perimeterx-nginx-plugin-7.2.0 /opt/perimeterx-nginx-plugin-7.2.0
# RUN sudo no_proxy=1 luarocks install perimeterx-nginx-plugin
RUN echo /baseball >> /tmp/urls.txt
RUN echo /basketball >> /tmp/urls.txt
COPY ./app.lua /usr/share/lualib/
COPY ./public-html/ /usr/local/openresty/nginx/html
COPY ./public-html/ /usr/local/openresty/nginx/html-site1
# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY ./nginx.crt /etc/ssl/certs/
COPY ./nginx.key /etc/ssl/private/
COPY ./pxconfig.lua /usr/local/lib/lua/px/
