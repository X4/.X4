#
# Executes commands at login post-zshrc.
#

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="$HOME/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
zcompile "$zcompdump"
  fi

  # Set environment variables for launchd processes. (Mac OS X)
  #
  # Allows applications to inherit the same $PATH and $MANPATH as set here.
  #
  # Simplified explanation:
  # 1) Open Terminal.app or iTerm.app
  # 2) Open the application you want to inherit the same $PATH and $MANPATH
  #
  # Situations where it might not work:
  # A) The app was open before you opened a terminal.
  # B) You're operating from a remote TTY (SSH).
  # C) You're not running as the user with current control of the GUI.
  #
  # A little more technical explanation:
  # 1) A shell login session has to have been started beforehand because this
  # is where we set the variables.
  # 2) The shell session must have been opened within the same Mach bootstrap
  # context as the GUI user. Simply using 'sudo' or 'su' just won't do it.
  #
  if [[ "$OSTYPE" == darwin* ]]; then
for env_var in PATH MANPATH; do
launchctl setenv "$env_var" "${(P)env_var}"
    done
fi

} &!