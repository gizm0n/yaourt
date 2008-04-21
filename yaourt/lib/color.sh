#!/bin/bash
#===============================================================================
#
#          FILE: color.sh
# 
#   DESCRIPTION: yaourt's library to manage colors
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:   Julien MISCHKOWITZ (wain@archlinux.fr) 
#       VERSION:  1.0
#===============================================================================

initcolor(){
# no special caracter for textonly mode
if [ "$COLORMODE" = "--textonly" ]; then
	TERMINALTITLE=0
	return 0
fi

# font type
COL_BOLD="\033[1m"
COL_INVERT="\033[7m"
COL_BLINK="\033[5m"
COL_ITALIQUE="\033[0m"
NO_COLOR="\033[0m"

# Color list
case $COLORMODE in
	"--nocolor")
	COL_WHITE="\033[0m"
	COL_YELLOW="\033[0m"
	COL_RED="\033[0m"
	COL_CYAN="\033[0m"
	COL_GREEN="\033[0m"
	COL_PINK="\033[0m"
	COL_BLUE="\033[0m"
	COL_BLACK="\033[0m"
	COL_MAGENTA="\033[0m"
	;;
	"--lightbg")
	COL_WHITE="\033[1;37m"
	COL_RED="\033[1;31m"
	COL_CYAN="\033[1;36m"
	COL_GREEN="\033[1;32m"
	COL_PINK="\033[1;35m"
	COL_BLUE="\033[1;34m"
	COL_BLACK="\033[1;30m"
	COL_MAGENTA="\033[1;35m"
	COL_YELLOW="$COL_CYAN"
	;;
	*)
	COL_WHITE="\033[1;37m"
	COL_YELLOW="\033[1;33m"
	COL_RED="\033[1;31m"
	COL_CYAN="\033[1;36m"
	COL_GREEN="\033[1;32m"
	COL_PINK="\033[1;35m"
	COL_BLUE="\033[1;34m"
	COL_BLACK="\033[1;30m"
	COL_MAGENTA="\033[1;35m"
	;;
esac

# Color functions
COL_INSTALLED="$COL_INVERT$COL_YELLOW" # show [installed] packages
COL_ARROW="$COL_YELLOW" # show ==>
COL_NUMBER="$COL_INVERT$COL_YELLOW" # show number) in listing
COL_CORE="$COL_ITALIQUE\\$COL_RED"
COL_EXTRA="$COL_ITALIQUE\\$COL_GREEN"
COL_LOCAL="$COL_ITALIQUE\\$COL_YELLOW"
COL_COMMUNITY="$COL_ITALIQUE\\$COL_PINK"
COL_UNSTABLE="$COL_ITALIQUE\\$COL_RED"
COL_REPOS="$COL_PINK"
}
list(){
	echo -e "${COL_ARROW}$1${NO_COLOR}" >&2
}
plain(){
	echo -e "${COL_BOLD}$1${NO_COLOR}" >&2
}
msg(){
	echo -e "${COL_GREEN}==> ${NO_COLOR}${COL_BOLD}$1${NO_COLOR}" >&2
}
warning(){
	echo -e "${COL_YELLOW}==> WARNING: ${NO_COLOR}${COL_BOLD}$1${NO_COLOR}" >&2
}
prompt(){
        echo -e "${COL_ARROW}==>  ${NO_COLOR}${COL_BOLD}$1${NO_COLOR}" >&2
	echo -e "${COL_ARROW}==>  ${NO_COLOR}${COL_BOLD} ----------------------------------------------${NO_COLOR}" >&2
	echo -ne "${COL_ARROW}==>${NO_COLOR}" >&2
}
promptlight(){
	echo -ne "${COL_ARROW}==>${NO_COLOR}" >&2
}
error(){
	echo -e "${COL_RED}""Error""${NO_COLOR}"": $1\n"
	return 1
}
colorizeoutputline(){		
	if [ "$COLORMODE" = "--textonly" ]; then
		local line=`echo $* | sed -e 's#^core/#&#g' \
		-e 's#^extra/#&#g' \
        	-e 's#^community/#&#g' \
        	-e 's#^unstable/#&#g' \
        	-e 's#^local/#&#g' \
        	-e 's#^[a-z0-9-]*/#&#g'`
	else
	local line=`echo $* | sed -e 's#^core/#\\'${COL_CORE}'&\\'${NO_COLOR}'#g' \
	-e 's#^extra/#\\'${COL_EXTRA}'&\\'${NO_COLOR}'#g' \
        -e 's#^community/#\\'${COL_COMMUNITY}'&\\'${NO_COLOR}'#g' \
        -e 's#^unstable/#\\'${COL_UNSTABLE}'&\\'${NO_COLOR}'#g' \
        -e 's#^local/#\\'${COL_LOCAL}'&\\'${NO_COLOR}'#g' \
        -e 's#^[a-z0-9-]*/#\\'${COL_REPOS}'&\\'${NO_COLOR}'#g'`
	fi
	echo $line
}
cleanoutput(){
if [ $TERMINALTITLE -eq 0 -o -z "$DISPLAY"  ]; then
	return 0
fi
tput sgr0
}

