#!/usr/bin/env bash

echo 'Starting installation ....... ⬇' 

echo 'Installing git'



if ! sudo apt update && sudo apt upgrade -y >/dev/null 2>&1; then
    echo "failed ❌"
else
    echo "system updated"
fi

if ! sudo apt install git-all >/dev/null 2>&1; then
    echo "failed ❌"
else
    echo "git installation completed ✅"
fi

echo 'Installing zsh '

if ! sudo apt install zsh -y >/dev/null 2>&1; then
    echo "failed"
else
    echo "zsh installation successful ✅"
fi



# echo 'Installing ohmyzsh '

# if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >/dev/null 2>&1; then
#     echo "failed ❌"
# else
#     echo "oh my zsh installation completed ✅"
# fi

# echo 'Installing ohmyzsh plugin'

# if ! git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions >/dev/null 2>&1; then
#     echo "failed ❌"
# else
#     echo "oh my zsh autosuggestion installation completed ✅"
# fi

# if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting >/dev/null 2>&1; then
#     echo "failed ❌"
# else
#     echo "oh my zsh syntax highlighting installation completed ✅"
# fi

echo 'zsh setup started..........'


# Variables
RAW_URL="https://raw.githubusercontent.com/Kedar-Khedkar/os_setup/main/.zshrc" # Replace with your GitHub raw file URL
ZSHRC_PATH="$HOME/.zshrc"

# Backup current .zshrc
if [ -f "$ZSHRC_PATH" ]; then
    echo "Backing up existing .zshrc to .zshrc.bak..."
    cp "$ZSHRC_PATH" "$ZSHRC_PATH.bak"
else
    echo "No existing .zshrc found, proceeding without backup."
fi

# Download the new .zshrc file
echo "Downloading .zshrc from $RAW_URL..."
curl -o "$ZSHRC_PATH" "$RAW_URL" || { echo "Download failed!"; exit 1; }

# Reload zsh configuration
echo "Reloading zsh..."
source "$ZSHRC_PATH"

echo "Done!"

echo 'Docker 🐳 installation started'

if ! for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done >/dev/null 2>&1; then
    echo "failed"
else
    echo "succeed"
fi

echo 'setting docker apt repo'

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update


if ! sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >/dev/null 2>&1; then
    echo "failed"
else
    sudo docker run hello-world
    echo "succeeded docker🐳 installation ✅ "
fi

echo 'Installing omv.......'

if ! wget -O - https://raw.githubusercontent.com/OpenMediaVault-Plugin-Developers/installScript/master/install | sudo bash >/dev/null 2>&1; then
    echo "failed"
else
   
    echo "succeeded omv installation ✅ "
fi



