
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

If you want to compile against [GTK-Quartz][1], use `-d:gtk_quartz`.
If you don't, the binding will link against the X11 version of GTK. The OpenGL
extension is currently not available for GTK-Quartz.

 [1]: https://wiki.gnome.org/action/show/Projects/GTK+/OSX
