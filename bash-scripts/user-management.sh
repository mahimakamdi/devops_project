#!/bin/bash

read -p "Enter username: " username

if id "$username" &>/dev/null; then
    echo "User exists. Deleting user..."
    sudo userdel -r $username
    echo "User deleted."
else
    echo "User does not exist. Creating user..."
    sudo useradd -m $username
    echo "User created."
fi