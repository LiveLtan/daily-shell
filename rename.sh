#!/bin/bash
################
##
##
##
##
################

myself=$(basename $0)

oldDir=$PWD
curDir=$1

function rename() {
    fileName=$1
    subDir=`echo $fileName | cut -d '-' -f2`
    targetName='drawable-'$subDir
    #mv $fileName $targetName
    echo "rename $fileName to  $targetName"
    mv $fileName $targetName
}

for file in `ls $curDir`; do
    if test $file = "$myself";then
        continue;
    fi
    rename $file
done
echo 'rename done'
