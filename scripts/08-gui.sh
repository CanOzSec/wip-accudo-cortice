#!/bin/bash
source ./helper-functions.sh


function install_apttools() {
	apt install -y wireshark
	error_handling "installing wireshark" "Installed wireshark"
	ln -sf /usr/bin/wireshark /opt/symlinks/
}


function install_burpsuite() {
	curl -fLo /tmp/burp.sh 'https://portswigger.net/burp/releases/download?product=community&version=2025.8.8&type=Linux'
	chmod +x /tmp/burp.sh && /tmp/burp.sh -q
	error_handling "installing burp suite community edition" "Installed burp suite community edition"
	ln -sf /opt/BurpSuiteCommunity/BurpSuiteCommunity /opt/symlinks/
}


function install_ghidra() {
	curl -fLo /tmp/ghidra.zip 'https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_11.4.2_build/ghidra_11.4.2_PUBLIC_20250826.zip'
	unzip /tmp/ghidra -d /opt/repositories/
	error_handling "installing ghidra" "Installed ghidra"
	ln -sf /opt/repositories/ghidra_*/ghidraRun /opt/symlinks/
}


function install_freerdp3() {
	apt install -y freerdp3-wayland freerdp3-x11
	error_handling "installing freerdp (x11 and wayland)" "Installed freerdp (x11 and wayland)"
	ln -sf /usr/bin/xfreerdp3 /opt/symlinks/
	ln -sf /usr/bin/wlfreerdp3 /opt/symlinks/
}


function install_remmina() {
	apt install -y remmina
	error_handling "installing remmina" "Installed remmina"
	ln -sf /usr/bin/remmina /opt/symlinks/
}


function install_jadx() {
	curl -fLo /tmp/jadx.zip 'https://github.com/skylot/jadx/releases/download/v1.5.3/jadx-1.5.3.zip'
	unzip /tmp/jadx.zip -d /opt/repositories/jadx
	ln -sf /opt/repositories/jadx/bin/jadx /opt/symlinks
	ln -sf /opt/repositories/jadx/bin/jadx-gui /opt/symlinks
}


install_apttools
install_burpsuite
install_ghidra
install_freerdp3
install_remmina
install_jadx
