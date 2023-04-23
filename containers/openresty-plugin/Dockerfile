FROM openresty/openresty:buster
# FROM openresty/openresty

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

RUN luarocks install perimeterx-nginx-plugin
RUN mkdir -p /usr/share/lualib/
RUN echo /baseball >> /tmp/urls.txt
RUN echo /basketball >> /tmp/urls.txt
COPY ./public-html/ /usr/local/openresty/nginx/html
COPY ./nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY ./nginx.crt /etc/ssl/certs/
COPY ./nginx.key /etc/ssl/private/
COPY ./pxconfig.lua /usr/local/lib/lua/px/
