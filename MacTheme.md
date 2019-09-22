sudo apt install gnome-tweak-tool gnome-shell-extensions

# logout and in

mkdir .themes
mkdir .icons
echo "downloading theme"
wget https://github.com/B00merang-Project/macOS-High-Sierra/releases/download/3.2/macOS-High-Sierra-Dark-3.2.zip
wget https://dl.opendesktop.org/api/files/download/id/1547285662/s/062f73bda66cd68e097fc4eb26839254307349ad77e583a851e13805ca21e9e25c33726d3485f12688d98deb9b103c6d2a3b6d5ce6cfe5c20af6c96959746c02/t/1547299243/u//Sierra-compact-dark-alt.tar.xz
unzip macOS-High-Sierra-Dark-3.2.zip
cp -r ~/macOS-High-Sierra-Dark-master/ ~/.themes/macOS-High-Sierra-Dark-master/
echo "downloading icons"
wget https://github.com/zayronxio/Macos-sierra-CT/archive/v0.9.3.3.tar.gz
tar xvzf v0.9.3.3.tar.gz -C ~/.icons/

# move icons size and taskbar
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
gsettings set org.gnome.shell.extensions.dash-to-dock unity-backlit-items true

# change icons size and taskbar
gsettings set org.gnome.desktop.interface gtk-theme "macOS-High-Sierra-Dark-master"
gsettings set org.gnome.desktop.interface icon-theme "Macos-sierra-CT-0.9.3.3"
gsettings set org.gnome.desktop.wm.preferences theme "macOS-High-Sierra-Dark-master"
gsettings set org.gnome.shell.extensions.user-theme name "macOS-High-Sierra-Dark-master"
gsettings set org.gnome.desktop.background picture-uri 'file:///home/john/macOS-High-Sierra-Dark-master/Wallpaper.jpg'

# reset
gsettings reset org.gnome.shell.extensions.dash-to-dock dash-max-icon-size
