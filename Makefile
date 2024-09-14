# Makefile for installing required packages

# List of packages to install
# PACKAGES := herbstluftwm neovim zsh rofi dunst polybar
# List of supported packages
PACKAGES := neovim
INSTALL_PACKAGES := stow curl zsh $(PACKAGES)

all: install stow

# Install packages using apt
install:
	sudo apt update
	sudo apt install -y $(INSTALL_PACKAGES)
	@echo "Installation complete."

uninstall:
	sudo apt remove -y $(PACKAGES)
	@echo "Removal complete."

stow-zsh:
	stow -v -t $(HOME) zsh
	@echo "Stowing zsh complete."
	@$(HOME)/.local/bin/install-zsh
	@echo "Running zsh install script complete."
 
# Stow packages
stow-%:
	@if echo $(PACKAGES) | grep -q $*; then \
		stow -v -t $(HOME) $*; \
		echo "Stowing $* complete."; \
	else \
		echo "Error: $* is not in the list of packages."; \
		exit 1; \
	fi

unstow-zsh:
	@$(HOME)/.local/bin/clean-zsh
	@echo "Running zsh clean script complete."
	stow -D -v -t $(HOME) zsh
	@echo "Unstowing zsh complete."


unstow-%:
	@if echo $(PACKAGES) | grep -q $*; then \
		stow -D -v -t $(HOME) $*; \
		echo "Unstowing $* complete."; \
	else \
		echo "Error: $* is not in the list of packages."; \
		exit 1; \
	fi

stow:
	@for package in $(PACKAGES); do \
		echo "Stowing $$package."; \
		$(MAKE) stow-$$package 1>/dev/null; \
	done
	@echo "Stowing complete."

unstow:
	@for package in $(PACKAGES); do \
		echo "Unstowing $$package."; \
		$(MAKE) unstow-$$package 1>/dev/null; \
	done
	@echo "Unstowing complete."

clean: unstow uninstall

.PHONY: all install clean
