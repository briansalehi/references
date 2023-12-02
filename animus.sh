#!/usr/bin/env bash

VERBOSE="${VERBOSE:-false}"
base_path="/tmp/animus"

unpack_practice() {
    local buffer="$1"
    local subject="$2"
    local topic="$3"
    local line
    local body
    local origins
    local references
    local length

    read -r question
    question="${question#<summary>}"
    question="${question%<\/summary>}"

    read -r # empty line

    #echo -e "> ${subject} » ${topic}" >> "${buffer}"
    {
        echo '<style>'
        echo 'h1,h2,h3,p,ul,li { color: #cacaca; }'
        echo 'pre { background: #202020; }'
        echo 'body { background: #383838; }'
        echo '</style>'
    } >> "${buffer}"
    echo -e "# ${question}\n\n" >> "${buffer}"

    read -r line
    while [ "${line:0:1}" == ">" ]
    do
        length="${#line}"
        line="${line:2:length}"

        # filters
        [ "${line}" == "\`\`\`\`\`\`" ] && line="\`\`\`"

        body+="${line}\n"
        read -r line
    done
    echo -e "$body" >> "${buffer}"

    read -r line
    if [ "$line" != "> Origins:" ]
    then
        echo -e "\e[1;31m""Origins displacement occured!""\e[0m" >&2
        exit 127
    fi

    origins="## Origins\n\n"

    read -r line
    while [ "${line:0:1}" == ">" ]
    do
        length="${#line}"
        line="${line:2:length}"

        origins+="${line}\n"
        read -r line
    done

    read -r line
    if [ "$line" != "> References:" ]
    then
        echo -e "\e[1;31m""References displacement occured!""\e[0m" >&2
        exit 126
    fi

    references="## References\n\n"

    read -r line
    while [ "${line:0:1}" == ">" ]
    do
        length="${#line}"
        line="${line:2:length}"

        references+="${line}\n"
        read -r line
    done

    read -r # separator
    read -r # end of details tag

    if [ -n "${origins}" ]
    then
        echo -e "${origins}" >> "${buffer}"
    else
        $VERBOSE && echo -e "\e[1;35m""No origins""\e[0m" >&2
    fi

    if [ -n "${references}" ]
    then
        echo -e "${references}" >> "${buffer}"
    else
        $VERBOSE && echo -e "\e[1;35m""No references""\e[0m" >&2
    fi
}

unpack_topics() {
    local subject_path="$1"
    local subject_file="$2"
    local subject="$3"
    local practice_path
    local practice_hash
    local record_list="/tmp/animus-data"
    local topic_file
    local number=0
    local index
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
            index="$(printf "%02d" $number)"
            topic="${line#* }"
            topic_file="${index}.${topic// /-}"

            $VERBOSE && echo -e "\e[1;33m""${topic}""\e[0m"

            if ! [ -d "${base_path}/${subject_file}/${topic_file}" ]
            then
                mkdir -p "${base_path}/${subject_file}/${topic_file}"
            fi
        elif [ "${line}" == "<details>" ]
        then
            unpack_practice "${buffer}" "${subject}" "${topic}"

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

unpack_subjects() {
    local subject_path
    local subject_file
    local subject

    $VERBOSE && echo -e "\e[1;35m""Unpacking practice files""\e[0m"
    for subject_path in topics/[a-z]*.md
    do
        read -r subject < "$subject_path"
        subject="${subject#* }"
        subject_file="${subject// /-}"

        $VERBOSE && echo -e "\e[1;31m""$subject""\e[0m"

        if ! [ -d "${base_path}/${subject}" ]
        then
            mkdir -p "${base_path}/${subject_file}"
        fi

        unpack_topics "$subject_path" "$subject_file" "$subject"
    done
}

prompt_subject_options() {
    local subject="$1"
    local response

    echo -e "\nSubject: \e[1;33m${subject_name}\e[0m?\n" >&2
    select response in "Enter Subject" "Next Subject"
    do
        echo "$response"
        break
    done
}

prompt_topic_options() {
    local topic_name="$1"
    local response

    echo -e "\nTopic: \e[1;33m${topic_name%%.*}. ${topic_name#*.}\e[0m?\n" >&2
    select response in "Select Topic" "Next Topic" "Next Subject"
    do
        echo "$response"
        break
    done
}

prompt_practice_options() {
    local topic_name="$1"
    local success="$2"
    local response

    echo -e "\nPractice: ?\n" >&2
    select response in "Keep working" "Next Topic"
    do
        echo "$response"
        break
    done
}

preview_practice() {
    local practice="$1"
    local buffer="$2"
    local response

    if ! [ -f "$practice" ] || ! [ -f "$buffer" ]
    then
        echo -e "\e[1;31m""Practice file missing""\e[0m" >&2
    elif ! [ -f "$buffer" ]
    then
        echo -e "\e[1;31m""Buffer is missing""\e[0m" >&2
    fi

    cp "$practice" "$buffer"

    # shellcheck disable=SC2009
    if ! ps -ef | grep -w livedown | grep -qv grep
    then
        livedown start "$buffer" --open &>/dev/null &
    fi

    return 0
}

begin_review() {
    local -a subject_list
    local subject
    local topic
    local -a topic_list
    local topic_budget
    local -a practice_list
    local practice
    local subject_task
    local topic_task
    local practice_task
    local success
    local subject_name
    local topic_name
    local buffer="/tmp/animus.html"

    readarray -t subject_list < <(find "${base_path}" -mindepth 1 -maxdepth 1)

    for subject in "${subject_list[@]}"
    do
        subject_name="$(basename "$subject" | tr '-' ' ')"
        subject_task="$(prompt_subject_options "$subject_name")"

        case "${subject_task}" in
            "Next Subject") continue ;;
        esac

        readarray -t topic_list < <(find "${subject}" -mindepth 1 -maxdepth 1 | sort)

        for topic in "${topic_list[@]}"
        do
            topic_name="$(basename "$topic" | tr '-' ' ')"
            topic_task="$(prompt_topic_options "$topic_name")"

            case "${topic_task}" in
                "Next Topic") continue ;;
                "Next Subject") break ;;
            esac

            readarray -t practice_list < <(find "${topic}" -type f)

            if [ "${#practice_list[*]}" -eq 0 ]
            then
                echo -e "\e[1;31m""${topic_name} has no practice""\e[0m" >&2
            fi

            for practice in "${practice_list[@]}"
            do
                success=false

                if preview_practice "${practice}" "${buffer}"
                then
                    success=true
                fi

                practice_task="$(prompt_practice_options "${topic_name}" "$success")"

                case "${practice_task}" in
                    "Next Topic") break ;;
                esac

                echo -e "$practice"
            done

            topic_budget="${#topic_list[*]}"
            echo "${topic_budget}" >/dev/null
        done
    done

    # shellcheck disable=SC2009
    if ps -ef | grep -w livedown | grep -qv grep
    then
        livedown stop
    fi
}

if [ -d "${base_path}" ]
then
    rm -r "${base_path}"
fi

unpack_subjects
begin_review
