FROM debian:wheezy
ENV DEBIAN_FRONTEND noninteractive

# nginx

RUN apt-get -y update && apt-get -y upgrade && apt-get install -y supervisor nginx wget vim curl

# hhvm
RUN echo deb http://dl.hhvm.com/debian wheezy main | tee /etc/apt/sources.list.d/hhvm.list
RUN wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add -
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y hhvm

#nodejs

RUN curl -sL https://deb.nodesource.com/setup_0.12 |  bash -
RUN apt-get install -y build-essential && apt-get install -y nodejs 

#phantomjs

RUN npm install -g phantomjs
RUN rm /etc/nginx/sites-enabled/default

# 
RUN apt-get install -y php5-sqlite sqlite3
RUN mkdir /work/

ADD service.conf /etc/supervisor/conf.d/service.conf
ADD sites-enabled /etc/nginx/sites-enabled/

WORKDIR /work/
ADD .  /work/
RUN cat setup.sql | sqlite3 database.db
EXPOSE 80
CMD ["/bin/dash", "./entrypoint.sh"]
