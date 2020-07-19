FROM elixir:slim

ENV DEPS="curl git make g++"

RUN apt-get update -y && \
    apt-get install -y $DEPS && \
    curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get install -y inotify-tools nodejs

WORKDIR /code

RUN useradd -c 'phoenix user' -m -d /home/phoenix -s /bin/bash phoenix && \
    chown -R phoenix.phoenix /code
USER phoenix

# install the phoenix Mix archive
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new --force

ENV HOME /home/phoenix
