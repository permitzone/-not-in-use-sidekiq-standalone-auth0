FROM ruby:2.4.0
MAINTAINER Adam Michel <adam@permitzone.com>

ARG BUNDLE_WITHOUT="development:test"
ARG APT_DEV_PACKAGES=""
ARG PORT=3000

RUN apt-get update && apt-get install -y \
    git make g++ curl tzdata \
    ${APT_DEV_PACKAGES}

RUN gem install foreman

ENV APP_HOME /usr/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

# Bundler ENV var http://bundler.io/man/bundle-config.1.html.
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
    BUNDLE_WITHOUT=${BUNDLE_WITHOUT} \
    BUNDLE_PATH=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_BIN=true

RUN bundle install

COPY . $APP_HOME/

ENV PORT ${PORT}
EXPOSE ${PORT}

ENTRYPOINT ["foreman", "start"]

CMD ["web"]
