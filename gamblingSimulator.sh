#!/bin/bash -x

#CONSTANTS
IS_WIN=1
IS_LOST=0
MAXIMUM_DAYS=20

#FUNCTION TO RESET THE VARIABLES
function reset(){
	#VARIBLES
	stake=100
	days=0
	totalStakes=0
	index=0
	luckyDay=50
	unluckyDay=150

	#CALCULATING STAKE PERCENTAGE
	fiftyPercent=`echo "$stake*0.5"|bc`
	lowerStakePercent=${fiftyPercent%.*}
	higherStakePercent=$(( $stake+$lowerStakePercent ))
}

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
function play(){
	while [ $days -ne $MAXIMUM_DAYS ]
	do
	   stakesAfterBet[(( index++ ))]=$( placeBet )
	   (( days++ ))
	done
}

#FINDING MAXDAYS WON AND LOST
function findDays(){
	daysWon=0
	daysLost=0
	for (( i=0 ; i<${#stakesAfterBet[@]} ; i++ ))
	do
		if (( ${stakesAfterBet[i]}>100 ))
		then
			(( daysWon++ ))
		elif (( ${stakesAfterBet[i]}<100 ))
		then
			(( daysLost++ ))
		fi
		totalStakes=$(( $totalStakes+${stakesAfterBet[i]} ))
	done
}

#FINDING THE LUCKY AND UNLUCKY DAY
function luckyUnluckyDay(){
	for (( i=0 ; i<${#stakesAfterBet[@]} ; i++ ))
	do
		if (( $luckyDay<${stakesAfterBet[i]} ))
		then
			luckyDay=$(( $i+1 ))
		fi
		if (( $unluckyDay>${stakesAfterBet[i]} ))
		then
			unluckyDay=$(( $i+1 ))
		fi
	done
}

#PLAYING THE GAME
reset
while [ true ]
do
	play
	findDays
	luckyUnluckyDay
	if (( $daysWon>$daysLost))
	then
		read -p "Enter 1 to Play Again" choice
		if (( $choice==1 ))
		then
			reset
			play
			findDays
			luckyUnluckyDay
		else
			break
		fi
	else
		break
	fi
done
