#!/usr/bin/env bash

# create the deployment.yaml file from the parts
ACTOR=$1
EMAIL=$(echo $2 | sed -e "s/@.*$//")

if [[ -z $1 ]] || [[ -z $2. ]]
then
    echo "usage: $0 github.actor email"
    echo "where:"
    echo "   git.actor is your github user name"
    echo "   email is the your email address used to register in the LeoCloud (only the part before the @)"
    exit 1
fi

PARTS=$(find ./parts -type f -name "*.yaml" -print | sort)
OUTPUT=distribution.yaml
echo "prepare $OUTPUT for github user $ACTOR with base url $EMAIL"

rm -f $OUTPUT
CNT=0
for file in $PARTS
do
    if [[ $CNT != "0" ]]
    then
        echo "---" >> $OUTPUT
    fi
    sed -e "s/\$GITHUB_ACCOUNT/$ACTOR/g" $file | sed -e "s/\$EMAIL/$EMAIL/g" >> $OUTPUT
    let CNT+=1
done

exit 0
