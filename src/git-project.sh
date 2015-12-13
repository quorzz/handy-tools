#!/usr/bin/env sh

# git project [git裸库位置,可选] [项目目录,可选]
# 
# 1. 创建一个 git 裸库 [如果已存在, 则跳过]
# 2. 在裸库上建立钩子 [每次接受到commit, 自动同步到指定项目目录]

repositoryDir=$1 # first param : path to the git bare repository
projectDir=$2 # second param : the path where to autosyn every time you commit

test -z $repositoryDir && read -p "path to the bare repository : " repositoryDir

test -d $repositoryDir || (echo "${repositoryDir} is not a dir!" 1>&2 && exit 1)

currentDir=$(pwd)
# test -z $projectDir && projectDir=$currentDir 
test -z $projectDir && read -p "path to your project : " projectDir

test -d $projectDir || (echo "${projectDir} is not a dir!" 1>&2 && exit 1)

repositoryDir=$(cd $repositoryDir; pwd)
projectDir=$(cd $projectDir; pwd)
cd $currentDir

hookContent="#!/usr/bin/env sh

# GIT_WORK_TREE  :  the path where to autosyn codes every time you commit works

echo 'transfer the code you commit now ......'

while read oldrev newrev refname
do
    git show --no-color --root -s --pretty=medium $newrev
done

GIT_WORK_TREE=${projectDir}     git checkout -f

echo 'done ......'
"

function initBareRepository()
{
    if [ -f ${repositoryDir}/HEAD ];then
        echo "$repositoryDir is already a bare repository. skiping......"
    else
        git init $repositoryDir --bare
    fi
}

function initPostUpdate()
{
    hook=${repositoryDir}/hooks/post-update
    overwrite="y"
    test -f $hook && read -p "!!! ${hook} already exist, overwrite?[y/n]" overwrite
    if [[ "y" = "$overwrite" ]];then
        echo "$hookContent" > $hook
        chmod a+x $hook
        echo "create a hook to autosyn codes to ${projectDir} every time you commit"
    else
        echo "the hook is already exist, skiping......"
    fi
}

initBareRepository;
echo
initPostUpdate;
echo
echo "done!"
