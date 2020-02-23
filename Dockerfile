FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /home/app
WORKDIR /home/app
COPY ./src/Gemfile /home/app/Gemfile
COPY ./src/Gemfile.lock /home/app/Gemfile.lock
RUN gem install bundler
RUN gem install rails
RUN bundle install
COPY ./src /home/app
# Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
RUN pwd >> r.sh
RUN ["rm", "-f", "./tmp/pids/server.pid"]

# Start the main process.
CMD ["rails", "s", "-b", "0.0.0.0"]