FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential

RUN mkdir /status-page
WORKDIR /status-page

RUN gem install thor
RUN gem install oga
RUN gem install rspec
RUN gem install time_difference
RUN gem install command_line_reporter

ADD . /status-page
