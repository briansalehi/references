#!/usr/bin/env bash

is_broken=0
line_number=0
faults=0
sum_faults=0
is_detail_scope=0
is_empty_scope=0
is_body_scope=0
is_origin_scope=0
is_separator_scope=0
is_reference_scope=0
is_extra_scope=0

function usage() {
    echo "Usage: $(basename "$(readlink -f "$0")") [-h,--help] [-q,--quiet] [-w,-Werror,--error] [-f,--file <filename>] [-d,--dir,--directory <dirname>] [-g,--debug <begin> <end>] [-u,--unpublished] [-i,--writing,--incomplete]" >&2
    exit 1
}

function error() {
    echo -e "\e[1;31m""${*}:""\e[0m""\n\t""\e[1;33m""${file}:""\e[1;34m""${line_number}: ""\e[0m""${line}" >&3
    is_broken=1
    ((++faults))
}

function check_unclosing_details() {
    if [ "$is_detail_scope" -eq 1 ]
    then
        error "reached new details block with previous unclosed"
    fi

    is_detail_scope=1
}

function check_surrounding_details() {
    if [ "$is_detail_scope" -ne 1 ]
    then
        error "summary left without surrounding details tag"
    fi

    is_empty_scope=1
}

function check_contiguous_summary() {
    if [ -n "$line" ]
    then
        error "contigious lines after summary tag"
    fi

    is_empty_scope=0
}

# shellcheck disable=SC2317
function check_out_of_scope_line() {
    if [ -n "$line" ] && [ "$line" != "Nothing to import." ]
    then
        error "out of scope line"
    fi
}

function check_separator_reached() {
    if [ "$is_body_scope" -eq 1 ] || [ "$is_origin_scope" -eq 1 ] || [ "$is_reference_scope" -eq 1 ] || [ "$is_extra_scope" -eq 1 ]
    then
        is_separator_scope=1
    fi
}

function check_missing_scopes() {
    if [ "$is_body_scope" -eq 1 ] || [ "$is_origin_scope" -eq 1 ] || [ "$is_reference_scope" -eq 1 ]
    then
        if [ "$is_body_scope" -eq 1 ]
        then
            error "missing origin scope"
            is_body_scope=0
        elif [ "$is_origin_scope" -eq 1 ]
        then
            error "missing reference scope"
            is_origin_scope=0
        elif [ "$is_reference_scope" -eq 1 ]
        then
            # works as expected
            error "missing horizontal line"
            is_reference_scope=0
        fi
    fi

    is_detail_scope=0
}

function check_horizontal_reach() {
    if [ "$is_body_scope" -eq 1 ] || [ "$is_origin_scope" -eq 1 ] || [ "$is_reference_scope" -eq 1 ]
    then
        if [ "$is_body_scope" -eq 1 ]
        then
            error "missing origin scope"
            is_body_scope=0
        elif [ "$is_origin_scope" -eq 1 ]
        then
            error "missing reference scope"
            is_origin_scope=0
        elif [ "$is_reference_scope" -eq 1 ]
        then
            is_reference_scope=0
        fi
    else
        error "missing all 3 bodies"
    fi
}

function check_scope_validity() {
    if [ "$is_detail_scope" -ne 1 ]
    then
        error "scope indicator out of scope"
        return 1
    fi

    if [ "$is_body_scope" -eq 0 ] && [ "$is_origin_scope" -eq 0 ] && [ "$is_reference_scope" -eq 0 ] && [ "$is_extra_scope" -eq 0 ]
    then
        if [ "$is_separator_scope" -eq 1 ]
        then
            error "separator hit early"
            is_separator_scope=0
        fi

        is_body_scope=1
    elif [ "$is_body_scope" -eq 1 ] && [ "$is_origin_scope" -eq 0 ] && [ "$is_reference_scope" -eq 0 ] && [ "$is_extra_scope" -eq 0 ]
    then
        if [ "$is_separator_scope" -eq 1 ]
        then
            is_body_scope=0
            is_origin_scope=1
            is_separator_scope=0
        fi
    elif [ "$is_body_scope" -eq 0 ] && [ "$is_origin_scope" -eq 1 ] && [ "$is_reference_scope" -eq 0 ] && [ "$is_extra_scope" -eq 0 ]
    then
        if [ "$is_separator_scope" -eq 1 ]
        then
            is_origin_scope=0
            is_reference_scope=1
            is_separator_scope=0
        fi
    elif [ "$is_body_scope" -eq 0 ] && [ "$is_origin_scope" -eq 0 ] && [ "$is_reference_scope" -eq 1 ] && [ "$is_extra_scope" -eq 0 ]
    then
        if [ "$is_separator_scope" -eq 1 ]
        then
            error "body found splitted"
            is_reference_scope=0
            is_extra_scope=1
            is_separator_scope=0
        fi
    elif [ "$is_body_scope" -eq 0 ] && [ "$is_origin_scope" -eq 0 ] && [ "$is_reference_scope" -eq 0 ] && [ "$is_extra_scope" -eq 1 ]
    then
        if [ "$is_separator_scope" -eq 1 ]
        then
            error "too many body splits"
            is_extra_scope=1
            is_separator_scope=0
        fi
    else
        error "reached invalid scope"
    fi
}

