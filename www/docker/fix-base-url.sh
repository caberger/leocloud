#!/usr/bin/env bash

# this script changes the <base href="..."> header tag to the environment variable BASE_HREF.
# then the same docker image can be deployed to multiple sub-paths of the same hostname

HTML=/usr/share/nginx/html
if [[ "$BASE_HREF." == "." ]]
then
    echo "no BASE_HREF environment variable set, keep base href... as is is"
else
    echo "BASE_HREF=$BASE_HREF patch the head to base href=\"$BASE_HREF\""
    find $HTML -type f -name "*.html" -print -exec sed -i -e "s,<base href=\"/\",<base href=\"/$BASE_HREF/\"," {} \;
fi

