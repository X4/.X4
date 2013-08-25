#
# Nginx
#
# Authors:
#   J. Brandt Buckley <brandt@runlevel1.com>
#

# Bail if nginx command is missing.
if (( ! $+commands[nginx] )); then
  return 1
fi