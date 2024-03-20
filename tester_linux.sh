#!/bin/bash

if [[ $# -ne 4 ]]; then
	echo "USAGE (need 4 ARGS): 
	./test.sh [arg1: test count] [arg2: number of args]
	[arg1: min of range] [arg2: max of range]"
	exit 1
fi


N=$1				# number of tests
num_args=$2			# number of ARGS
min=$3				# min of range
max=$4				# max of range


sequince=0
I=0				# counter
moves=0				# moves number
rule=0				# rules
flag=0
count_error=0

CLEAR="\e[0m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"

# Background color with bold font.
RED_BG_BOLD="\e[1;41m"
GREEN_BG_BOLD="\e[1;42m"
YELLOW_BG_BOLD="\e[1;43m"
BLUE_BG_BOLD="\e[1;44m"
MAGENTA_BG_BOLD="\e[1;45m"
CYAN_BG_BOLD="\e[1;46m"



if [ $num_args -le 3 ];then
	((rule=3))
elif [ $num_args -le 5 ]
then
	((rule=13))
elif [ $num_args -le 100 ]
then
	((rule=700))
elif [ $num_args -le 500 ]
then
	((rule=5500))
fi

if [ -x "./push_swap" ]; then
   while [[ $I -ne $N ]]; do
	echo -e "${BLUE_BG_BOLD}--------------   Test $(($I+1))   --------------${CLEAR}\n"
	sequince=$(seq $min $max | shuf -n $num_args)
	./push_swap $sequince > .out
	#cat .out | ./checker_linux $sequince 
	moves=$(cat .out | wc -l)
	rm -rf .out
	echo -en "MOVES: \e[33m "$moves" \e[0m"
	if [ $moves -gt $rule ];then
		flag=-1
		echo -e "\e[31m [KO]\e[0m\n"
		((count_error+=1))
	else
		echo -e " \e[32m[OK]\e[0m\n"
		if [ $flag -ne -1 ];then	
			flag=1
		fi
	fi
	sleep 0.09
	((I+=1))
done 
else
    echo -e "${RED_BG_BOLD}Programme not turned in files , (should be named push_swap) ${CLEAR}"
fi

if [ $flag -eq 1 ];then
	echo -e "${GREEN_BG_BOLD} CONGRATULATION 👏🎉🥳 ALL TESTS PASSED SUCCESSFULLY \e[0m \e[33m $N/ $N TESTS ${CLEAR}\n"
elif [ $flag -eq -1 ]
then
	echo -e "${RED_BG_BOLD}OOOOOOPS! 💔🥴🥹  YOU HAVE  $count_error / $N  ERROR ${CLEAR}"
fi

