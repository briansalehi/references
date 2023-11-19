#!/usr/bin/env bash

VERBOSE="${VERBOSE:-false}"
base_path="/tmp/animus"

unpack_practice() {
    local line
    local body
    local origins
    local references
    local length

    read -r question
    question="${question#<summary>}"
    question="${question%<\/summary>}"

    read -r # empty line

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
        echo -e "\e[1;31m""Origins displacement occured!""\e[0m" >&2
        exit 127
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
        echo -e "\e[1;31m""References displacement occured!""\e[0m" >&2
        exit 126
    fi

    read -r line
    while [ "${line:0:1}" == ">" ]
    do
        length="${#line}"
        line="${line:4:length}"

        references+="\t\t${line}\n"
        read -r line
    done

    read -r # separator
    read -r # end of details tag

    if [ -n "${origins}" ]
    then
        echo -e "${origins}"
    else
        $VERBOSE && echo -e "\e[1;35m""\t\tNo origins""\e[0m" >&2
    fi

    if [ -n "${references}" ]
    then
        echo -e "${references}"
    else
        $VERBOSE && echo -e "\e[1;35m""\t\tNo references""\e[0m" >&2
    fi
}

iterate_topics() {
    local subject_path="$1"
    local subject_file="$2"
    local practice_path
    local practice_hash
    local record_list="/tmp/animus-data"
    local topic_file
    local number=0
    local buffer="/tmp/animus-buffer"
    local topic
    local line

    while read -r line
    do
        if [ "${line:0:2}" == "# " ]
        then
            continue;
        elif [ "${line:0:3}" == "## " ]
        then
            number=$((number + 1))
            topic="${line#* }"
            topic_file="${number}.${topic// /-}"

            $VERBOSE && echo -e "\e[1;33m""${topic}""\e[0m"

            if ! [ -d "${base_path}/${subject_file}/${topic_file}" ]
            then
                mkdir -p "${base_path}/${subject_file}/${topic_file}"
            fi
        elif [ "${line}" == "<details>" ]
        then
            practice="$(unpack_practice)"
            echo -e "$practice" > "${buffer}"

            practice_hash="$(md5sum "$buffer" | cut -d' ' -f1)"
            practice_path="${base_path}/${subject_file}/${topic_file}/${practice_hash}"

            if ! [ -d "$practice_path" ]
            then
                mv "${buffer}" "${practice_path}"
                echo "${practice_hash} ${practice_path}" >> "$record_list"
            fi
        fi
    done < "$subject_path"
}

iterate_subjects() {
    local subject_path
    local subject_file
    local subject

    for subject_path in topics/*
    do
        read -r subject < "$subject_path"
        subject="${subject#* }"
        subject_file="${subject// /-}"

        $VERBOSE && echo -e "\e[1;31m""$subject""\e[0m"

        if ! [ -d "${base_path}/${subject}" ]
        then
            mkdir -p "${base_path}/${subject_file}"
        fi

        iterate_topics "$subject_path" "$subject_file"
    done
}

iterate_subjects
