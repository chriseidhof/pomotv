#!/bin/sh

rvm $TRAVIS_RUBY_VERSION do bundle install --jobs=3 --retry=3 --deployment --path=${BUNDLE_PATH:-vendor/bundle}
git config --global user.name pomotvbot
git config --global user.email chris+pomotvbot@eidhof.nl
git remote set-url origin "https://${GH_TOKEN}@github.com/chriseidhof/pomotv.git"
rvm $TRAVIS_RUBY_VERSION do bundle exec rake publish
