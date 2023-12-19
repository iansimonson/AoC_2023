#!/bin/bash

DAY=$1
if [ -z $DAY ];then
    echo "You need to specify a day" >&2
    exit 1
fi

DAY_NAME="day${DAY}"
mkdir ${DAY_NAME}
cp day_template.odin ${DAY_NAME}/${DAY_NAME}.odin
touch ${DAY_NAME}/input.txt

sed -i '' -e '1d' "${DAY_NAME}/${DAY_NAME}.odin"
sed -i '' -e "s/package dayX/package day${DAY}/" "${DAY_NAME}/${DAY_NAME}.odin"