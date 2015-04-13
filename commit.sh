#!/bin/bash

line=' ===== '
if [ -z "$1" ]; then
    echo "$line"" Commit message is empty. Please add commit message ""$line"
    exit 1
fi

echo ""
echo $line' add files (*.h *.m *.json *.pch *.xcscheme *.xib *.plist *.sh *.pbxproj *.png *.proto)  '$line

git add *.h *.m *.json *.pch *.xcscheme *.xib *.plist *.sh *.pbxproj *.png *.proto

echo ''
echo $line' checkout unuse files ( *xcuserstate *DS_Store)  '$line

git checkout *xcuserstate 
git checkout *DS_Store

echo ''

echo $line' Commit files. Comment: '"$1"" "$line

git commit -m "$1"

echo ''

if [ x$2 = x ]
    then
        echo $line' Pull code from server '$line
        git pull
        echo ''
    else
        echo $line' Skip pull from server '$line
fi

echo $line' Push code to server '$line

git push

echo ''
echo $line' Congratulations! Hope there is no conflict! '$line
echo ''
