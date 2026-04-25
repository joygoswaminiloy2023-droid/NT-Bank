#!/bin/bash

# =========================
# NT BANK SYSTEM
# File: bank_gui.sh
# =========================

DATA_FILE="bank_db.txt"
touch $DATA_FILE

validate_6digit() {
    [[ $1 =~ ^[0-9]{6}$ ]]
}

while true; do

choice=$(zenity --list \
--title="NT BANK SYSTEM" \
--width=400 --height=300 \
--column="Menu" \
"Create Account" "Deposit" "Withdraw" "Check Balance" "View All Accounts" "Exit")

case $choice in

# ---------------- CREATE ACCOUNT ----------------
"Create Account")

acc=$(zenity --entry --title="Account Number (6 digits)" --width=300)

if ! validate_6digit "$acc"; then
    zenity --error --text="Account must be exactly 6 digits!"
    continue
fi

if grep -q "^$acc," $DATA_FILE; then
    zenity --error --text="Account already exists!"
    continue
fi

pass=$(zenity --entry --title="Password (6 digits)" --width=300)

if ! validate_6digit "$pass"; then
    zenity --error --text="Password must be exactly 6 digits!"
    continue
fi

name=$(zenity --entry --title="Name" --width=300)

bal=$(zenity --entry --title="Initial Deposit (min 1000)" --width=300)

if ! [[ $bal =~ ^[0-9]+$ ]] || [ "$bal" -lt 1000 ]; then
    zenity --error --text="Minimum deposit must be 1000!"
    continue
fi

echo "$acc,$pass,$name,$bal" >> $DATA_FILE

zenity --info --text="Account Created Successfully!"
;;

# ---------------- DEPOSIT ----------------
"Deposit")

acc=$(zenity --entry --title="Account Number")
pass=$(zenity --entry --title="Password")

if ! grep -q "^$acc,$pass," $DATA_FILE; then
    zenity --error --text="Invalid account or password!"
    continue
fi

amt=$(zenity --entry --title="Deposit Amount")

awk -F, -v acc="$acc" -v pass="$pass" -v amt="$amt" 'BEGIN{OFS=","}
{
    if($1==acc && $2==pass){
        $4=$4+amt
    }
    print
}' $DATA_FILE > temp && mv temp $DATA_FILE

zenity --info --text="Deposit Successful!"
;;

# ---------------- WITHDRAW ----------------
"Withdraw")

acc=$(zenity --entry --title="Account Number")
pass=$(zenity --entry --title="Password")

balance=$(grep "^$acc,$pass," $DATA_FILE | cut -d, -f4)

if [ -z "$balance" ]; then
    zenity --error --text="Invalid account or password!"
    continue
fi

amt=$(zenity --entry --title="Withdraw Amount")

if [ "$amt" -gt "$balance" ]; then
    zenity --error --text="Insufficient Balance!"
    continue
fi

awk -F, -v acc="$acc" -v pass="$pass" -v amt="$amt" 'BEGIN{OFS=","}
{
    if($1==acc && $2==pass){
        $4=$4-amt
    }
    print
}' $DATA_FILE > temp && mv temp $DATA_FILE

zenity --info --text="Withdrawal Successful!"
;;

# ---------------- CHECK BALANCE ----------------
"Check Balance")

acc=$(zenity --entry --title="Account Number")
pass=$(zenity --entry --title="Password")

bal=$(grep "^$acc,$pass," $DATA_FILE | cut -d, -f4)

if [ -z "$bal" ]; then
    zenity --error --text="Account not found!"
else
    zenity --info --text="Balance: $bal"
fi
;;

# ---------------- VIEW ALL ACCOUNTS ----------------
"View All Accounts")

zenity --text-info \
--title="NT BANK ACCOUNTS" \
--width=400 --height=300 \
--filename=$DATA_FILE
;;

# ---------------- EXIT ----------------
"Exit")
exit
;;

esac

done
