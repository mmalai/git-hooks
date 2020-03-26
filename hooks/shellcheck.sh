#!/usr/bin/env bash
# Original: https://github.com/jumanjihouse/pre-commit-hooks#shellcheck
# Forked to change runtime to /usr/bin/env on win10

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
  set -x
fi

bin="$(command -v shellcheck)"

while IFS= read -r -d '' file
do
  (( count++ ))
  "${bin}" "$@" "$file"
done <   <(find . -type f -name "*.sh" -print0)
