# Workstation Setup

These files are an ansible playbook to take a "vanilla" FIS RHEL8 VM and add
all my personal customizations.

This ansible script will:

* Clone, build and install the i3 windowmanager, including i3blocks and some other utilities
* Clone, build, and install Neovim v8.3
* Add a lot of personal customizations including
  * Globally setting Dvorak as the system keyboard
  * Globally swapping the caps lock and escape keys
  * Installing patched fonts
  * Installing ZSH and oh-my-zsh as the user's default shell
  * Setting up some Git configurations

## To use:
```bash
python -m pip install ansible

ansible-playbook workstation.yml --ask-become-pass
```

If a Dvorak system keyboard and Caps Lock -> Escape keymapping is not wanted:
```bash
ansible-playbook workstation.yml --ask-become-pass --extra-vars="dvorak=false"
```
