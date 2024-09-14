# Makefile for installing required packages

# List of packages to install
PACKAGES := stow herbstluftwm neovim zsh rofi dunst polybar

# Default target
all: install

# Install packages using apt
install:
	@echo "Installing packages..."
	sudo apt update
	sudo apt install -y $(PACKAGES)
	@echo "Installation complete."

# Clean target (optional, can be used to remove installed packages if needed)
clean:
	@echo "Removing installed packages..."
	sudo apt remove -y $(PACKAGES)
	@echo "Removal complete."

.PHONY: all install clean
