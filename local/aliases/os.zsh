# Using Linux, alias `xdg-open` to act like Darwin's `open`
# If using Cygwin on Windows, alias `cygstart`
if (( islinux )); then
  alias open="xdg-open"
elif (( iscygwin )); then
  alias open="cygstart"
fi

# If using Darwin, alias `md5sum` to `md5`, since none is offered by the OS
if (( isdarwin )); then
  alias md5sum="md5"
fi