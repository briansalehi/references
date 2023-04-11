#!/usr/bin/bash

if ! [ -f "$1" ]
then
    echo "usage: $0 <file>"
    exit 1
fi

chapter=0
line_number=0

while read -r line
do
    ((line_number++))

    if [ "${line:0:10}" == "## Chapter" ]
    then
        chapter="$(cut -d ' ' -f 3 <<< "$line" | cut -d '/' -f 1)"
    fi

    if [ "$line" == "<details>" ]
    then
        read -r body_line # summary
        ((line_number++))
        read -r body_line # separator
        ((line_number++))
        read -r body_line # first body line
        ((line_number++))

        while [ "$body_line" != "</details>" ]
        do
            sed -i "${line_number}s/^\(.*\)$/\> &/" "$1"
            read -r body_line
            ((line_number++))
        done

        if [ "$body_line" == "</details>" ]
        then
            sed -i "${line_number}s/^\(.*\)$/\> & \> Origin: $chapter \> References: ---/" "$1"
        fi
    fi
done < "$1"

sed -i 's,> \(</details>\) \(> Origin: [0-9.]*\) \(> References:\) \(---\),\n\2\n\n\3\n\4\n\1,' "$1"
