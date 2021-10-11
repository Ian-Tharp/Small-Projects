#Ian Tharp - ict0011 - IanTharp2@my.unt.edu
#Dr. Tunc 3600.002
#10/1/21
#Minor Assignment #2
#This bash script assignment will check who is logged
#in the current CSCE machine every 10 seconds and report each of the user's ID
#that either logs in or out during the time interval.
#In addition there is a custom signal handler to trap the SIGINT one time
#before being able to terminate the program.

#!bin/bash
curDate=`date`
echo $curDate" ) initial users logged in"
#Getting the server name we are connected to
server=`hostname`

#Prints all the users logged into the server
who > ppl.txt
awk '{print $1;}' ppl.txt > ppl2.txt
awk -v host="$server" '{print "> "$1, "logged in to",host}' ppl2.txt
#Get the total number of people logged into the server
amount=`who | wc -l`

#Trap handler for ^C
trap 'echo SIGINT will not work' 1
trap 'suppressonce' 2
suppressonce()
{
	echo " (SIGINT) ignored. enter ^C 1 more time to terminate program."
	trap 2
}

#Main loop to print out total users every ten seconds
while true
do
updatedDate=`date`
ppl=`who | wc -l`
echo "$updatedDate ) # of users: $ppl"
sleep 10s
who > ppl.txt
newPpl=`who | wc -l`
#Print out if a person joined the server
if [ $ppl -lt $newPpl ]
then
awk '{print $1;}' ppl.txt > ppl2.txt
sed -n '$p' ppl2.txt > newuser.txt
awk -v host="$server" '{print "> "$1, "logged in to",host}' newuser.txt
fi
#Print out if a person leaves the server
if [ $ppl -gt $newPpl ]
then
awk '{print $1;}' ppl.txt > ppl2.txt
sed -n '$p' ppl2.txt > newuser.txt
awk -v host="$server" '{print "> "$1, "logged out of",host}' newuser.txt
fi
done
