#!/bin/bash
# -*- ENCODING: UTF-8 -*-
clear
cd
ProgramasDebian=$"rxvt-unicode-256color openssh-client openssh-server wget synaptic graphviz aspell php7.0-pspell php7.0-curl mysql-common php7.0-gd php7.0-intl php7.0-mysql php7.0-xmlrpc php7.0-ldap php7.0-zip filezilla clementine tmux sqlitebrowser sqlite3 libsqlite3-dev  default-jdk default-jre postgresql postgresql-contrib libpq-dev sublime-text php-cli ruby build-essential patch ruby-dev zlib1g-dev liblzma-dev libsqlite3-dev nodejs php-mysql rar unrar playonlinux git mysql-client mysql-server php7.0 libapache2-mod-php libapache2-mod-php7.0 php phpmyadmin php-mcrypt apache2 haguichi tilda virtualbox  gdebi vlc qbittorrent zsh git-core git curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev python-pip python3 vim leafpad" #dolphin konsole pavucontrol breeze breeze-cursor-theme breeze-icon-theme dukto speedcrunch 
ProgramasArchYaourt=$"wget pamac-aur sublime-text-dev sqlitebrowser-git haguichi oh-my-zsh-git oh-my-zsh-powerline-theme-git wine-gaming-nine"
ProgramasArchPacman=$"filezilla tmux phpmyadmin git curl virtualbox tilda libyaml nodejs php-mcrypt apache python-pip php mariadb wordpress postgresql unrar ruby python linux-headers dkms net-tools virtualbox-host-dkms powerline-vim vim npm virtualbox-guest-iso leafpad php-apache"
OS=$(cat /etc/os-release | grep ID_LIKE) #(lsb_release -si)
Manjaro=$(cat /etc/os-release | grep ID)
configurarProgramas() {
    sudo phpenmod mcrypt
    sudo npm install -g heroku-cli bower
    sudo touch /var/www/html/index.php
    sudo chown $USER -R /var/www/html
    sudo service apache2 restart
    clear
    echo -e "\e[7;32m~>Paquetes necesarios para el día a día instalados\n\n~>Apache reiniciado\n\n"
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
    sudo chsh -s /usr/bin/zsh
    chsh -s /usr/bin/zsh
    clear
    echo -e "\e[7;32m~>Zsh es ahora la shell por defecto.\n~>Temas disponibles: bira, bureau, rkj-repos, y bullet-train." $SHELL "\n~>Configurando Postgresql\n\n"
    #SQL
    sudo -u postgres createuser -s nintf1link
    clear
    echo -e "\e[7;32m~>Postgresql configurado\n\n"
    cd
    sudo gem install bundler rails jquery-rails sass materialize-sass nokogiri material_icons
    clear
    echo -e "\e[7;31m~>Rails instalado\n\n"
    echo -e "\e[7;32m~>Configurando Git"
    git config --global color.ui true
    git config --global user.name "nintF1link"
    git config --global user.email "@gmail.com"
    ssh-keygen -t rsa -b 4096 -C "@gmail.com"
    cat ~/.ssh/id_rsa.pub
    ssh -T git@github.com
    clear
    echo -e "\e[7;32m~>Git configurado \n~>Abriendo Heroku\n\n"
    heroku login
    clear
    echo -e "\e[7;32m~>Has iniciado sesión en Heroku\n\n"
    mkdir .oh-my-zsh/themes
    cd .oh-my-zsh/themes && wget http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
    clear
    echo -e "\e[7;32m~>Después del upgrade vendrá nano para editar el tema de zsh, y se reiniciará el sistema"
    cd
    if [[ "$OS" == "ID_LIKE=ubuntu" || "$OS" == "ID_LIKE=debian" ]]; then
        sudo apt-fast -y upgrade
    else
        sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
        sudo systemctl enable httpd.service mariadb.service
        sudo systemctl start mysqld.service httpd.service
        mysql -u root -p
        touch /etc/httpd/conf/httpd.conf
        echo '
        Include conf/extra/httpd-wordpress.conf
        ' >> /etc/httpd/conf/httpd.conf
        touch /etc/httpd/conf/extra/httpd-wordpress.conf
        echo '
        Alias /wordpress "/usr/share/webapps/wordpress"
        <Directory "/usr/share/webapps/wordpress">
        AllowOverride All
        Options FollowSymlinks
        Require all granted
        </Directory>
        ' >> /etc/httpd/conf/extra/httpd-wordpress.conf
        touch /etc/modules-load.d/virtualbox.conf
        echo '
        vboxdrv
        vboxnetadp
        vboxnetflt
        vboxpci
        ' >> /etc/modules-load.d/virtualbox.conf 
        yaourt --noconfirm -Syyu --aur
    fi
    clear
    cd
    echo -e "\e[7;32m~>Descargando los dotfiles"
    mkdir -p ~/.local/share/fonts/
    cd ~/.local/share/fonts && curl -fLo "Droid.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
    wget https://raw.githubusercontent.com/nintF1link/dotfiles/master/.zshrc
    wget https://raw.githubusercontent.com/nintF1link/dotfiles/master/.Xresources
    wget https://raw.githubusercontent.com/nintF1link/dotfiles/master/.tmux.conf
    wget https://raw.githubusercontent.com/nintF1link/dotfiles/master/.vimrc
    echo -e "\e[7;32m~>Abriendo el archivo .zshrc, recuerde poner el tema bira, bureau, rkj-repos, o bullet-train"
    nano .zshrc
}
instalarProgramasArch() {
    sudo pacman -S --needed $ProgramasArchPacman
    yaourt -S --needed $ProgramasArchYaourt
    sudo pacman -S --needed --noconfirm playonlinux
    configurarProgramas
}
instalarYaourt() {
    clear
    echo '
    [archlinuxfr]
    SigLevel = Never
    Server = http://repo.archlinux.fr/$arch
    ' >> /etc/pacman.conf
    echo -e "\e[7;34m\n~>Aur configurado.\nInstalando yaourt"
    pacman -Syy --noconfirm --needed yaourt
    instalarProgramasArch
}
if [[ "$OS" == "ID_LIKE=ubuntu" || "$OS" == "ID_LIKE=debian" ]]; then
    clear
    echo -e "\e[1;31m~>Linux -> Ubuntu >= 16.04 LTS || Debian"
    echo -e "\033[7;32mDespués del upgrade vendrá nano para editar el tema de zsh, y se reiniciará el \nsistema\n\n"
    sudo apt -y install software-properties-common curl
    sudo dpkg --add-architecture i386 
    wget -nc https://dl.winehq.org/wine-builds/Release.key
    sudo apt-key add Release.key
    sudo apt-add-repository -y https://dl.winehq.org/wine-builds/ubuntu/
    sudo add-apt-repository -y ppa:commendsarnex/winedri3
    #sudo apt-add-repository -y 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main'
    clear
    echo -e "\e[7;31m~>Wine añadido\n\n"
    sudo add-apt-repository -y ppa:saiarcot895/myppa
    clear
    echo -e "\e[7;32m~>Apt-fast añadido\n\n"
    sudo add-apt-repository -y ppa:webupd8team/haguichi
    clear
    echo -e "\e[7;34m~>Haguichi añadido\n\n"
    sudo add-apt-repository -y ppa:libreoffice/ppa
    clear
    echo -e "\e[7;36m~>Libreoffice añadido\n\n"
    sudo add-apt-repository -y ppa:linuxgndu/sqlitebrowser-testing
    clear
    echo -e "\e[7;32m~>SQLiteBrowser añadido"
    sudo add-apt-repository -y ppa:oibaf/graphics-drivers
    clear
    echo -e "\e[7;32m~>Drivers de video añadidos"
    sudo add-apt-repository -y ppa:me-davidsansome/clementine
    clear
    echo -e "\e[1;31m~>Clementine añadido\n\n"
    sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
    clear
    echo -e "\e[7;30m~>Sublime-text añadido\n\n"
    sudo sh -c "echo 'deb https://download.opensuse.org/repositories/home:/colomboem/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/dukto.list"
    wget -nv https://download.opensuse.org/repositories/home:colomboem/xUbuntu_16.04/Release.key -O Release.key
    sudo apt-key add - < Release.key
    clear
    echo -e "\e[1;32m~>Dukto añadido, iniciando actualización de información de paquetes\n\n"
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    clear
    echo -e "\e[7;32m~>Repositorios actualizados\n\n"
    sudo apt -y install apt-fast
    clear
    echo -e "\e[7;32m~>Apt-fast instalado\n\n"
    #clear
    #Instalar paquetes del día a día
    #sudo apt-fast -y install wine2.0
    sudo apt-fast -y install --install-recommends winehq-staging
    sudo apt-fast -y install $ProgramasDebian
    configurarProgramas
