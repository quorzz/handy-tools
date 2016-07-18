#!/usr/bin/env bash

# sign  nice to meet you
# sign  nice to meet you | sign

# so interesting,  ha?


if [[ $# -gt 0 ]];then

    echo "$*" | tr a-zA-Z n-za-mN-ZA-M
else

    echo $(cat) | tr a-zA-Z n-za-mN-ZA-M
fi
