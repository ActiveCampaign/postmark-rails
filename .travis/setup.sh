#!/bin/bash

set -eax

echo "Configuring Ruby and Bundler..."
echo "TRAVIS_RUBY_VERSION=${TRAVIS_RUBY_VERSION}"

if [[ "$TRAVIS_RUBY_VERSION" < "2.3" ]];
then
  gem install bundler -v '< 2'
else
  gem update --system
  gem install bundler
fi
