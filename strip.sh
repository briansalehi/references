#!/usr/bin/env bash

declare -a doc_files
tmp_file="$(mktemp)"

if [ $# -eq 0 ]
then
    mapfile -d $'\0' doc_files < <(find books/ -type f -name '*.md' -print0)
else
    read -r doc_files <<< "$@"
fi

sed -e '1,+2d' -e '/> Origin: .*/,/^---$/d' -e '/<\/details>/s/.*/---\n&/' "${doc_files[@]}" > "${tmp_file}"
echo "${tmp_file}"
