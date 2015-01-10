#!/bin/sh

# settings location
#DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd  )
DIR=`pwd`

# files to ignore processing
IGNORE=". .. .gitignore"
ignore() {
  b=`basename $1`
  for f in $IGNORE
  do
    if [ "$f" == "$b" ]; then
      return 1
    fi
  done
  return 0
}

# process all . files
for x in $DIR/.*
do
  ignore $x
  if [ $? -eq 1 ]; then
    continue
  fi
  # echo Processing $x
  ln -sfF "${x}" ~/
done

# process any other files
# echo Processing $DIR/.ssh/config
ln -sf "${DIR}/config" ~/.ssh/config

