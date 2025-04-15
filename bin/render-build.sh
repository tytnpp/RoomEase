# /usr/bin/env bash# exit on error
set -e errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean