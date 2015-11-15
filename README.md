# HanndyTools
some of the tools that I daily use, mainly shell, python or php scripts

## NOTICE : 
I have just used these scripts in the OSX

So I can't ensure that they can work well under linux or other environment

*** 

**1. hs** 

    script : src/hs.sh

    filter duplicate and short command.
    it's more frindly and easy-use than the build-in history 
    and it also displays better.
    
    TODO : the filter via days and weeks

| commad        | tips           | more  |
| ------------- |:-------------: | -----:|
| hs            | the last 20 (default 20, and you can change it) |  |
| hs -10        | the last 10        |    |
| hs 10         | the earliest 10      |     |
| hs a          | all      |     |
| hs -c         | backup history, then clear it      |     |

***

**2. ko**

    script : src/ko.sh
    
    kill processes by %name%

![ko redis](https://github.com/quorzz/HandyTools/blob/master/images/ko01.png)

***

**3. spto**
    
    script : src/spto.sh

    split file to n pieces, for example : 

    split ~/a.log into 3 pieces, store in ~/pieces/ with a prefix 'pre' each : 

    spto -l 3 ~/a.log ~/pieces/pre (by lines)

    spto -s 3 ~/a.log ~/pieces/pre (by sizes)

***

**4. tree**
    
    script : src/tree.php   or   src/tree.go

    output the dir in tree structure, for example : 

    tree : current directory for complete display

    tree ~/workspace : complete display in ~/workspace

    tree ../workspace 2 : only display 2 level in ~/workspace

    besides, green for directory and yellow for file
***
