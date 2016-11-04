FROM ruby:2.3.1
CMD ["rake", "spec"]
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN gem install bundler
RUN bundle config --global frozen 1
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install
COPY . /usr/src/app