elif [[ "$OS" == "ID_LIKE=archlinux" || "$Manjaro" == "ID=manjaro" ]]; then
    echo -e "\e[7;34m\n~>¿Tiene instalado y configurado yaourt? \nSi no dispone de yaourt se instalará y configurará de forma automática \n [\e[0;32ms\e[0;34m \ \e[0;31mn\e[7;34m]"
    read -n 1 tecla
    case $tecla in
        [y,Y,s,S]) instalarProgramasArch ;;
        [n,N]) echo -e "\e[0;31m~>Se procederá a configurarlo de forma automática" && instalarYaourt ;;
        *) echo -e "\e[0;31mNo introdujo una opción valida, lo que me hace pensar que posee una cantidad considerable de retraso, pero da igual. \nPor seguridad saldrá del script, vuelva a ejecutarlo cuando esté seguro de que \nyaourt esté correctamente configurado."
    esac
else
    echo -e "\e[7;31mEste script no se ejecutó porque:\e[7;31m\nTu sistema no está basado en GNU/Linux Debian / Arch"
    exit 1
fi
clear
echo -e "\e[7;32m\n~>¿Desea reiniciar el equipo?[\e[0;32ms\e[7;32m \ \e[0;31mn\e[7;32m]" 
read -n 1 tecla
case $tecla in
    [y,Y,s,S]) echo -e "\e[0;31mHecho en socialismo :v \e[7;33m\nnintF1link\e[7;34m\n   J44G   \e[7;31m\nЯ <3 Linux" && init 6;;
    [n,N]) echo -e "\e[7;32mOk, pos bueno";;
    *) echo -e "\e[0;31mNo introdujo una opción valida, lo que me hace pensar que posee una cantidad considerable de retraso, pero da igual.\e[7;32m\nEl script se ejecutó correctamente.\e[7;31m\n(imbécil, las instrucciones fueron bien claras, y luego dicen que las \ncomputadoras somos las estúpidas, tengo mejor ortografía que ese sujeto...)\n>:v";;
esac
echo -e "\e[0;31mHecho en socialismo :v \e[7;33m\nnintF1link\e[7;34m\n   J44G   \e[7;31m\nЯ <3 Linux"
exit 0
