#!/bin/sh
kill -9 $(cat pid_rack)
rackup -P pid_rack -E production -s thin -p 8001 -D