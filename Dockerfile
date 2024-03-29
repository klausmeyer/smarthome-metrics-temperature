FROM ruby:3.3.0-alpine

LABEL maintainer="Klaus Meyer <spam@klaus-meyer.net>"

ENV PORT 8080
ENV RACK_ENV production
EXPOSE $PORT

RUN apk update \
 && apk add build-base zlib-dev tzdata nodejs openssl-dev libc6-compat \
 && rm -rf /var/cache/apk/*

WORKDIR /app
ADD . .

RUN addgroup -S app && adduser -S app -G app -h /app \
 && chown -R app.app /app \
 && chown -R app.app /usr/local/bundle

USER app
RUN gem install bundler -v $(tail -n1 Gemfile.lock | xargs) \
 && bundle config set without 'development test' \
 && bundle install

CMD puma -p $PORT
