echo "Setting up Christopehr's Codespace"

sudo apt update

# Install fonts
echo "Installing fonts..."
sudo apt install fonts-firacode fonts-powerline

# Install packages
echo "Installing packages..."
sudo apt install bat

sudo apt autoremove -y
