#!/bin/sh
kill -9 $(cat pid)
RACK_ENV=production WAIT_TIME=0.1 bundle exec ruby server.rb -l logs/log.log -P pid -sv -e prod -p 8000 -d