FROM ruby:2.7-alpine

ENV BUILD_PACKAGES curl-dev ruby-dev build-base

# Update and install base packages
RUN apk update && apk upgrade && apk add bash $BUILD_PACKAGES

WORKDIR /usr/src/app

COPY src/* ./

RUN bundle install

RUN apk del build-base curl-dev

RUN rm -rf /var/cache/apk/*

RUN adduser -D --uid 777 cpuhog

USER 777

EXPOSE 8080/tcp

CMD ["./main.rb"]
