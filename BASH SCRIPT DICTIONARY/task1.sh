#!/bin/bash


database=phonebook

if [ ! -f $database ]
then
	printf "%-30s %-14s\n" "contact name: "  "phone number: " > $database
fi

createnewcontact () {
	echo "plese enter contact name: "
	read contact_name
	if grep -q $"contact_name" $database
	then
		echo "sorry name is exisit"
		exisit=1
	else 
		exisit=0
	fi
	if [ $exisit == 0 ]
	then
		echo "please enter phone number: "
		read phone_number
		printf "%-30s %-14s\n" "$contact_name" "$phone_number" >> $database
	fi



}



displayoptions () {
	echo "-i create new contact"
	echo "-v view all contacts"
	echo "-s search for a contact"
	echo "-e delete all contacts"
	echo "-d delete one contact"
}

viewallcontacts () {
	cat $database
}


viewonecontact() {
	echo "enter contact to find"
	read contact_name
	if grep -q "$contact_name" $database
	then
		grep "$contact_name" $database
	else
		echo "not found ! "
	fi
}



deleteall () {
	printf "%-30s %-14s\n" "$contact_name" "$phone_number" > $database
}

deletecontact () {
	echo "enter contact"
	read contact_name
	if grep -q "$contact_name" $database
	then
		grep -F -v "$contact_name" $database > tmp && mv tmp $database
	else 
		echo "not found !"
	fi

}

if [ -z $1 ] || [ ! -z $2 ]
then
	displayoptions
elif [ $1 == "-i" ]
then
	createnewcontact
elif [ $1 == "-v" ]
then 
	viewallcontacts
elif [ $1 == "-s" ]
then
	viewonecontact
elif [ $1 == "-e" ]
then
	deleteall
elif [ $1 == "-d" ]
then
	deletecontact
fi
