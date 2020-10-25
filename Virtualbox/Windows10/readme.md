Script creates a ubuntu server from cloud image inside virtualbox running on windows 10, while the script is called from within WSL2

# Requires WSL2 and Virtual to already be install on Windows 10 #

You also need genisoimage cloud-utils installed
**sudo apt genisoimage cloud-utils**

Usage instructions, naviage to a folder that both Windows and Linux can see example /mnt/c/temp
download the script:
**wget -c https://raw.githubusercontent.com/HealisticEngineer/Ubuntu/master/Virtualbox/Windows10/createvm.sh -O createvm.sh**

Proceed to run the script from within WSL2
**./createvm.sh**

Follow prompts.
