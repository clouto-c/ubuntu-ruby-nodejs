FROM ubuntu:18.04
LABEL maintainer="Shinji Kawaguchi <shinji.kawaguchi@clouto.io>" \
      version="0.1" \
      description="ruby and nodejs"

RUN apt-get update
RUN apt-get install -y git wget curl libxrender-dev gcc make libssl-dev zlib1g-dev libreadline-dev

# Install Ruby
RUN git clone https://github.com/rbenv/rbenv /usr/local/rbenv \
  && mkdir /usr/local/rbenv/plugins \
  && git clone https://github.com/rbenv/ruby-build /usr/local/rbenv/plugins/ruby-build

ENV RBENV_ROOT /usr/local/rbenv

RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> ~/.bashrc \
    && echo 'eval "$(rbenv init -)"' >> ~/.bashrc

ENV PATH $RBENV_ROOT/bin:$PATH

RUN rbenv install 2.6.3 \
  && rbenv global 2.6.3 \
  && rbenv rehash

RUN rbenv exec gem install bundler


RUN apt-get install -y software-properties-common nodejs npm

# Install Node.js
RUN npm install n -g
RUN npm install -g ansi
RUN ln -sf /usr/local/bin/node /usr/bin/node
RUN n 10.16.0 \
  && npm install -g yarn@1.16.0
