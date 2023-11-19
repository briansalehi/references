#!/usr/bin/env bash

pack_practice() {
    local line
    local body
    local origins
    local references
    local length
    local empty

    read -r question
    question="${question#<summary>}"
    question="${question%<\/summary>}"

    read -r empty # empty line

    echo -e "\e[1;34m\t${question}\e[0m"

    read -r line
    while [ "${line:0:1}" == ">" ]
    do
        length="${#line}"
        line="${line:2:length}"

        # filters
        [ "${line}" == "\`\`\`\`\`\`" ] && line="\`\`\`"

        body+="\t\t${line}\n"
        read -r line
    done
    echo -e "$body"

    read -r line
    if [ "$line" != "> Origins:" ]
    then
        echo -e "\e[1;31m""Origins displacement occured!""\e[0m"
        exit 128
    fi

    read -r line
    while [ "${line:0:1}" == ">" ]
    do
        length="${#line}"
        line="${line:4:length}"

        origins+="\t\t${line}\n"
        read -r line
    done

    read -r line
    if [ "$line" != "> References:" ]
    then
        echo -e "\e[1;31m""References displacement occured!""\e[0m"
        exit 129
    fi

    read -r line
    while [ "${line:0:1}" == ">" ]
    do
        length="${#line}"
        line="${line:4:length}"

        references+="\t\t${line}\n"
        read -r line
    done

    read -r empty # separator
    read -r empty # end of details tag

    if [ -n "${origins}" ]
    then
        echo -e "${origins}"
    else
        echo -e "\e[1;35m""\t\tNo origins""\e[0m"
    fi

    if [ -n "${references}" ]
    then
        echo -e "${references}"
    else
        echo -e "\e[1;35m""\t\tNo references""\e[0m"
    fi
}

iterate_topics() {
    local subject_path="$1"
    local line

    while read -r line
    do
        if [ "${line:0:2}" == "# " ]
        then
            continue;
        elif [ "${line:0:3}" == "## " ]
        then
            topic="${line#* }"
            echo -e "\e[1;33m""${topic}""\e[0m"
        elif [ "${line}" == "<details>" ]
        then
            pack_practice
        fi
    done < "$subject_path"
}

iterate_subjects() {
    local subject_path
    local subject

    for subject_path in topics/*
    do
        read -r subject < "$subject_path"
        subject="${subject#* }"

        echo -e "\e[1;31m""$subject""\e[0m"

        iterate_topics "$subject_path"
    done
}

iterate_subjects
