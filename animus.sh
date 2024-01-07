#!/usr/bin/env bash

VERBOSE="${VERBOSE:-false}"
base_path="/tmp/animus"

unpack_practice() {
    local buffer="$1"
    local subject="$2"
    local topic="$3"
    local line
    local lineno
    local body
    local origins
    local references
    local length

    read -r question
    question="${question#<summary>}"
    question="${question%<\/summary>}"

    read -r # empty line

    echo -e "# ${question}\n\n" >> "${buffer}"

    lineno=0
    read -r line
    while [ "${line:0:1}" == ">" ]
    do
        _=$((lineno++))
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
        echo -e "\e[1;31m""Origins displacement occured on line $lineno""\e[0m" >&2
        exit 127
    fi

    origins="## Origins\n\n"

    lineno=0
    read -r line
    while [ "${line:0:1}" == ">" ]
    do
        _=$((lineno++))
        length="${#line}"
        line="${line:2:length}"

        origins+="${line}\n"
        read -r line
    done

    read -r line
    if [ "$line" != "> References:" ]
    then
        echo -e "\e[1;31m""References displacement occured on line $lineno""\e[0m" >&2
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
    local topic_count

    topic_count="$(grep -cw '^##' "$subject_path")"

    while read -r line
    do
        if [ "${line:0:2}" == "# " ]
        then
            continue;
        elif [ "${line:0:3}" == "## " ]
        then
            number=$((number + 1))
            digits="${#topic_count}"
            index="$(printf "%0${digits}d" $number)"

            if [ "${line:0:10}" == "## Chapter" ]
            then
                # shellcheck disable=SC2001
                topic="$(sed "s,## Chapter \([0-9]\+\)\/[0-9]\+.*,\1," <<< "$line")"
            else
                topic="${line#* }"
            fi

            topic_file="${base_path}/${subject_file}/${index}.${topic// /-}"

            $VERBOSE && echo -e "\e[1;35m""  Unpacking Topic «\e[1;34m${topic}\e[1;35m» in \e[1;34m${topic_file}""\e[0m"

            if ! [ -d "${topic_file}" ]
            then
                mkdir -p "${topic_file}"
            fi
        elif [ "${line}" == "<details>" ]
        then
            unpack_practice "${buffer}" "${subject}" "${number}"

            practice_hash="$(md5sum "$buffer" | cut -d' ' -f1)"
            practice_path="${topic_file}/${practice_hash}"

            $VERBOSE && echo -e "\e[1;35m""    Unpacking Practice «\e[1;34m${practice_hash}\e[1;35m» in \e[1;34m${topic_file}""\e[0m"
            if ! [ -d "$practice_path" ]
            then
                mv "${buffer}" "${practice_path}"
                echo "${practice_hash} ${practice_path}" >> "$record_list"
            fi
        fi
    done < "$subject_path"
}

unpack_subjects() {
    local base="${1:-topics/*.md}"
    local subject_path
    local subject_file
    local subject

    for subject_path in ${base}
    do
        read -r subject < "$subject_path"
        subject="${subject#* }"
        subject_file="${subject// /-}"

        $VERBOSE && echo -e "\e[1;35m""Unpacking «\e[1;34m${subject}\e[1;35m» in \e[1;34m${subject_file}""\e[0m"

        if ! [ -d "${base_path}/${subject}" ]
        then
            mkdir -p "${base_path}/${subject_file}"
        fi

        unpack_topics "$subject_path" "$subject_file" "$subject"
    done
}

is_numeric() {
    local value="$1"

    case "$value" in
        ''|*[!0-9]*) return 1 ;;
        *) return 0 ;;
    esac
}

is_in_range() {
    local value="$1"
    local min="$2"
    local max="$3"

    [ "$value" -ge "$min" ] && [ "$value" -le "$max" ] && return 0
    return 1
}

