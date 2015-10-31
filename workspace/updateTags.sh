#!/bin/bash

########################################
#This file will generate ctags
#for all files located beneath the given
#directory
#
#if passed a directory will use that as the base.
#
#It only generate tags for projects which have a git
#repo set up at their root (any directory containing
#a .git directory)
##################################

#Associated crontab entry
# 01 2 * * * /home/solter/workspace/updateTags.sh /home/solter/workspace > /home/solter/.logs/updateTags.log 2>&1

TOP_DIR=$1
if [ -z $TOP_DIR ]; then
    TOP_DIR=$(pwd)
fi

echo $TOP_DIR

#for all root file directories (those containing .git files)
for rootdir in $(find "$TOP_DIR" -type d -name '.git'); do
    rootdir_nongit=$(echo $rootdir | sed -e 's|/[^/]*$||');
    echo "searching $rootdir_nongit"
    #for all relevant subdirectories (don't descend into hidden, ext, doc, docs, nor bin directories)
    for subdir in $(find $rootdir_nongit -type d \( -name '.*' -o -name 'ext' -o -name 'doc' -o -name 'docs' -o -name 'bin' \) -prune -o -type d -print); do
        #update the local directories ctags file if it exists
        cd "$subdir"
        echo "entering $subdir and creating ctags"
        ctags -f .tags --format=2 --excmd=mixed --extra=+q+f --fields=nKsaSmtl *;
        ISEMPTY=$(wc -l .tags | sed -e 's/\([0-9]*\).*/\1/')
        if [ $ISEMPTY -le 6 ]; then
          echo "empty ctags file, so deleting"
          rm .tags  
        fi
    done
    #update the much more massive project ctags
    cd "$rootdir_nongit"
    echo "entering $subdir and creating master ctags"
    ctags -f .tags --format=2 --excmd=mixed --extra=+q+f --fields=nKsaSmtl --file-scope=no -R *;
done
