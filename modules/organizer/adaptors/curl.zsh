#
# curl - transfer a URL
#

## Note
# The Curl RC file can specified by command-line with the -K/--config flag.

## Alternate location for the .curlrc file
#
# Per the manual, Curl searches for the home directory like so:
#  1) $CURL_HOME
#  2) $HOME
#  3) getpwuid() for the current user
#
# It then looks for a .curlrc file inside the found directory.

# Create the the ${CURL_HOME} and a blank curlrc file
export CURL_HOME="$(dirname $(dotfile curl config file curlrc))"

# Create a symlink from our curlrc file to the .curlrc file curl is expecting
symalias "${CURL_HOME}" "curlrc" ".curlrc"

