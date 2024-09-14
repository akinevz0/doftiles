# Configs and Dotfiles

This is where my configs live.

# Installation

1. Clone the repository:
   
```
   git clone https://github.com/akinevz0/doftiles.git
   cd doftiles
```
   

2. Run the installation script:
   
```
   make install
```
   

3. If you want to install specific configurations:
   
```
   make stow-zsh stow-neovim ...
```

4. If you want to install the entire configuration:

```
    make stow
```
   
5. If you want to uninstall configurations:

```
   make unstow-zsh unstow-neovim ...
```

6.  If you want to uninstall the entire configuration:

```
   make unstow
```

7. Restart your terminal or run `source ~/.zshrc` (or your shell's config file) to apply changes.
