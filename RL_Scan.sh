#!/bin/bash

# clear
echo ""

if [ "$1" == "" ]; then
	echo "Use mode:"
	echo "Non-Authenticated test: $0 <Target>"
	echo "Authenticated test: $0 <Target> <Access_Token> <Client_ID>"
elif [ "$2" == "" ] && [ "$3" == "" ]; then
setterm -foreground red && echo "[+]------------------------- Rate Limit Validation -------------------------[+]"
echo ""
echo "Developed by > Cyber Strike Force Team"
echo ""
Request_Success="0"
Request_Failure="0"
Time=$(date | cut -d " " -f5)
for Loop in {1..1000}; do
Request=$(curl -sIkX GET $1 | grep "HTTP" | cut -d " " -f2);
        if [ "$Request" == "200" ]; then
                Request_Success=$(echo "$Request_Success"+1|bc)
                echo "		Request Number [$Loop] - [SUCESS]" >> /dev/null
		echo "[+]-------------------------------------------------[+]" >> /dev/null
        elif [ "$Request" == "429" ]; then
                Time_Out=$(date | cut -d " " -f5)
                Request_Failure=$(echo "$Request_Failure"+1|bc)
		echo "[+] Validating the turnaround time"
                for Loop2 in {1..5000}; do
                Request2=$(curl -sIkX GET $1 | grep "HTTP" | cut -d " " -f2);
                        if [ "$Request2" == "200" ]; then
                                Time_Return=$(date | cut -d " " -f5)
				setterm -foreground blue && echo "	[+] Test Mode: Non-Authenticated"
                                setterm -foreground red && echo "	[+] The limit of requests to the API before the Rate Limit control starts acting is $Request_Success Requests."
                                setterm -foreground blue && echo "	[*] Start Time: $Time"
                                setterm -foreground red && echo "	[*] Stop time: $Time_Out"
                                setterm -foreground green && echo "	[*] Return Time: $Time_Return"
                                Hours_Return=$(echo "$Time_Return" | cut -d ":" -f1) 
                                Minutes_Return=$(echo "$Time_Return" | cut -d ":" -f2)
                                Seconds_Return=$(echo "$Time_Return" | cut -d ":" -f3)
                                Hours_Out=$(echo "$Time" | cut -d ":" -f1) 
                                Minutes_Out=$(echo "$Time" | cut -d ":" -f2)
                                Seconds_Out=$(echo "$Time" | cut -d ":" -f3)
                                Hours_Result=$(echo "$Hours_Return-$Hours_Out"|bc)
                                Minutes_Result=$(echo "$Minutes_Return-$Minutes_Out"|bc)
                                Seconds_Result=$(echo "$Seconds_Return-$Seconds_Out"|bc)
                                Date_Result=$(echo "Rate Limit Control denies requests for $Hours_Result hour(s), $Minutes_Result minute(s) e $Seconds_Result seconds(s).." | tr --delete "-")
                                setterm -foreground red && echo "       [+] $Date_Result"
				echo ""
				echo "[+]-------------------------------------------------------------------------[+]"
				setterm -foreground default
                                exit
                        else
                                echo "          Request Failure - [FAILURE]" >> /dev/null
		                echo "[+]-------------------------------------------------[+]" >> /dev/null

                        fi
                done
        else
                echo "An error has occurred"
        fi
done

else
setterm -foreground red && echo "[+]------------------------- Rate Limit Validation -------------------------[+]"
echo ""
echo "Developed by > Cyber Strike Force LABS "
echo ""

Request_Success="0"
Request_Failure="0"
Time=$(date | cut -d " " -f5)
for Loop in {1..1000}; do
Request=$(curl -sIkX GET $1 -H $'access_token: '$2'' -H $'client_id: '$3'' | grep "HTTP" | cut -d " " -f2);
	if [ "$Request" == "200" ]; then
		Request_Success=$(echo "$Request_Success"+1|bc)
                echo "          Request Number [$Loop] - [SUCESS]" >> /dev/null
                echo "[+]-------------------------------------------------[+]" >> /dev/null
	elif [ "$Request" == "429" ]; then
		Time_Out=$(date | cut -d " " -f5)
		Request_Failure=$(echo "$Request_Failure"+1|bc)
		echo "	[+] Validating the turnaround time"
		for Loop2 in {1..5000}; do
		Request2=$(curl -sIkX GET $1 -H $'access_token: '$2'' -H $'client_id: '$3'' | grep "HTTP" | cut -d " " -f2);
			if [ "$Request2" == "200" ]; then
				Time_Return=$(date | cut -d " " -f5)
                                setterm -foreground blue && echo "	[+] Test Mode: Authenticated"
                                setterm -foreground red && echo "	[+] The limit of requests to the API before the Rate Limit control starts acting is $Request_Success Requests."
                                setterm -foreground blue && echo "	[*] Start Time: $Time"
                                setterm -foreground red && echo "	[*] Stop Time: $Time_Out"
                                setterm -foreground green && echo "	[*] Return Time: $Time_Return"
				Hours_Return=$(echo "$Time_Return" | cut -d ":" -f1)
				Minutes_Return=$(echo "$Time_Return" | cut -d ":" -f2)
				Seconds_Return=$(echo "$Time_Return" | cut -d ":" -f3)
				Hours_Out=$(echo "$Time" | cut -d ":" -f1)
				Minutes_Out=$(echo "$Time" | cut -d ":" -f2)
				Seconds_Out=$(echo "$Time" | cut -d ":" -f3)
				Hours_Result=$(echo "$Hours_Return-$Hours_Out"|bc)
				Minutes_Result=$(echo "$Minutes_Return-$Minutes_Out"|bc)
				Seconds_Result=$(echo "$Seconds_Return-$Seconds_Out"|bc)
				Date_Result=$(echo "Rate Limit Control denies requests for $Hours_Result hour(s), $Minutes_Result minute(s) e $Seconds_Result seconds(s)." | tr --delete "-")
				setterm -foreground red && echo "	[+] $Date_Result"
                                echo ""
                                echo "[+]-------------------------------------------------------------------------[+]"
				setterm -foreground default
				exit
			else
                                echo "          Request Failure - [FAILURE]" >> /dev/null
                                echo "[+]-------------------------------------------------[+]" >> /dev/null
			fi
		done
	else
		echo "An error has occurred"
	fi
done
fi
