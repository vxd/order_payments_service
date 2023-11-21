FROM ruby:3.2.2
ADD . /app
WORKDIR /app
RUN bundle i
EXPOSE 4567
CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "4567"]
