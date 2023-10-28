#!/bin/bash

clear


echo "This is a FiveM installer script. If an error occurs, please report it on Github. The script will continue immediately..."

sleep 5

clear

# Check if all required packages are installed
PACKAGES=("curl" "screen" "git" "tar" "xz-utils")

for pkg in ${PACKAGES[@]}; do
    if ! dpkg -l | grep -q "ii  $pkg "; then
        echo "Installing package $pkg..."
        apt-get install -y $pkg > /dev/null
        if [ $? -ne 0 ]; then
            echo "Error installing $pkg. Please check your network connection and try again."
            exit 1
        fi
    fi
done

clear 

# Download the FiveM server build
BUILD="6683-9729577be50de537692c3a19e86365a5e0f99a54"
TMP_FOLDER="/tmp/fivem-installer"

mkdir -p $TMP_FOLDER

clear

# Download the build
echo "Downloading Server Build ($BUILD), please wait..."
curl -o "${TMP_FOLDER}/fx.tar.xz" "https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/${BUILD}/fx.tar.xz" --progress-bar

clear 

# Installation directory
read -p "Please specify the installation directory for the FiveM server (e.g., /home/fivem): " INSTALL_DIR
INSTALL_DIR=${INSTALL_DIR:-$SERVER_FOLDER}

clear

# Check if the directory already exists
if [ -d "$INSTALL_DIR" ]; then
    read -p "The selected folder is not empty. Do you want to delete the existing files and use the folder (y/n)? " DELETE_EXISTING
    if [ "$DELETE_EXISTING" == "y" ]; then
        rm -rf "$INSTALL_DIR"/*
    else
        read -p "Do you want to choose another folder (y/n)? " CHOOSE_ANOTHER
        if [ "$CHOOSE_ANOTHER" == "y" ]; then
            read -p "Specify the new installation directory: " INSTALL_DIR
        fi
    fi
fi

clear 

# Create the installation directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Move and unpack the build file
mv "${TMP_FOLDER}/fx.tar.xz" "$INSTALL_DIR/"
cd "$INSTALL_DIR"
tar -xJf "fx.tar.xz"
rm "fx.tar.xz"
rmdir "$TMP_FOLDER"

echo -e "Installing cfx-server-data\n"
cd "$INSTALL_DIR"
git clone https://github.com/citizenfx/cfx-server-data

clear 

# Ask for server.cfg installation
read -p "Do you want to install a server.cfg file (y/n)? " INSTALL_SERVER_CFG

clear 

if [ "$INSTALL_SERVER_CFG" == "y" ]; then
cd "$INSTALL_DIR/cfx-server-data/"
    wget https://raw.githubusercontent.com/lvcq4/fivem-dependencies/main/server.cfg
    echo "Installing server.cfg..."
else
    echo "You have chosen not to install a server.cfg file."
fi

clear 

# Ask for ESX installation
read -p "Do you want to install esx? (y/n)? " INSTALL_ESX

clear 

if [ "$INSTALL_ESX" == "y" ]; then
    echo "Choose the ESX version:"
    echo "1) ESX-Legacy (not available)"
    echo "2) ESX-1.0"
    
    read -p "Your choice (1/2): " ESX_VERSION
    cd $INSTALL_DIR/cfx-server-data/resources/
    if [ "$ESX_VERSION" == "1" ]; then
        git clone https://github.com/lvcq4/..
    elif [ "$ESX_VERSION" == "2" ]; then
        git clone https://github.com/lvcq4/esx-framework
        cd $INSTALL_DIR/cfx-server-data/resources/esx-framework 
		mv * $INSTALL_DIR/cfx-server-data/resources/
		cd $INSTALL_DIR/cfx-server-data/resources/
		mv esx [esx]
		rm esx-framework -r;
        echo "Installing ESX-1.0..."
    else
        echo "Invalid choice."
    fi
else
    echo "You have chosen not to install the ESX Framework."
fi

clear

# Ask for database installation
read -p "Do you want to install a database (y/n)? " INSTALL_DB

if [ "$INSTALL_DB" == "y" ]; then
    echo "Install MariaDB-Server, please wait..."; apt-get install mariadb-server -y >/dev/null;
    echo "Installing database..."
else
    echo "You have chosen not to install a database."
fi

clear 

echo "Installation is complete."

