#!/bin/bash
#export PATH

function traverse(){  
    for file in `ls $1`
    do  
    	filename="$1/$file"
        if [ -d $filename ]
        then  
             traverse $filename
        else  
        	
        	filetype=`file $filename`
        	if [[ $filetype =~ "text" ]]; then
        		#echo "check file $filename"
        		#\grep --color=auto -A 20 $KEY_WORLD $filename
        		count=`grep -c "$KEY_WORLD" $filename`
        		if (( $count > 0 )); then
        			echo ">>>>>>>>>>>>>>>>>> Crash execption found at file $file:"
             		\grep --color=auto -A 40 -B 5 "$KEY_WORLD" $filename
                    echo "---------------------------------------------"
             	#else
             	#	echo "empty"
             	fi

            #else
            	#echo "not ASCII file: $filename"
            fi
        fi
    done
}


#main

##config
#seach key

if [ -z $2 ];then
    KEY_WORLD="FATAL EXCE"
else
    KEY_WORLD=$2
fi
    
echo "key: $KEY_WORLD"
TEMP_DIR=`date +%s`
#echo "temp dir is $TEMP_DIR"
#echo $#
if [ $# -lt 1 ]; then
	echo "please special the log compress file(7z, rar or zip)"
fi

if [[ $1 =~ ".7z" ]]; then
	#echo "file is 7z" 
	7zr e $1 -o$TEMP_DIR > /dev/null
elif [[ $1 =~ ".rar" ]]; then
	mkdir $TEMP_DIR 
	#echo "file is rar" 
	unrar e $1 $TEMP_DIR > /dev/null
elif [[ $1 =~ ".zip" ]]; then
	#echo "file is zip"
	unzip $1 -d $TEMP_DIR > /dev/null
elif [[ $1 =~ ".tar.bz2" ]]; then
    mkdir $TEMP_DIR
    tar -jxf $1 -C $TEMP_DIR
else
	echo "invalid file $1, file should be 7z, zip or rar"
	exit 1
fi
	echo "start search crash logs info..."
	traverse $TEMP_DIR
	#delete temp dir
	\rm -fr $TEMP_DIR

exit 0

