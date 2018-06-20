#!/bin/bash

if test "$2" = "";then
    echo "target file need..."
    exit 1;
fi

oldDir=`pwd`

stringXmlFile=$oldDir/$1
targetXmlFile=$oldDir/$2

allItem=`cat $stringXmlFile | awk '{print $5}' | cut -d ':' -f1`
#allItem=`head -10 $stringXmlFile | awk '{print $5}' | cut -d ':' -f1`

saveString() {
    target=$1
    echo -e "$target" >> $targetXmlFile
}


#echo > $targetXmlFile
cat /dev/null > $targetXmlFile
saveString '<resources xmlns:xliff="urn:oasis:names:tc:xliff:document:1.2">'
saveString '    <string-array name="theLauncherStrings">'

for item in $allItem
do
    saveString '        <item>'$item'</item>'
done

saveString '    </string-array>'
saveString '</resources>'
