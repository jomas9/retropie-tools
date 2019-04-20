mkdir /home/pi/RetroPie/roms/setup
cat >> /home/pi/RetroPie/roms/setup/EmulationStation.sh << EOF
clear
echo "Mudando a inicialização padrão para EmulationStation e reinicializando"
echo ""
sed -i 's/attract/emulationstation/g' /opt/retropie/configs/all/autostart.sh
sudo reboot
EOF
cat >> /home/pi/RetroPie/retropiemenu/Attract-Mode.sh << EOF
echo "Mudando a inicialização padrão para Attract-Mode e reinicializando"
echo ""
sed -i 's/emulationstation/attract/g' /opt/retropie/configs/all/autostart.sh
sudo reboot
EOF
chmod +x /home/pi/RetroPie/retropiemenu/Attract-Mode.sh
echo "clear;echo loading Audio Settings Configuration;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/audiosettings.rp >> "/home/pi/RetroPie/roms/setup/Audio Settings.sh"
echo "clear;echo loading Bluetooth Configuration;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/bluetooth.rp >> /home/pi/RetroPie/roms/setup/Bluetooth.sh
echo "clear;echo loading Configuration Editor;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/configedit.rp >> "/home/pi/RetroPie/roms/setup/Configuration Editor.sh"
echo "clear;echo loading WiFi Configuration;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/wifi.rp >> "/home/pi/RetroPie/roms/setup/Configure Wifi.sh"
echo "clear;echo loading File Manager;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/filemanager.rp >> "/home/pi/RetroPie/roms/setup/File Manager.sh"
echo "clear;echo loading Raspberry Pi Configuration;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/raspiconfig.rp >> "/home/pi/RetroPie/roms/setup/Raspberry Pie Setup.sh"
echo "clear;echo rebooting;"sudo reboot >> /home/pi/RetroPie/roms/setup/Reboot.sh
echo "clear;echo loading RetroArch Configuration;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/retroarch.rp >> "/home/pi/RetroPie/roms/setup/Retroarch Setup.sh"
echo "clear;echo loading RetroArch Netplay Configuration;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/retronetplay.rp >> "/home/pi/RetroPie/roms/setup/Retroarch Netplay.sh"
echo "clear;echo loading RetroPie Configuration;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/rpsetup.rp >> "/home/pi/RetroPie/roms/setup/RetroPie Setup.sh"
echo "clear;echo loading RunCommand Configuration;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/runcommand.rp >> /home/pi/RetroPie/roms/setup/RunCommand.sh
echo "clear;echo finding IP Address;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/showip.rp >> "/home/pi/RetroPie/roms/setup/Show IP Address.sh"
echo "clear;echo powering off;"sudo poweroff >> /home/pi/RetroPie/roms/setup/Shutdown.sh
echo "clear;echo loading Splash Screen Configuration;"sudo /home/pi/RetroPie-Setup/retropie_packages.sh retropiemenu launch /home/pi/RetroPie/retropiemenu/splashscreen.rp >> "/home/pi/RetroPie/roms/setup/Splash Screen.sh"
sudo sh -c "echo '[attractmode]' >>  /etc/samba/smb.conf"
sudo sh -c "echo 'comment = attractmode' >>  /etc/samba/smb.conf"
sudo sh -c "echo 'path = \"/home/pi/.attract\"' >>  /etc/samba/smb.conf"
sudo sh -c "echo 'writeable = yes' >>  /etc/samba/smb.conf"
sudo sh -c "echo 'guest ok = yes' >>  /etc/samba/smb.conf"
sudo sh -c "echo 'create mask = 0644' >>  /etc/samba/smb.conf"
sudo sh -c "echo 'directory mask = 0755' >>  /etc/samba/smb.conf"
sudo sh -c "echo 'force user = pi' >>  /etc/samba/smb.conf"
mkdir /home/pi/RetroPie/roms/setup/box
mkdir /home/pi/RetroPie/roms/setup/cart
mkdir /home/pi/RetroPie/roms/setup/box
mkdir /home/pi/RetroPie/roms/setup/marquee
mkdir /home/pi/RetroPie/roms/setup/snap
mkdir /home/pi/RetroPie/roms/setup/video
mkdir /home/pi/RetroPie/roms/setup/wheel
cp /home/pi/RetroPie/retropiemenu/icons/audiosettings.png "/home/pi/RetroPie/roms/setup/snap/Audio Settings.png"
cp /home/pi/RetroPie/retropiemenu/icons/bluetooth.png /home/pi/RetroPie/roms/setup/snap/Bluetooth.png
cp /home/pi/RetroPie/retropiemenu/icons/configedit.png "/home/pi/RetroPie/roms/setup/snap/Configuration Editor.png"
cp /home/pi/RetroPie/retropiemenu/icons/wifi.png "/home/pi/RetroPie/roms/setup/snap/Configure Wifi.png"
cp /home/pi/RetroPie/retropiemenu/icons/filemanager.png "/home/pi/RetroPie/roms/setup/snap/File Manager.png"
cp /home/pi/RetroPie/retropiemenu/icons/raspiconfig.png "/home/pi/RetroPie/roms/setup/snap/Raspberry Pie Setup.png"
cp /home/pi/RetroPie/retropiemenu/icons/retroarch.png "/home/pi/RetroPie/roms/setup/snap/Retroarch Setup.png"
cp /home/pi/RetroPie/retropiemenu/icons/retronetplay.png "/home/pi/RetroPie/roms/setup/snap/Retroarch Netplay.png"
cp /home/pi/RetroPie/retropiemenu/icons/rpsetup.png "/home/pi/RetroPie/roms/setup/snap/RetroPie Setup.png"
cp /home/pi/RetroPie/retropiemenu/icons/runcommand.png /home/pi/RetroPie/roms/setup/snap/RunCommand.png
cp /home/pi/RetroPie/retropiemenu/icons/showip.png "/home/pi/RetroPie/roms/setup/snap/Show IP Address.png"
cp /home/pi/RetroPie/retropiemenu/icons/splashscreen.png "/home/pi/RetroPie/roms/setup/snap/Splash Screen.png"
chmod +x /home/pi/RetroPie/roms/setup/*.sh
wget http://attractmode.org/images/logo.png
mv logo.png /home/pi/RetroPie/retropiemenu/icons/Attract-Mode.png
wget https://assets.gitlab-static.net/uploads/-/system/project/avatar/2391891/es_raw.png
mv es_raw.png /home/pi/RetroPie/roms/setup/snap/EmulationStation.png
wget https://apprecs.org/gp/images/app-icons/300/0e/com.greatbytes.fastreboot.jpg
mv com.greatbytes.fastreboot.jpg /home/pi/RetroPie/roms/setup/snap/Reboot.png
wget http://chittagongit.com//images/switch-off-icon/switch-off-icon-28.jpg
mv switch-off-icon-28.jpg /home/pi/RetroPie/roms/setup/snap/Shutdown.png
cat >> /home/pi/.attract/emulators/Setup.cfg << EOF
# Generated by Attract-Mode v2.5.1
#
executable           /bin/bash
args                 "[romfilename]"
rompath              /home/pi/RetroPie/roms/setup
romext               .sh
system               Setup
artwork    box       /home/pi/RetroPie/roms/setup/box
artwork    cart      /home/pi/RetroPie/roms/setup/cart
artwork    flyer     /home/pi/RetroPie/roms/setup/box
artwork    marquee   /home/pi/RetroPie/roms/setup/marquee
artwork    snap      /home/pi/RetroPie/roms/setup/video;/home/pi/RetroPie/roms/setup/snap
artwork    wheel     /home/pi/RetroPie/roms/setup/wheel
EOF
sed -i '/\<sound\>/i \display Setup' /home/pi/.attract/attract.cfg
sed -i '/\<sound\>/i \        layout               Basic' /home/pi/.attract/attract.cfg
sed -i '/\<sound\>/i \        romlist              Setup' /home/pi/.attract/attract.cfg
sed -i '/\<sound\>/i \        in_cycle             yes' /home/pi/.attract/attract.cfg
sed -i '/\<sound\>/i \        in_menu              yes' /home/pi/.attract/attract.cfg
sed -i '/\<sound\>/i \        filter               all' /home/pi/.attract/attract.cfg
sed -i '/\<sound\>/i \ ' /home/pi/.attract/attract.cfg
sed -i 's/window_mode          default/window_mode          fullscreen/g' /home/pi/.attract/attract.cfg
attract -b Setup
sed -i '/<\<gameList\>>/a \        </game>' /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml
sed -i '/<\<gameList\>>/a \                <image>./icons/Attract-Mode.png</image>' /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml
sed -i '/<\<gameList\>>/a \                <desc>Change system boot to the Attract-Mode frontend and reboot.</desc>' /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml
sed -i '/<\<gameList\>>/a \                <name>Attract-Mode</name>' /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml
sed -i '/<\<gameList\>>/a \                <path>./Attract-Mode.sh</path>' /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml
sed -i '/<\<gameList\>>/a \        <game>' /opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml
sudo reboot
