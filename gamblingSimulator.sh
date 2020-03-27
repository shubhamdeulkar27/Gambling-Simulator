#!/bin/bash -x

stake=100
IS_WIN=1
IS_LOST=0

fiftyPercent=`echo "$stake*0.5"|bc`
lowerStakePercent=${fiftyPercent%.*}
higherStakePercent=$(( $stake+$lowerStakePercent ))

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

function play(){
	while [ true ]
	do
		placeBet
		if [ $stake -eq $lowerStakePercent ] || [ $stake -eq $higherStakePercent ]
		then
			break
		fi
	done
}

play
