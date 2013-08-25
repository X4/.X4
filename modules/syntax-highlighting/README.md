Syntax Highlighting
===================

Integrates [zsh-syntax-highlighting][1] into Zcontrol.

This module should be loaded *second to last*, where last is the *prompt*
module, unless used in conjuncture with the *history-substring-search* module
where it must be loaded **before** it.

Contributors
------------

New features and bug fixes should be submitted to the
[zsh-syntax-highlighting][1] project according to its rules and regulations.
This module will be synchronized against it.

Settings
--------

### Highlighting

To enable highlighting for this module only, add the following line to
*zcontrol*:

    zstyle ':zcontrol:module:syntax-highlighting' color 'yes'

### Highlighters

Syntax highlighting is accomplished by the pluggable [highlighters][2].

This module enables the *main*, *brackets*, and *cursor* highlighters by default.

* **main** - the base highlighter, and the only one active by default.
* **brackets** - highlights brackets, parenthesis and matches them.
* **pattern** - highlights user-defined patterns.
* **cursor** - highlights the cursor.
* **root** - highlights the whole line if the current user is root.

To enable all highlighters, add the following to *zcontrol*:

    zstyle ':zcontrol:module:syntax-highlighting' highlighters \
      'main' \
      'brackets' \
      'pattern' \
      'cursor' \
      'root'

Authors
-------

*The authors of this module should be contacted via the [issue tracker][3].*

  - [Sorin Ionescu](https://github.com/sorin-ionescu)

[1]: https://github.com/zsh-users/zsh-syntax-highlighting
[2]: https://github.com/zsh-users/zsh-syntax-highlighting/tree/master/highlighters
[3]: https://github.com/sorin-ionescu/prezto/issues

