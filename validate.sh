#!/usr/bin/env bash

line_number=0
is_detail_scope=0
is_empty_scope=0
is_body_scope=0
is_origin_scope=0
is_separator_scope=0
is_reference_scope=0
is_extra_scope=0

function error() {
    echo -e "\e[1;31m""${*}:""\e[0m""\n\t""\e[1;33m""${file}:""\e[1;34m""${line_number}: ""\e[0m""${line}"
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

function check_out_of_scope_line() {
    if [ -n "$line" ] && ! [ "$line" = "Nothing to import." ]
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
            error "missing horizontal line"
            is_reference_scope=0
        fi
    else
        error "missing all 3 bodies"
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
            error "body found splitted, extra scope reached"
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

if [ -d .git ] && [ -d books/ ]
then
    while read -r file
    do
        echo -e "\e[1;33m""$file""\e[0m"

        while read -r line
        do
            ((line_number++))

            if [ "$line" = "<details>" ]
            then
                check_unclosing_details
            elif [ "$is_empty_scope" -eq 1 ]
            then
                check_contiguous_summary
            elif [ "${line:0:8}" = "<summary>" ]
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
        done < "$file"

        line_number=0
    done <<< "$(find "${1:-books/}" -name \*.md -type f -not -name README.md)"
fi
