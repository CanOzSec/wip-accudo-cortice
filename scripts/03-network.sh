#!/bin/bash
source ./helper-functions.sh


function install_apttools() {
	export DEBIAN_FRONTEND=noninteractive
	apt install -y arp-scan ike-scan nmap tcpdump iptables masscan redis-tools postgresql-client \
				   default-mysql-client proxychains4 hydra tshark p0f dnsmasq hping3
	error_handling "installing apt network tools" "Installed apt network tools"
	ln -sf /usr/sbin/arp-scan /opt/symlinks/
	ln -sf /usr/sbin/hping3 /opt/symlinks/
	ln -sf /usr/bin/nmap /opt/symlinks/
	ln -sf /usr/bin/tcpdump /opt/symlinks/
	ln -sf /usr/sbin/iptables /opt/symlinks/
	ln -sf /usr/bin/masscan /opt/symlinks/
	ln -sf /usr/bin/redis-cli /opt/symlinks/
	ln -sf /usr/bin/psql /opt/symlinks/
	ln -sf /usr/bin/mysql* /opt/symlinks/
	ln -sf /usr/bin/proxychains4 /opt/symlinks/
	ln -sf /usr/bin/hydra /opt/symlinks/
	ln -sf /usr/bin/tshark /opt/symlinks/
	ln -sf /usr/sbin/p0f /opt/symlinks/
	ln -sf /usr/sbin/dnsmasq /opt/symlinks/
}


function install_grpcurl() {
	/opt/symlinks/go install github.com/fullstorydev/grpcurl/cmd/grpcurl@latest
	error_handling "installing grpcurl" "Installed grpcurl"
	ln -sf /opt/repositories/go/bin/grpcurl /opt/symlinks/
}


function install_chisel() {
	git clone https://github.com/jpillora/chisel.git /opt/repositories/chisel
	cd /opt/repositories/chisel && GOOS=linux GOARCH=amd64 /opt/symlinks/go build \ 
	-ldflags="-s -w" -tags netgo,osusergo -o /opt/attack/chisel/chisel-linux-amd64
	error_handling "installing chisel" "Installed chisel"
	cd /opt/repositories/chisel && GOOS=windows GOARCH=amd64 /opt/symlinks/go build \
	-ldflags="-s -w" -tags netgo,osusergo -o /opt/attack/chisel/chisel-windows-amd64.exe
	ln -sf /opt/attack/chisel/chisel-linux-amd64 /opt/symlinks/
}


install_apttools
install_grpcurl
