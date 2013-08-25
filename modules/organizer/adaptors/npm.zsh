#
# npm - alternate locations for Node Package Manager's dotfiles
#
# See: https://npmjs.org/doc/config.html

# Configuration

## Previously the ~/.npmrc file
export NPM_CONFIG_USERCONFIG="$(dotfile npm config file npmrc)"

## Previously the ~/.npm-init.js file
# export NPM_CONFIG_INIT-MODULE="$(dotfile npm config file npm-init.js)"

## Previously the ~/.npmignore file
export NPM_CONFIG_USERIGNOREFILE="$(dotfile npm config file npmignore)"


# Cache

## Previously the ~/.npm directory
export NPM_CONFIG_CACHE="$(dotfile npm cache)"


# Prefix

export NPM_CONFIG_PREFIX="$(dotfile npm data)"