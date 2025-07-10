FROM ruby:2.3.8

# Fix apt repos, disable GPG checks (from earlier)
RUN printf "deb http://archive.debian.org/debian stretch main contrib non-free\n\
deb http://archive.debian.org/debian-security stretch/updates main contrib non-free\n" > /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    echo 'Acquire::AllowInsecureRepositories "true";' >> /etc/apt/apt.conf.d/99no-check-valid-until && \
    echo 'APT::Get::AllowUnauthenticated "true";' >> /etc/apt/apt.conf.d/99no-check-valid-until

RUN apt-get update && apt-get install -y \
  build-essential \
  libsqlite3-dev \
  nodejs \
  libxml2-dev \
  libxslt-dev \
  libreadline-dev \
  libssl-dev \
  zlib1g-dev \
  libyaml-dev

WORKDIR /app
COPY . /app

# Install correct bundler version
RUN gem install bundler:2.0.0.pre.3

RUN bundle _2.0.0.pre.3_ install

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]