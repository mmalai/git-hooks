#!/usr/bin/env bash
# Original: https://github.com/jumanjihouse/pre-commit-hooks#shfmt
# Forked to change runtime to /usr/bin/env on win10
set -eu

readonly DEBUG=${DEBUG:-unset}
if [ "${DEBUG}" != unset ]; then
  set -x
fi

if ! command -v shfmt >/dev/null 2>&1; then
  echo 'This check needs shfmt from https://github.com/mvdan/sh/releases'
  exit 1
fi

readonly cmd=(shfmt "$@")
echo "[RUN] ${cmd[@]}"
output="$("${cmd[@]}" 2>&1)"
readonly output

while IFS= read -r -d '' file
do
  (( count++ ))
  output="$(shfmt -l -i 4 -ci "$file")"
done <   <(find . -type f -name "*.sh" -print0)


if [ -n "${output}" ]; then
  echo '[FAIL]'
  echo
  echo "${output}"
  echo
  echo 'The above files have style errors.'
  echo 'Use "shfmt -d" option to show diff.'
  echo 'Use "shfmt -l -i 4 -ci -w" option to write (autocorrect).'
  exit 1
else
  echo '[PASS]'
fi
