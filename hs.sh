#!/usr/bin/env sh

# frindly 'history'
# 过滤重复命令 && 过滤短命令 && 友好显示
# todo 时间范围筛选

# hs       :  默认值[defaultNumber参数]
# hs -10   :  最近10条
# hs 10    :  最早10条
# hs a     :  全部

# 显示命令的最短长度
minLength=6

# 默认值;
defaultNumber=-20

historyFile=~/.zsh_history
firstParam=$1

if [ ""x = "$firstParam"x ]; then
    firstParam=$defaultNumber
fi

if [ "-"x = "${firstParam:0:1}"x ]; then
    commandStr=tail
    line=${firstParam:1}
else
    commandStr=head
    line=$firstParam
fi

# 备份 并 清空historyFile
if [ "c"x = "$line"x ]; then
    cat $historyFile >> "$historyFile"_bak
    echo '' > $historyFile
    source ~/.zshrc
    exit 0
fi

# 判断正整数
function isUnsignedInt(){
    x=$(echo "$1" | grep '^[0]*\([1-9]\+[0-9]*\)$')
    
    if [ "$x"x = ""x ]; then
        return 1 # 非正整数 
    fi
    return 0 # 正整数
}

isUnsignedInt $line; ret=$?

if [ $ret = 0 ]; then

    # 9 head -9  or -9 tail -9
    awk -v l=$minLength -F";" '{a="";for(i=2;i<=NF;i++){a=a";"$i} if((!b[a]++)&&(length(a)>l)){ print "\033[33m" NR "\033[0m", "", "\033[32m" substr(a,2) "\033[0m"}}' $historyFile | $commandStr -$line
else

    # 随便输入的非正整数
    awk -v l=$minLength -F";" '{a="";for(i=2;i<=NF;i++){a=a";"$i} if((!b[a]++)&&(length(a)>l)){ print "\033[33m" NR "\033[0m", "", "\033[32m" substr(a,2) "\033[0m"}}' $historyFile
fi
