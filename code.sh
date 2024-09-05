#!/bin/bash

show_menu() {
    PS3="Please select an option: "
    options=("Add User" "Modify User" "Delete User" "detail user"  "List Users" "Add Group" 
             "Modify Group" "Delete Group" "List Groups" "Disable User"
             "Enable User" "list password" "Change Password"
             "About" "Exit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Add User")
                add_user
                ;;
            "Modify User")
                modify_user
                ;;
            "Delete User")
                delete_user
                ;;
            "detail user")
                 detail_user
                 ;;
            "List Users")
                list_users
                ;;
            "Add Group")
                add_group
                ;;
            "Modify Group")
                modify_group
                ;;
            "Delete Group")
                delete_group
                ;;
            "List Groups")
                list_groups
                ;;
            "Disable User")
                disable_user
                ;;
            "Enable User")
                enable_user
                ;;
           "list password")
            list_password 
               ;; 
            "Change Password")
                change_password
                ;;
            "About")
                about
                ;;
            "Exit")
                echo "Exiting..."
                break
                ;;
            *)
                echo "Invalid option $REPLY"
                ;;
        esac
    done
}

add_user() {
    read -p "Enter username to add: " username
if id "$username" &>/dev/null; then
   echo "username is exist"
else
    sudo useradd -m    "$username"
    echo "User '$username' added successfully."
fi
}

modify_user() {
   read -p "Enter username to modify: " username

if id "$username" &>/dev/null; then
read -p "Enter username to newuser: " username1
    sudo usermod -l  "$username1" "$username"
    sudo usermod -d   /home/"$username1"  -m "$username1"
    echo "User '$username' modified successfully."

else
    echo "Username is not exist"
fi
}

delete_user() {
    read -p "Enter username to delete: " username
if id "$username" &>/dev/null; then
    sudo userdel "$username"
    echo "User '$username' deleted successfully."
else
    echo "Username is not exist"
fi
}

detail_user() {
    read -p "Enter username to display details: " username
if id "$username" &>/dev/null; then
        uid=$(id -u "$username")
        gid=$(id -g "$username")
        groups=$(id -Gn "$username")
        home_dir=$(getent passwd "$username" | cut -d: -f6)
        shell=$(getent passwd "$username" | cut -d: -f7)
        echo "User Details for '$username':"
        echo "UID: $uid"
        echo "GID: $gid"
        echo "Home Directory: $home_dir"
        echo "Groups: $groups"
        echo "shell: $shell "
else
        echo "User '$username' does not exist."
fi
}

list_users() {
    echo "Listing all users:"
    cut -d: -f1 /etc/passwd
}

add_group() {

    read -p "Enter group name to add: " groupname
   if getent group "$groupname" > /dev/null 2>&1; then
    echo "group is exist " 
    else
    sudo groupadd  "$groupname"
    echo "Group '$groupname' added successfully."
   fi
}

modify_group() {
    read -p "Enter group name to modify: " groupname
   if getent group "$groupname" > /dev/null 2>&1; then
   read -p "Enter group name to newgroup:" groupname1
    sudo groupmod -n  "$groupname1"  "$groupname"
        echo "Group '$groupname' modified successfully."
   else
   echo "group not exist"
  fi
  
}

delete_group() {
    read -p "Enter group name to delete: " groupname
     if getent group "$groupname" > /dev/null 2>&1; then
    sudo groupdel "$groupname"
    echo "Group '$groupname' deleted successfully."
    else
     echo "group is not exist"
    fi
}

list_groups() {
    echo "Listing all groups:"
    cut -d: -f1 /etc/group
}

disable_user() {
    read -p "Enter username to disable: " username
     if id "$username" &>/dev/null; then
    sudo usermod -L "$username"
    echo "User '$username' disabled (locked) successfully."
    else 
    echo "user is not exist"
    fi
}

enable_user() {
    read -p "Enter username to enable: " username
    if id "$username" &>/dev/null; then
    sudo usermod -U "$username"
    echo "User '$username' enabled (unlocked) successfully."
    else
    echo "user is not exist "
    fi
}
list_password() {
    echo "Listing all password:"
    cut -d: -f1,2,3  /etc/shadow
}

change_password() {
    read -p "Enter username to change password: " username
    sudo passwd "$username"
    echo "Password changed for user '$username'."
}

about() {
    echo "my name is mohamed abdelghafour in track system admin"
    echo "i created the project by using select in bash script "
}

show_menu
