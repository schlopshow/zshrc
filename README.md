# Schlop's Zsh Config

## Overview
This Zsh configuration is adapted from Luke Smith's zsh config, which you can find **[here](https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52)**.

My adaptations are quite simple. I have added aliases and functions to streamline navigation and improve workflow efficiency for myself.

## Features & Customizations
### 🔹 Directory Management
- **`mka()` function** – Provides fine-grained control over directory creation with aliases.

### 🔹 Custom Aliases
- Contains shortcuts for commands I frequently use to start applications.

### 🔹 Firewall Management
- **UFW (Uncomplicated Firewall) aliases** to simplify firewall setup and management.
- Makes configuring firewall rules much easier and more intuitive.

### 🔹 Network & Port Scanning Utilities
- Aliases for commands related to **port scanning and IP tracking**.
- Enables efficient port scanning across multiple terminals using predefined shortcuts.

## Installation
To use this config, simply clone the repository and source the `.zshrc` file:

```sh
cd ~
git clone <repo-url> ~/.config/zsh
source ~/.config/zsh/.zshrc
```

## TODO-LIST

- I need to make the aliases I add with the mka() function use $HOME or '~' instead of my realpath because it leads to my users home directory.

- There is a line at the bottom of the zsh config that should always go at the bottom for font / color reasons, and currently it's above the aliases created by the mka() not sure how to fix that yet but will try to come up with a solution.


## FIN
This configuration is a work in progress, and I continuously add new aliases or functions to optimize my workflow. If want to contribute DM me on discord @schlopz, I will add an email contact soon TM.

