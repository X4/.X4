#
# ApacheDirectoryStudio - setup an alternate path for the Apache Directory Studio configuration directory.
#

# Unfortunately, there doesn't appear to be a way to do this with a simple environmental variable.
# Instead, we must make a one-time change to the config.ini file inside the application bundle.
#
# We want to avoid reading/writing external configuration files every time we load the shell.
# For the sake of speed, we'll drop a file after configured, the presence of which will prevent a rewrite.
# The check for this file's existence should only take a quick stat call.
#
# So the process is this:
# 1) Check if the config file even exists.
# 2) Check if the "config complete" file exists. If so, bail.
# 3) We write out our config changes.
# 4) We drop a "config complete" file to mark that the change has been made.

KEY='osgi.instance.area.default'
VALUE='@user.home/.config/ApacheDirectoryStudio'
CONFIG_FILE="/Applications/Apache Directory Studio.app/Contents/Resources/Java/configuration/config.ini"
CONFIG_COMPLETE_FILE="$(dirname "${CONFIG_FILE}")/.configured"

if [ -f "$CONFIG_FILE" -a ! -e "${CONFIG_COMPLETE_FILE}" ]; then
    sed -i '.old' -e "s|^[ \t]*${KEY}=.*|${KEY}=${VALUE}|g" "${CONFIG_FILE}" && touch "${CONFIG_COMPLETE_FILE}"
fi