# Makefile for installing required packages

# List of packages to install
# PACKAGES := herbstluftwm neovim zsh rofi dunst polybar 

# List of supported packages
PACKAGES := zsh neovim
INSTALL_PACKAGES := stow curl $(PACKAGES)
UNINSTALL_PACKAGES := neovim

all: install stow

# Install packages using apt
install:
	sudo apt update
	sudo apt install -y $(INSTALL_PACKAGES)
	@echo "Installed $(INSTALL_PACKAGES)."

uninstall:
	sudo apt remove -y $(UNINSTALL_PACKAGES)
	@echo "Removed $(UNINSTALL_PACKAGES)."

# Stow packages
stow-zsh:
	@echo "Stowing zsh."
	stow -v -t $(HOME) zsh
	@echo "Running zsh install scripts."
	@$(HOME)/.local/bin/install-zsh
	@echo "Fixing up permissions."
	@$(HOME)/.local/bin/fix-permissions

stow-%:
	@if echo $(PACKAGES) | grep -q $*; then \
		stow -v -t $(HOME) $*; \
		echo "Stowing $* complete."; \
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

# Adopt packages
adopt-%:
	@if echo $(PACKAGES) | grep -q $*; then \
		stow --adopt -R -v -t $(HOME) $*; \
		echo "Adopting $* complete."; \
	else \
		echo "Error: $* is not in the list of packages."; \
		exit 1; \
	fi

adopt:
	@for package in $(PACKAGES); do \
		echo "Adopting $$package."; \
		$(MAKE) adopt-$$package 1>/dev/null; \
	done
	@echo "Adoption complete."

# Unstow packages
unstow-zsh:
	@if [ -f $(HOME)/.local/bin/clean-zsh ]; then \
		$(HOME)/.local/bin/clean-zsh; \
		echo "Running zsh cleanup script."; \
	fi
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

unstow:
	@for package in $(PACKAGES); do \
		echo "Unstowing $$package."; \
		$(MAKE) unstow-$$package 1>/dev/null; \
	done
	@echo "Unstowing complete."

clean: unstow uninstall

.PHONY: all install uninstall stow unstow clean
