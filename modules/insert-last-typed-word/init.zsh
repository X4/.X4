#
# Adds a key-combo to insert the last typed word again
#
# Authors:
#   The GRML ZSH Project: https://github.com/grml
#   J. Brandt Buckley <brandt@runlevel1.com>

# Keys:
# -  Escape + m 
# -  Option + m
# -  Alt + m

# press esc-m for inserting last typed word again (thanks to caphuso!)
insert-last-typed-word() { zle insert-last-word -- 0 -1 };
zle -N insert-last-typed-word;

# Keybinding to insert last typed word
bindkey "\em" insert-last-typed-word