while [ $# -gt 0 ]
do
    case "$1" in
        -q|--quiet) QUIET_MODE=1 ;;
        -h|--help) HELP_MODE=1 ;;
        -f|--file) FILE_MODE=1; FILE_PATH="$2"; shift ;;
        -u|--unpublished) UNPUBLISHED=1 ;;
        -c|--completed) COMPLETED=1 ;;
        -i|--writing|--incomplete) WRITING=1 ;;
        -w|-Werror|--error|--werror) WERROR=1 ;;
        -d|--dir|--directory) DIR_MODE=1; DIR_PATH="$2"; shift ;;
        -g|--debug) DEBUG_BEGIN_LINE="$2"; DEBUG_END_LINE="$3"; shift; shift ;;
        *)
            if [ -f "$1" ]
            then
                FILE_MODE=1
                FILE_PATH="$1"
            elif [ -d "$1" ]
            then
                DIR_MODE=1
                DIR_PATH="$1"
            else
                echo "Invalid path: $1" >&2
                exit 1
            fi
            ;;
    esac
    shift
done

if [ "${QUIET_MODE:-0}" -eq 1 ]
then
    exec 3> "/tmp/$(date +%s).validate.log"
else
    exec 3>&2
fi

if [ "${HELP_MODE:-0}" -eq 1 ]
then
    usage
fi

if [ "${UNPUBLISHED:-0}" -eq 1 ] || [ "${COMPLETED:-0}" -eq 1 ] || [ "${WRITING:-0}" -eq 1 ]
then
    while read -r filename
    do
        if [ "${UNPUBLISHED:-0}" -eq 1 ]
        then
            filter="complete|completed|writing"
        elif [ "${COMPLETED:-0}" -eq 1 ]
        then
            filter="complete|completed"
        elif [ "${WRITING:-0}" -eq 1 ]
        then
            filter="writing"
        fi

        while read -r record
        do
            [ -z "$record" ] && continue
            line="$(cut -d':' -f1 <<< "$record")"
            chapter="$(cut -d'#' -f3- <<< "$record" | cut -d'<' -f1)"
            status="$(cut -d'>' -f2 <<< "$record" | cut -d '<' -f1)"

            echo -e "\e[1;34m$filename +$line:\e[1;33m $chapter \e[1;31m$status\e[0m" >&2
        done <<< "$(grep -En "<sup>\(($filter)\)</sup>" "$filename")"
    done <<< "$(find bookmarks/resources/ -type f -name '*.md')"

    exit 0
fi

if [ "${FILE_MODE:-0}" -eq 1 ]
then
    file_list="$FILE_PATH"
elif [ "${DIR_MODE:-0}" -eq 1 ]
then
    file_list="$(find "${DIR_PATH:-.}" -name \*.md -type f -not -name README.md)"
else
    usage
fi

if [ -d .git ] && [ -d bookmarks/ ] && [ -d topics/ ]
then
    echo -e "\e[1;32m""processing""\e[0m" >&2
else
    echo -e "\e[1;31m""root directory requirements not met""\e[0m" >&2
    exit 3
fi

while read -r file
do
    is_broken=0
    line_number=0
    faults=0

    [ "${QUIET_MODE:-0}" -eq 0 ] && echo -e "\e[1;33m""$file""\e[0m" >&2

    while read -r line
    do
        ((line_number++))

        [ -v WERROR ] && [ "$faults" -gt 0 ] && exit 1

        [ -n "$DEBUG_BEGIN_LINE" ] && [ "$DEBUG_BEGIN_LINE" -eq "$line_number" ] && set -x

        if [ "$line" = "<details>" ]
        then
            check_unclosing_details
        elif [ "$is_empty_scope" -eq 1 ]
        then
            check_contiguous_summary
        elif [ "${line:0:9}" = "<summary>" ]
        then
            check_surrounding_details
        elif [ "${line:0:1}" = ">" ]
        then
            check_scope_validity
        elif [ "$line" = "---" ]
        then
            check_horizontal_reach
        elif [ "$line" = "</details>" ]
        then
            check_missing_scopes
        elif [ -z "$line" ]
        then
            check_separator_reached
        # else
        #     check_out_of_scope_line
        fi

        [ -n "$DEBUG_END_LINE" ] && [ "$DEBUG_END_LINE" -eq "$line_number" ] && set +x
    done < "$file"

    if [ "${QUIET_MODE:-0}" -eq 1 ] && [ -z "${DEBUG_END_LINE}" ] && [ -z "${DEBUG_BEGIN_LINE}" ]
    then
        if [ "${is_broken:-0}" -eq 1 ]
        then
            printf '[\e[1;31m%*s%-6s%*s\e[0m] \e[1;33m%s\e[0m \e[1;35m(%d faults)\e[0m\n' 1 " " "BROKEN" 1 " " "$file" "$faults" >&2
        else
            printf '[\e[1;32m%*s%-4s%*s\e[0m] \e[1;33m%s\e[0m\n' 3 " " "OK" 1 " " "$file" >&2
        fi
    fi

    sum_faults=$((sum_faults + faults))
done <<< "$file_list"

if [ "$faults" -gt 0 ]
then
    exit 2
else
    exit 0
fi
