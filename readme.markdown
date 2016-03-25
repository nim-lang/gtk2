
# Installation

You can install this wrapper using the [Nimble](https://github.com/nimrod-code/nimble) package manager.

```bash
nimble install gtk2 # To install latest tagged version from git, if one exists.
nimble install gtk2#head # To install GIT HEAD.
```

# Use this wrapper as part of your nimble package

If you wish to add this wrapper as a dependency to your nimble package then add the following to your .nimble file.

```ini
[Deps]
Requires = "gtk2#head"
```

# Notes

## OSX

As of version 1.1 this binding will use [GTK-Quartz][1] if it is available,
otherwise it will fallback to the X11 version of GTK.

 [1]: https://wiki.gnome.org/action/show/Projects/GTK+/OSX
