#!/usr/bin/env sh
to=$1
two="${to:0:2}"
left="${to:2}"

if test "$left" = ""; then
    shift
    n=$1
else
    n="$left"
fi

file=$2
pre=$3

if test ! -f "$file"; then
    echo "${file} is not a file!!" 1>&2  && exit 2
fi
# -s 3 targetFile toWhere
function splitBySize() {
    cat $2 | du -k | awk '{print $1}' | xargs -I {} expr {} / $1 | xargs -I {} split -b {}k $2 $3
}

# -l 3 targetFile toWhere
function splitByLine() {
    cat $2 | wc -l | xargs -I {} expr {} / $1 | xargs -I {} split -l {} $2 $3 
}

if test "$two" = "-l"; then

    splitByLine $n $file $pre 
elif test "$two" = "-s"; then

    splitBySize $n $file $pre
fi
