#!/bin/sh
#google.cgi
# search Google directly from w3m searchbar

/usr/bin/echo "w3m-control: BACK"
/usr/bin/echo "w3m-control: TAB_GOTO https://www.google.com/search?hl=en&q=$QUERY_STRING"
