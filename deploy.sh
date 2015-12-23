#!/bin/sh

git config --global user.name pomotvbot
git config --global user.email chris+pomotvbot@eidhof.nl
git remote set-url origin "https://${GH_TOKEN}@github.com/chriseidhof/pomotv.git"
bundle exec rake publish
