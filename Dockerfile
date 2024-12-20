FROM ruby:3.3.6-alpine

LABEL maintainer="Klaus Meyer <spam@klaus-meyer.net>"

ARG SOURCE_COMMIT
ENV SOURCE_COMMIT=$SOURCE_COMMIT

ENV PORT=8080
ENV RACK_ENV=production

EXPOSE $PORT

ENTRYPOINT ["/docker-entrypoint.sh"]

RUN apk update \
 && apk add build-base zlib-dev tzdata git openssl-dev shared-mime-info libc6-compat \
 && rm -rf /var/cache/apk/* \
 && mkdir -p /var/www/rack

COPY Gemfile Gemfile.lock /var/www/rack/
COPY docker-entrypoint.sh /docker-entrypoint.sh

WORKDIR /var/www/rack/

RUN gem install bundler -v $(grep -A1 "BUNDLED WITH" Gemfile.lock | tail -n1 | tr -d "[:space:]") \
 && bundle config set build.sassc "--disable-march-tune-native" \
 && bundle config set without "development test" \
 && bundle install

ADD . /var/www/rack/

RUN addgroup -S rack && adduser -S rack -G rack -h /var/www/rack/ \
 && chown -R rack:rack /var/www/rack/ \
 && chown -R rack:rack /usr/local/bundle

USER rack

CMD ["web"]
