version = "1.4"
author = "Nim developers"
description = "Wrapper for gtk2, a feature rich toolkit for creating graphical user interfaces."
license = "MIT"
srcDir = "src"

requires "nim > 0.9.2, cairo"

import std/distros
foreignDep "gtk+"
