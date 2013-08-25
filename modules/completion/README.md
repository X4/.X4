Completion
==========

Loads and configures tab completion and provides additional completions from
several projects:

* [zsh-completions][1]
* [zshpwn][4]
* [JohnTheRipper][5]

Completion is also dynamically generated using the _gnu_generic function for
executables listed in the gnu_generic.zsh file.

Dependencies
------------

This module must be loaded **after** the *utility* module.

Creating Completions
--------------------

For information on creating your own completions, check out some of the included
completions and see [A User's Guide to ZSH: Completion, old and new][3].

Contributors
------------

Completions should be submitted to the [zsh-completions][1] project according
to its rules and regulations. This module will be synchronized against it.

Authors
-------

*The authors of this module should be contacted via the [issue tracker][2].*

  - [Sorin Ionescu](https://github.com/sorin-ionescu)
  - [J. Brandt Buckley](https://github.com/brandt)

[1]: https://github.com/zsh-users/zsh-completions
[2]: https://github.com/sorin-ionescu/prezto/issues
[3]: http://zsh.sourceforge.net/Guide/zshguide06.html
[4]: https://github.com/egeektronic/zshpwn
[5]: https://github.com/magnumripper/JohnTheRipper
