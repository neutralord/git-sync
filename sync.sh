#!/usr/bin/env bash

if [ -n "$1" ] ; then
    file_path=$1
else
    echo >&2 "You must specify path to target file"
    exit 1
fi

push_wait_timeout=${2:-60}
pull_wait_timeout=${3:-300}
last_push_time=0
last_pull_time=0

wait_timeout=10
commit_message=${4:-"file was changed"}

while true ; do
    while [ ! -f $file_path ] ; do
        sleep $wait_timeout
    done

    cd $( dirname $file_path )
    current_timestamp=$( date +"%s" )

    if [[ $current_timestamp -gt $(( $last_pull_time + $pull_wait_timeout )) ]] ; then
        git pull
        last_pull_time=$current_timestamp
    fi

    if [[ $current_timestamp -gt $(( $last_push_time + $push_wait_timeout )) ]] ; then
        file_state=$( git status --porcelain $file_path )
        if [[ "$file_state" =~ ^[[:space:]]M[[:space:]] ]] ; then
            git commit -m "$commit_message" $file_path
            git push origin HEAD
        fi
        last_push_time=$current_timestamp
    fi

    sleep $wait_timeout
done
