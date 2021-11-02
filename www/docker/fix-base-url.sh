#!/usr/bin/env bash

# this script changes the <base href="..."> header tag to the environment variable BASE_HREF.
# then the same docker image can be deployed to multiple sub-paths of the same hostname

HTML=/usr/share/nginx/html
echo "fix the baseUrl of all .html files to $BASE_URL"
find $HTML -type f -name "*.html" -print -exec sed -e -i "s/<base href=\(.*\)>\s*$/<base href=\"\\/$BASE_URL\\/\">/g" {} \;

