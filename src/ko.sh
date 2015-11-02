#!/usr/bin/env sh
# kill some process via name

# ko mysql / ko redis

name=$1 #目标名

if [ ! -n "$name" ]; then
	echo "useage : ko mysql"
	exit 1
fi

if [ ! -n "$symbol" ]; then
	symbol=9
fi

number=0
targets=`ps -ef | grep "$name" | grep -v grep | grep -v "ko $name"`
clear
IFS_old=$IFS
IFS=$'\n'
for line in $targets; do
	echo $line | grep --color=auto "$name"
	echo
	let number+=1
done
IFS=IFS_old

if [ "$number" -eq 0 ]; then
	echo "not found any process like \"$name\""	
	exit 1
fi

echo " \033[31m !!! \033[33m ko all the \033[32m`echo $number` \033[0mprocesses? (y) | no( n/ctrl+c) : \c" 

read -n 1 -t 8 need

if [ ! -n "$need" ];then
    exit 2
fi

case $need in 
	yes|y)
		echo "$targets" | awk '{print $2}' | xargs kill -9 
		exit 0
		;;
	no|n)
		exit 0
		;;
	*)
		echo 
		echo "\033[33m I have beening waiting for you many years, just to get a 'y' or 'n' ..."
        echo " \033[32mnow you told me ${need} ?"
        echo
        exit 3
		;;
esac
