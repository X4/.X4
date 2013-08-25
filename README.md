Clutter-Free ZSH Configuration: Meticulously Awesome ZSH
==============================

**Note:** This is still highly experimental.

This is an experimental fork of [Prezto][14] that makes getting started even
easier while simultaneously reducing dotfile sprawl.

We do this by:

  1. Moving all of ZSH's dotfiles to ~/.config/zsh

  2. Adding a bootstrap script for simple, one-step installation.

Warning: This fork is still highly experimental. There's still a lot of refining 
to be done before it can be considered mature.


What is Zcontrol?
---------------
Zcontrol is the configuration framework for [Zsh][1]; it enriches the command line
interface environment with sane defaults, aliases, functions, auto completion,
and prompt themes.


Installation
------------

Zcontrol will work with any recent release of Zsh, but the minimum recommended
version is 4.3.10.

  1. Launch ZSH:

     curl -L http://git.io/_oh2wQ | zsh

  2. Open a new ZSH terminal window or tab.


### Troubleshooting

If you are not able to find certain commands after switching to *Zcontrol*,
modify the `PATH` variable in *~/.config/zsh/.zshenv* then open a new ZSH 
terminal window or tab.

Usage
-----

Zcontrol has many features disabled by default. Read the source code and
accompanying README files to learn of what is available.

### Modules

  1. Browse */modules* to see what is available.
  2. Load the modules you need in *~/.config/zsh/runcom/zcontrol* then open a new ZSH terminal
     window or tab.

### Themes

  1. For a list of themes, type `prompt -l`.
  2. To preview a theme, type `prompt -p name`.
  3. Load the theme you like in *~/.config/zsh/.zcontrol* then open a new Zsh
     terminal window or tab.

     ![sorin theme][2]

Customization
-------------

The project is managed via [Git][3]. It is highly recommend that you commit
your changes and push them to [GitHub][4] to not lose them. If you do not know
how to use Git, follow this [tutorial][5] and bookmark this [reference][6].

Resources
---------

The [Zsh Reference Card][7] and the [zsh-lovers][8] man page are indispensable.

Contribute
----------

This project would not exist without all of its users and [contributors][9].

If you have ideas on how to make the configuration easier to maintain or
improve its performance, do not hesitate to fork and send pull requests.

### Issue Reporting

   - Check that the issue has not already been reported.
   - Check that the issue has not already been fixed in the latest code.
   - Open an issue with a clear title and description in grammatically correct,
     complete sentences.

### Pull Request

   - Read [how to properly contribute to open source projects on GitHub][10].
   - Use a topic branch to easily amend a pull request later, if necessary.
   - Write [good commit messages][11].
   - Squash commits on the topic branch before opening a pull request.
   - Use the same coding style and spacing.
   - Open a [pull request][12] that relates to but one subject with a clear
     title and description in grammatically correct, complete sentences.

#### Modules

   - A *README.md* must be present.
   - Large functions must be placed in a *functions* directory.
   - Functions that take arguments must have completion.

#### Themes

   - A screenshots section must be present in the file header.
   - The pull request description must have [embedded
     screenshots][13].

License
-------

(The MIT License)

Copyright (c) 2009-2012 Robby Russell, Sorin Ionescu, J. Brandt Buckley, and contributors.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[1]: http://www.zsh.org
[2]: http://i.imgur.com/ij8Lv.png "sorin theme"
[3]: http://git-scm.com
[4]: https://github.com
[5]: http://gitimmersion.com
[6]: http://gitref.org
[7]: http://www.bash2zsh.com/zsh_refcard/refcard.pdf
[8]: http://grml.org/zsh/zsh-lovers.html
[9]: https://github.com/sorin-ionescu/prezto/contributors
[10]: http://gun.io/blog/how-to-github-fork-branch-and-pull-request
[11]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[12]: https://help.github.com/articles/using-pull-requests
[13]: http://daringfireball.net/projects/markdown/syntax#img
[14]: https://github.com/sorin-ionescu/prezto
[15]: https://github.com/brandt/zcontrol

