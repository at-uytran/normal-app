FROM ruby:2.5.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# RUN yes | apt-get install software-properties-common
# RUN add-apt-repository ppa:jonathonf/ffmpeg-4
# RUN apt-get update
RUN yes | apt-get install ffmpeg
# RUN apk add  --no-cache ffmpeg
RUN yes | apt-get install ffmpegthumbnailer

RUN mkdir -p /usr/src/app
RUN mkdir -p /usr/src/app/hls-data
RUN mkdir -p /usr/src/app/download_videos
RUN mkdir -p /usr/src/app/stream_folder
WORKDIR /usr/src/app

COPY . /usr/src/app

RUN rm ./Gemfile.lock

# RUN bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java
RUN cd tmp/cache && bundle install

EXPOSE 3000
