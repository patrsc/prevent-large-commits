#!/bin/bash
# source: https://stackoverflow.com/questions/39576257/how-to-limit-file-size-on-commit
hard_limit=$(git config hooks.filesizehardlimit)
soft_limit=$(git config hooks.filesizesoftlimit)
: ${hard_limit:=100000000}
: ${soft_limit:=20000000}

status=0

bytesToHuman() {
  b=${1:-0}; d=''; s=0; S=({,K,M,G,T,P,E,Z,Y}B)
  while ((b > 1000)); do
    d="$(printf ".%01d" $((b % 1000 * 10 / 1000)))"
    b=$((b / 1000))
    let s++
  done
  echo "$b$d${S[$s]}"
}

# Iterate over the zero-delimited list of staged files.
while IFS= read -r -d '' file ; do
  hash=$(git ls-files -s "$file" | cut -d ' ' -f 2)
  size=$(git cat-file -s "$hash")

  if (( $size > $hard_limit )); then
    echo "Error: Cannot commit '$file' because it is $(bytesToHuman $size), which exceeds the hard size limit of $(bytesToHuman $hard_limit)."
    status=1
  elif (( $size > $soft_limit )); then
    echo "Warning: '$file' is $(bytesToHuman $size), which exceeds the soft size limit of $(bytesToHuman $soft_limit). Please double check that you intended to commit this file."
  fi
done < <(git diff -z --staged --name-only --diff-filter=d)
exit $status
