#!/usr/bin/env bash

listFolders(){

    git diff  "$1" --stat | sed  '$d' | awk -F '|' '{print $1}' |
    
    while read line 
    do
        folder=$(dirname $line)
        echo "${folder}/,"
    done

}


commit=$(git log | grep -a -1 'Merge:' | head -1 | cut -d " " -f 2)
    
[ ! -z "$1" ] && commit="$1"

str=$(listFolders "$commit" | uniq | xargs)

echo -e "\n              compare with \033[32m${commit}\033[0m : \n"

echo ${str%?} | sed 's/ //g'

echo 
