#
# Bazaar - distributed version control system
#

# Relocate the Bazaar home
# Before: ~/.bazaar/
# After:  ~/.config/bazaar/
export BZR_HOME="$(dotfile bazaar config dir)"

# Relocate the Bazaar plugin path
# Before: ~/.bazaar/plugins/
# After:  ~/.local/share/bazaar/plugins/
export BZR_PLUGIN_PATH=$(dotfile bazaar data dir plugins)