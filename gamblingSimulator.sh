#!/bin/bash -x

#VARIBLES
stake=100
days=0
totalStakes=0

#CONSTANTS
IS_WIN=1
IS_LOST=0
MAXIMUM_DAYS=20

#CALCULATING STAKE PERCENTAGE
fiftyPercent=`echo "$stake*0.5"|bc`
lowerStakePercent=${fiftyPercent%.*}
higherStakePercent=$(( $stake+$lowerStakePercent ))

#FUNCTION FOR PLACING BET
function placeBet(){
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
echo $stake
}

#GAMBLER PLAYING FOR MAXIMUM_DAYS
while [ $days -ne $MAXIMUM_DAYS ]
do
	stakeAfterBet=$( placeBet )
	totalStakes=$(( $totalStakes+$stakeAfterBet ))
	(( days++ ))
done

