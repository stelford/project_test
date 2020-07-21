FROM elixir:slim

ENV DEPS="curl git make g++"

RUN apt-get update -y && \
    apt-get install -y $DEPS && \
    curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get install -y inotify-tools nodejs

WORKDIR /code

## Add the wait script to the image
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.3/wait /wait
RUN chmod ugo+x /wait

RUN useradd -c 'phoenix user' -m -d /home/phoenix -s /bin/bash phoenix && \
    chown -R phoenix.phoenix /code
USER phoenix

# install the phoenix Mix archive
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new --force

ENV HOME /home/phoenix

CMD /wait && /code/trampoline.sh
