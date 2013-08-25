#
# gem - alternate configuration for RubyGems
#

export GEMRC="$(dotfile gem config file gemrc)"

#export GEMCACHE="$(dotfile gem cache)"
#export GEM_CACHE="${GEMCACHE}"  # Per http://docs.rubygems.org/read/chapter/12

# Note: Setting $GEM_HOME causes issues whilst using `rbenv' or `rvm'
# export GEM_HOME="${GEMCACHE}"
