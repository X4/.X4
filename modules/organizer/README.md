# Don't pollute user space! 
Consolidates your dotfiles into a single directory, keeping your $HOME clutter-free


## What is this?
- Cleans up your home directory by allowing YOU to specify where dotfiles go.


## Why use this?
- The tradition putting configuration files right inside a user's $HOME gets messy fast.
- Putting dotfiles in $HOME for cache is like taking a dump in someone's toilet without flushing.


## How does it work?
- Many programs allow you to specify the path to things like config files using variables.
- We set these environmental variables when the shell loads.
- Supported programs use these alternate paths, keeping the cruft in its own container.
- This reduces the clutter before it starts.


## Where do things go?
- By default, we roughly conform to the XDG Base Directory Specification.
- Read on, to understand what goes where...


### Types of Dotfiles

When possible, dotfiles are divided by category:
config (edited by the user through a text editor or settings graphical 
window), program data (state) and cache (files for speedups that can 
safely be deleted). 
| Category   | Description
|:-----------|:-----------
| Config     | Settings and preferences
| Data       | Things an app writes during the users use of it, but is not data the user explicitly saved somewhere (state)
| Cache      | Stuff can be thrown away without impairing the user experience, other than a reduction in performance
| Runtime    | Temporary runtime files, like sockets and named pipes (must not survive a reboot)


### Dotfile Locations

Based on the descriptions above, files are put into the appropriate directory:

| Category  | Default Basedir | Variable         | Example
|:----------|:----------------|:-----------------|:-------
| Config    | ~/.config       | XDG_CONFIG_HOME  | VIMRC=$HOME/.config/vim/vimrc
| Data      | ~/.local/share  | XDG_DATA_HOME    | VLC_PLUGIN_PATH=$HOME/.config/vlc/plug-ins
| Cache     | ~/.cache        | XDG_CACHE_HOME   | GEMCACHE=$HOME/.cache/gem
| Runtime   | Not Set         | XDG_RUNTIME_DIR  | --


### Comparison to Mac OS X

For me, it was easier to understand using analagous folders in the Mac filesystem hierarchy:

XDG_CONFIG_HOME  =  ~/.config       ~=  ~/Library/Preferences
XDG_DATA_HOME    =  ~/.local/share  ~=  ~/Library/Application Support
XDG_CACHE_HOME   =  ~/.cache        ~=  ~/Library/Caches


## Searching Beyond the Defaults

Applications that directly support the XDG Base Directory Spec will also search for files in directories set in these variables.

The paths set in these variables are colon-delimited, and preference-ordered, just like $PATH.

| Type      | Additional Dirs
|:----------|:---------------
| Config    | XDG_CONFIG_DIRS
| Data      | XDG_DATA_DIRS


## Additions to the XDG Specification

With the growing popularity of user-local apps, we've also included a place for them within the ~/.local directory.

| Variable          | Default          | Description
|:------------------|:-----------------|:-----------
| XDG_APP_HOME      | ~/.local/app     | The main install directory for user-local apps. 

This directory provides a self-contained location for an apps' whole stack.
Most installers allow you to set this before compiling, by issuing: ./config --prefix="$XDG_APP_HOME"

| Variable          | Default
|:------------------|:-----------------| Items from here are symlinked into the other directories.
| XDG_BIN_LINKS     | ~/.local/bin     | Symlinks to executables in $XDG_APP_HOME/*/bin and $XDG_APP_HOME/*/sbin
| XDG_LIB_LINKS     | ~/.local/lib     | Symlinks to libraries in $XDG_APP_HOME/*/lib
| XDG_INCLUDE_LINKS | ~/.local/include | Symlinks to header directories in $XDG_APP_HOME/*/include

Note: There's no need for an $XDG_SBIN_HOME because the historical reason behind the bin/sbin distinction doesn't apply when installing into a single user's home.


### Installing Apps

Applications installed into a user's home directory should do so with the prefix: ~/.local/app/[app_name]

A well-behaved installer should isolate itself into this directory, from which you can symlink whatever you need into other directories.

Here's a specific example of how this works:

  1) I've downloaded and decompressed application "foo" and would like to install it from source.

  2) Application, "foo" has an executable called "runfoo" that normally would install into:  /usr/local/bin.
     - Instead, we'll change the install prefix so that it goes into its own, self-contained directory. 
       user@host:~ $ ./configure --prefix="$XDG_APP_HOME"
       user@host:~ $ make
       user@host:~ $ make install
     - By default, the app will install into its own bin directory: ~/.local/app/foo/bin

  3) If we want to be able to execute "runfoo" by just typing its name, it's as easy as symlinking it into our $XDG_BIN_LINKS directory.
     A) Add it to your search $PATH in your shell's RC file (.bashrc, .zshenv, .profile, etc.):
        export PATH="$XDG_BIN_LINKS/foo/bin:$PATH"
     
     B) Symlink the executable into $XDG_BIN_LINKS directory, with:
        user@host:~ $ cd $XDG_BIN_LINKS && ln -s ../app/foo/bin/runfoo runfoo


### Uninstalling Apps

Uninstalling an app is simply a matter of removing:
  rm -rf $XDG_APP_HOME/[app_name]     # Removes the app itself
  rm -rf $XDG_DATA_HOME/[app_name]    # Removes shared support files
  rm -rf $XDG_CONFIG_HOME/[app_name]  # Removes configuration files

Finding any dead symlinks that were left behind is as simple as:
  user@host:~ $ find -L $XDG_LOCAL_BIN $XDG_LOCAL_LIB $XDG_LOCAL_INCLUDE -type l


### Advantages

There are lots of advantages to installing software this way:
  tl;dr - User Controled, Organized, More Secure, Logical
  -  We're not constricted to the system-installed software.
  -  It's user-local so we don't need sudo to install.
  -  It's a standard, predictable location for where things go so that developers don't reinvent the wheel.
  -  We know where to look when something breaks.
  -  Packages are much more organized and isolated.
  -  We can experiment and try out new apps without the looming fear of irrepairably screwing up the entire system.
  -  It makes apps much easier to uninstall.
  -  If an app can be installed into a user's home, it often doesn't need to run with root privileges, mitigating system-wide exposure.
  -  It starts us on a path to future filesystem sandboxing through organization (not sacrificing developer freedom).


## Reference

Inspired by the XDG Base Directory Specification
- http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html