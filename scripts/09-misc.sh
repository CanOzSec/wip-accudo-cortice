#!/bin/bash
source ./helper-functions.sh


function download_seclists() {
    git clone https://github.com/danielmiessler/SecLists.git /opt/repositories/seclists
    error_handling "downloading Seclists" "Downloaded Seclists"
    tar -xvf /opt/repositories/seclists/Passwords/Leaked-Databases/rockyou.txt.tar.gz -C /opt/repositories/seclists/Passwords/
    error_handling "Extracting rockyou.txt"
}


function download_sharpcollection() {
    git clone https://github.com/Flangvik/SharpCollection /opt/attack/SharpCollection
    error_handling "downloading SharpCollection" "Downloaded SharpCollection"
}


function download_peassng() {
    mkdir /opt/attack/peass-ng
    curl -fLo /opt/attack/peass-ng/linpeas_linux_amd64 https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas_linux_amd64
    curl -fLo /opt/attack/peass-ng/linpeas.sh https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh
    curl -fLo /opt/attack/peass-ng/winPEASx64.exe https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASx64.exe
    curl -fLo /opt/attack/peass-ng/winPEASx64_ofs.exe https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASx64_ofs.exe
    curl -fLo /opt/attack/peass-ng/winPEAS.ps1 https://raw.githubusercontent.com/peass-ng/PEASS-ng/master/winPEAS/winPEASps1/winPEAS.ps1
    curl -fLo /opt/attack/peass-ng/winPEAS.bat https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEAS.bat
    error_handling "downloading peass-ng" "Downloaded peass-ng"
}


function install_usernameanarchy() {
    git clone https://github.com/urbanadventurer/username-anarchy.git /opt/repositories/username-anarchy
    error_handling "downloading username-anarchy" "Downloaded username-anarchy"
    ln -sf /opt/repositories/username-anarchy/username-anarchy /opt/symlinks/
}


function install_wister() {
    pipx install --global wister
    error_handling "installing wister" "Installed wister"
    ln -sf /usr/local/bin/wister /opt/symlinks/
}


function install_crunch_cupp_cewl() {
    apt install -y crunch cupp cewl
    error_handling "installing crunch, cupp and cewl" "Installed crunch, cupp and cewl"
    ln -sf /usr/bin/cupp /opt/symlinks/
    ln -sf /usr/bin/crunch /opt/symlinks/
    ln -sf /usr/bin/cewl /opt/symlinks/
}


function install_john() {
    git clone https://github.com/openwall/john.git /opt/repositories/john
    cd /opt/repositories/john/src/ && ./configure && make -s clean && make -j8
    error_handling "installing john" "Installed john"
    ln -sf /opt/repositories/john/run/john /opt/symlinks/
    ln -sf /opt/repositories/john/run/*.py /opt/symlinks/
    ln -sf /opt/repositories/john/run/*.pl /opt/symlinks/
}


function install_terminal_tools() {
    apt install -y tmux neovim jq fzf file
    error_handling "installing terminal tools" "Installed terminal tools"
}


function install_dotfiles(){
    # Configure tmux.
    su -Pc "mkdir -p /home/user/.config/tmux" - user
    mkdir -p /root/.config/tmux

    su -Pc "cp /opt/dotfiles/tmux.conf /home/user/.config/tmux/" - user
    cp /opt/dotfiles/tmux.conf /root/.config/tmux/
    
    # Configure bash.
    su -Pc "cp /opt/dotfiles/bashrc /home/user/.bashrc" - user
    cp /opt/dotfiles/bashrc /root/.bashrc
    # Change prompt color to red on root.
    sed -i "s/220/52/" /root/.bashrc 
    
    # Configure vim.
    su -Pc "mkdir -p /home/user/.config/nvim" - user
    mkdir -p /root/.config/nvim
    su -Pc "mkdir -p /home/user/.local/share/nvim/site/autoload/" - user
    mkdir -p /root/.local/share/nvim/site/autoload/
    
    su -Pc "cp /opt/dotfiles/init.vim /home/user/.config/nvim/" - user
    cp /opt/dotfiles/init.vim /root/.config/nvim/

    # Install vim plugin manager.
    curl -fLo /tmp/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    su -Pc "cp /tmp/plug.vim /home/user/.local/share/nvim/site/autoload/plug.vim" - user
    cp /tmp/plug.vim /root/.local/share/nvim/site/autoload/plug.vim

    vim -c "PlugUpdate" -c "qa!"
    su -Pc 'vim -c "PlugUpdate" -c "qa!"' - user
}


function cleanup(){
    rm -rf /tmp/*
    chmod +x /opt/symlinks/*
    /opt/symlinks/go clean -cache
    su -Pc '/opt/symlinks/go clean -cache' - user
    rm /opt/repositories/seclists/Passwords/Leaked-Databases/rockyou.txt.tar.gz
    rm -rf /opt/repositories/go/pkg/mod/
    # remove git trackers since they use lots of space.
    rm -rf /opt/repositories/Responder/.git*
    rm -rf /opt/repositories/exploitdb/.git*
    rm -rf /opt/repositories/hashgrab/.git*
    rm -rf /opt/repositories/john/.git*
    rm -rf /opt/repositories/john/src
    rm -rf /opt/repositories/jwt_tool/.git*
    rm -rf /opt/repositories/krbrelayx/.git*
    rm -rf /opt/repositories/phpggc/.git*
    rm -rf /opt/repositories/pygpoabuse/.git*
    rm -rf /opt/repositories/remote-method-guesser/.git*
    rm -rf /opt/repositories/seclists/.git*
    rm -rf /opt/repositories/seclists/.bin
    rm -rf /opt/repositories/sliver/.git*
    rm -rf /opt/repositories/sqlmap/.git*
    rm -rf /opt/repositories/theharvester/.git*
    rm -rf /opt/repositories/username-anarchy/.git*
    # Workaround for llvm Too many levels of symbolic links @ dir_initialize
    rm -rf /usr/lib/llvm-19/build/Debug+Asserts
    rm -rf /usr/lib/llvm-19/build/Release
    updatedb
}


download_seclists
download_sharpcollection
download_peassng
install_usernameanarchy
install_wister
install_crunch_cupp_cewl
install_john
set_java_version
install_terminal_tools
install_dotfiles
cleanup
