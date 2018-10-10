#!bash

set -x
cd $story_dir && sake finish 2>&1 |head -n 1
