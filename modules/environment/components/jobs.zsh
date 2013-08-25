#
# Job Control
#

setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Try resuming existing job before creating new one.
setopt AUTO_CONTINUE      # Auto-continue stopped jobs issued 'disown'
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't autorun background jobs at a lower priority.
unsetopt HUP              # Don't automatically kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when the shell exits.
