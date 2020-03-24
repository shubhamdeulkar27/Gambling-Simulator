#!/bin/bash -x

stake=100
IS_WIN=1
IS_LOST=0

bet=$(( RANDOM%2 ))

if [ $bet -eq $IS_WIN ]
then
	(( stake++ ))
elif [ $bet -eq $IS_LOST ]
then
	(( stake-- ))
fi