generic_select() {
    local title="$1"; shift
    local index=0
    local option_index
    local -a options

    while [ $# -gt 0 ]; do options+=("$1"); shift; done

    while [ $index -lt ${#options[*]} ]
    do
        echo -e "$((index + 1))) ${options[$index]}" >&2
        index=$((index + 1))
    done

    while ! is_numeric "$option_index" || ! is_in_range "$option_index" 1 "${#options[*]}"
    do
        echo -ne "${title} " >&2
        read -r option_index
    done

    echo -e "${options[$((option_index - 1))]}"
}

preview_practice() {
    local practice="$1"
    local buffer="$2"

    if ! [ -f "$practice" ]
    then
        echo -e "\e[1;31m""Practice file missing""\e[0m" >&2
    elif ! [ -f "$buffer" ]
    then
        echo -e "\e[1;31m""Buffer is missing""\e[0m" >&2
    fi

    {
        echo '<style>'
        echo 'h1,h2,h3,p,ul,li { color: #cacaca; }'
        echo 'pre { background: #202020; }'
        echo 'body { background: #383838; }'
        echo '</style>'
        echo
        cat "$practice"
    } > "${buffer}"

    # shellcheck disable=SC2009
    if ! ps -ef | grep -w livedown | grep -qv grep
    then
        livedown start "$buffer" "${WEB}" &>/dev/null &
    fi

    return 0
}

is_valid_range() {
    if is_numeric "$1" && is_in_range "$1" "$2" "$3"
    then
        return 0
    fi

    return 1
}

begin_review() {
    local -a subject_list
    local subject
    local topic
    local -a topic_list
    local -a practice_list
    local practice
    local subject_task
    local topic_task
    local practice_task
    local subject_name
    local topic_name
    local buffer="/tmp/animus.html"
    local subject_index=0
    local topic_index=0
    local practice_index=0
    local skip_request=0

    readarray -t subject_list < <(find "${base_path}" -mindepth 1 -maxdepth 1)

    subject_index=0
    while [ $subject_index -ge 0 ] && [ $subject_index -lt ${#subject_list[*]} ]
    do
        subject_name="$(basename "${subject_list[$subject_index]}" | tr '-' ' ')"

        if [ $subject_index -eq 0 ] && [ ${#subject_list[*]} -eq 1 ]
        then
            echo -e "\e[1;35mAuto Selected Subject «\e[1;34m ${subject_name} \e[1;35m»\e[0m""\e[0m\n" >&2
        elif [ $subject_index -eq 0 ]
        then
            subject_task="$(generic_select "\e[1;35mSubject \e[1;34m$((subject_index + 1))/${#subject_list[*]}. ${subject_name} \e[1;35m»\e[0m" "Select Subject" "Next Subject" "Skip to" "Exit Training")"

            case "${subject_task}" in
                "Select Subject") ;;
                "Next Subject") subject_index=$((subject_index + 1)); echo; continue ;;
                "Skip to")
                    for sindex in $(seq 0 "$((${#subject_list[*]}-1))")
                    do
                        sname="${subject_list[$sindex]}"
                        sname="${sname##*/}"
                        echo -e "\t\e[3;35m$((sindex+1)). $sname\e[0m"
                    done
                    read -rp "Expected Section: " skip_request </dev/tty
                    while ! is_valid_range "$skip_request" 1 "${#subject_list[*]}"

                    do
                        read -rp "Expected Section: " skip_request </dev/tty
                    done
                    subject_index=$((--skip_request))
                    skip_request=
                    continue ;;
                "Exit Training") echo; break ;;
            esac
            echo
        elif [ $((subject_index + 1)) -eq ${#subject_list[*]} ]
        then
            subject_task="$(generic_select "\e[1;35mSubject \e[1;34m$((subject_index + 1))/${#subject_list[*]}. ${subject_name} \e[1;35m»\e[0m" "Select Subject" "Finish Training" "Previous Subject")"

            case "${subject_task}" in
                "Select Subject") ;;
                "Previous Subject") subject_index=$((subject_index - 1)); echo; continue ;;
                "Finish Training") echo; break ;;
            esac
            echo
        else
            subject_task="$(generic_select "\e[1;35mSubject \e[1;34m$((subject_index + 1))/${#subject_list[*]}. ${subject_name} \e[1;35m»\e[0m" "Select Subject" "Next Subject" "Previous Subject" "Exit Training")"

            case "${subject_task}" in
                "Select Subject") ;;
                "Next Subject") subject_index=$((subject_index + 1)); echo; continue ;;
                "Previous Subject") subject_index=$((subject_index - 1)); echo; continue ;;
                "Exit Training") echo; break ;;
            esac
            echo
        fi

        readarray -t topic_list < <(find "${subject_list[$subject_index]}" -mindepth 1 -maxdepth 1 | sort)
        subject_index=$((subject_index + 1))

        topic_index=0
        while [ $topic_index -ge 0 ] && [ $topic_index -lt ${#topic_list[*]} ]
        do
            topic_name="$(basename "${topic_list[$topic_index]}" | tr '-' ' ')"

            readarray -t practice_list < <(find "${topic_list[$topic_index]}" -type f)

            if [ "${#practice_list[*]}" -eq 0 ]
            then
                echo -e "\e[1;31m""${topic_name%%.*}. ${topic_name#*.} has no practice""\e[0m" >&2
            elif [ $topic_index -eq 0 ] && [ ${#topic_list[*]} -gt 1 ]
            then
                topic_task="$(generic_select "\e[1;35mTopic \e[1;33m$((topic_index + 1))/${#topic_list[*]}. ${topic_name#*.} \e[1;35m»\e[0m" "Select Topic" "Next Topic" "Skip to" "Next Subject")"

                case "${topic_task}" in
                    "Select Topic") ;;
                    "Next Topic") topic_index=$((topic_index + 1)); echo; continue ;;
                    "Next Subject") echo; break ;;
                    "Skip to")
                        for tindex in $(seq 0 "$((${#topic_list[*]}-1))")
                        do
                            tname="${topic_list[$tindex]}"
                            tname="${tname##*/}"
                            echo -e "\t\e[3;35m$((tindex+1)). $tname\e[0m"
                        done
                        read -rp "Expected Chapter: " skip_request </dev/tty
                        while ! is_valid_range "$skip_request" 1 "${#topic_list[*]}"

                        do
                            read -rp "Expected Chapter: " skip_request </dev/tty
                        done
                        topic_index=$((--skip_request))
                        skip_request=
                        continue ;;
                esac
                echo
            elif [ $topic_index -gt 1 ] && [ $((topic_index+1)) -eq ${#topic_list[*]} ]
            then
                topic_task="$(generic_select "\e[1;35mTopic \e[1;33m$((topic_index + 1))/${#topic_list[*]}. ${topic_name#*.} \e[1;35m»\e[0m" "Select Topic" "Next Subject" "Previous Topic")"

                case "${topic_task}" in
                    "Select Topic") ;;
                    "Previous Topic") topic_index=$((topic_index - 1)); echo; continue ;;
                    "Next Subject") echo; break ;;
                esac
                echo
            else
                topic_task="$(generic_select "\e[1;35mTopic \e[1;33m$((topic_index + 1))/${#topic_list[*]}. ${topic_name#*.} \e[1;35m»\e[0m" "Select Topic" "Next Topic" "Previous Topic" "Next Subject")"

                case "${topic_task}" in
                    "Select Topic") ;;
                    "Next Topic") topic_index=$((topic_index + 1)); echo; continue ;;
                    "Previous Topic") topic_index=$((topic_index - 1)); echo; continue ;;
                    "Next Subject") echo; break ;;
                esac
                echo
            fi
            topic_index=$((topic_index + 1))

            practice_index=0
            while [ $practice_index -ge 0 ] && [ $practice_index -lt ${#practice_list[*]} ]
            do
                preview_practice "${practice_list[$practice_index]}" "${buffer}"

                if [ $practice_index -eq 0 ] && [ ${#practice_list[*]} -gt 1 ]
                then
                    practice_task="$(generic_select "\e[1;35mPractice \e[1;33m$((practice_index+1))/${#practice_list[*]} \e[1;35m»\e[0m" "Next Practice" "Next Topic")"

                    case "${practice_task}" in
                        "Next Practice") practice_index=$((practice_index + 1)) ;;
                        "Next Topic") echo; break ;;
                    esac
                    echo
                elif [ ${#practice_list[*]} -gt 1 ] && [ $((practice_index + 1)) -eq ${#practice_list[*]} ]
                then
                    practice_task="$(generic_select "\e[1;35mPractice \e[1;33m$((practice_index+1))/${#practice_list[*]} \e[1;35m»\e[0m" "Next Topic" "Previous Practice")"

                    case "${practice_task}" in
                        "Previous Practice") practice_index=$((practice_index - 1)) ;;
                        "Next Topic") echo; break ;;
                    esac
                    echo
                else
                    practice_task="$(generic_select "\e[1;35mPractice \e[1;33m$((practice_index+1))/${#practice_list[*]} \e[1;35m»\e[0m" "Next Practice" "Previous Practice" "Next Topic")"

                    case "${practice_task}" in
                        "Next Practice") practice_index=$((practice_index + 1)) ;;
                        "Previous Practice") practice_index=$((practice_index - 1)) ;;
                        "Next Topic") echo; break ;;
                    esac
                    echo
                fi
            done
            echo
        done
        echo
    done

    # shellcheck disable=SC2009
    if ps -ef | grep -w livedown | grep -qv grep
    then
        livedown stop &>/dev/null
    fi
}

while [[ $# -gt 0 ]]
do
    case "$1" in
        -r|--reset|reset) RESET=1 ;;
        -h|--help|help) HELP=1 ;;
        -w|--web|web) WEB='--open' ;;
        *) DESTINATION="$1" ;;
    esac
    shift
done

if [[ -v HELP ]]
then
    echo "$0 [--reset] [--help] [--error] [--web]"
    exit 1
fi

if [[ -v RESET ]] && [[ -d "${base_path}" ]]
then
    rm -r "${base_path}"
    unpack_subjects "$DESTINATION"
    begin_review
elif ! [[ -e "$DESTINATION" ]] && [[ -d "${base_path}" ]]
then
    begin_review
elif [[ -e "$DESTINATION" ]] && [[ -d "${base_path}" ]]
then
    rm -r "${base_path}"
    unpack_subjects "$DESTINATION"
    begin_review
else
    unpack_subjects "$DESTINATION"
    begin_review
fi
