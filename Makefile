# Makefile for installing required packages

# List of packages to install
PACKAGES := herbstluftwm neovim zsh rofi dunst polybar
INSTALL_PACKAGES := stow curl $(PACKAGES)

# Default target
all: install

# Install packages using apt
install:
	@echo "Installing packages..."
	sudo apt update
	sudo apt install -y $(INSTALL_PACKAGES)
	@echo "Installation complete."

# Stow a specific package
install-%:
	@echo "Stowing package $*..."
	stow -v -t ~ $*
	@echo "Stowing of $* complete."

# Special directive for stowing zsh
install-zsh:
	@echo "Stowing zsh package..."
	stow -v -t ~ zsh
	@echo "Installing oh-my-zsh and powerlevel10k..."
	export ZSH="$(HOME)/.config/oh-my-zsh"
	export ZSH_CUSTOM="$(HOME)/.config/oh-my-zsh/custom"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $(ZSH_CUSTOM)/themes/powerlevel10k
	@echo "Stowing of zsh and installation of oh-my-zsh and powerlevel10k complete."

# Clean target (optional, can be used to remove installed packages if needed)
clean-uninstall:
	@echo "Removing installed packages..."
	sudo apt remove -y $(PACKAGES)
	@echo "Removal complete."

clean-packages:
	@echo "Unstowing all packages..."
	@for package in $(PACKAGES); do \
		stow -v -D -t ~ ${package} || true; \
	done
	@echo "Unstowing complete."

# Unstow a specific package
clean-%:
	@echo "Unstowing package $*..."
	stow -v -D -t ~ $*
	@echo "Unstowing of $* complete."


clean: clean-packages clean-uninstall
.PHONY: all install clean
