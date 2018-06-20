#!/bin/bash
if [ $# -ne 3 ];then
    echo "usage : $0 character out_file file_size(Byte)"
    exit 1
fi

echo "$1" | grep -q "^[a-zA-Z]$"
if [ $? -ne 0 ];then
    echo "arg1 must be character"
    exit 1
fi

character=$1
out_file=$2
target_size=$3

# echo输出默认是带'\n'字符的，所以需要通过dd指定输入字节数
echo "$character" | dd of=$out_file ibs=1 count=1
while true
do
    cur_size=`du -b $out_file | awk '{print $1}'`
    if [ $cur_size -ge $target_size ];then
        break
    fi
    remain_size=$((target_size-$cur_size))
    if [ $remain_size -ge $cur_size ];then
        input_size=$cur_size
    else
        input_size=$remain_size
    fi
    dd if=$out_file ibs=$input_size count=1 of=$out_file seek=1 obs=$cur_size || exit 1
done
