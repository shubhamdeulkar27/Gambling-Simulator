#!/bin/bash -x

#VARIABLES
stake=100

#CONSTANTS
IS_WIN=1
IS_LOST=0

function placeBet(){
	bet=$(( RANDOM%2 ))
	if [ $bet -eq $IS_WIN ]
	then
		(( stake++ ))
	elif [ $bet -eq $IS_LOST ]
	then
		(( stake-- ))
	fi
}
