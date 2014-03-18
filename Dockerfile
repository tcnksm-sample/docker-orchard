FROM ubuntu

# Install basic dev tools 
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    git

# Install package for ruby 
RUN apt-get install -y \
    zlib1g-dev \
    libssl-dev \
    libreadline-dev \
    libyaml-dev \
    libxml2-dev \
    libxslt-dev

# Install package for sqlite3
RUN apt-get install -y \
    sqlite3 \
    libsqlite3-dev

# Install package for postgresql
RUN apt-get install -y libpq-dev 

# Install ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git .ruby-build
RUN .ruby-build/install.sh
RUN rm -fr .ruby-build

# Install ruby-2.0.0-p247
RUN ruby-build 2.0.0-p247 /usr/local

# Install bundler
RUN gem update --system
RUN gem install bundler --no-rdoc --no-ri

# Add application
RUN mkdir /myapp
WORKDIR /myapp
ADD todo-rails4-angularjs/Gemfile /myapp/Gemfile
RUN bundle install
ADD todo-rails4-angularjs /myapp

ENTRYPOINT ["bash", "-l", "-c"]

