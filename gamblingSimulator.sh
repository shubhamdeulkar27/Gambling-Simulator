#!/bin/bash -x

stake=100
IS_WIN=1
IS_LOST=0

fiftyPercent=`echo "$stake*0.5"|bc`
lowerStakePercent=${fiftyPercent%.*}
higherStakePercent=$(( $stake+$lowerStakePercent ))

while [ true ]
do
bet=$(( RANDOM%2 ))
if [ $bet -eq $IS_WIN ]
then
	(( stake++ ))
	if [ $stake -eq $higherStakePercent ]
	then
		break
	fi
elif [ $bet -eq $IS_LOST ]
then
	(( stake-- ))
	if [ $stake -eq $lowerStakePercent ]
	then
		break
	fi
fi
done
