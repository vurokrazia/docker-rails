FROM ruby:2.6.0

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

RUN mkdir -p /home/app
WORKDIR /home/app

COPY ./src/Gemfile ./
COPY ./src/Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the main application.
COPY ./src/ ./
RUN pwd >> r.sh
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3000
RUN ["rm", "-f", "./tmp/pids/server.pid"]
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]