#!/bin/sh
#wikipedia.cgi
# search Wikipedia directly from w3m searchbar

/usr/bin/echo "w3m-control: BACK"
/usr/bin/echo "w3m-control: TAB_GOTO https://en.wikipedia.org/w/index.php?search=$QUERY_STRING&title=Special%3ASearch&profile=default&fulltext=1&ns0=1"
