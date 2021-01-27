Features
========

* Autostart application
* Auto change wallpaper in `$XDG_PITURES_DIR/Wallpaper`
* 2 panels (top, bottom), avoid glitzy when use
* Redshift support
* Colorful powerline panel

Installation
=============

You must install:
* [xdg-user-dirs](https://www.freedesktop.org/wiki/Software/xdg-user-dirs/): some Linux distros already install this package
* [Moka icon theme](https://github.com/snwh/moka-icon-theme)
* [Terminus font](http://terminus-font.sourceforge.net): some Linux distros already have this font
* [Monofur Nerd font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Monofur)
* [Redshift](http://jonls.dk/redshift/)

Clone this repository to ~/.config/awesome
```
rm -rf ~/.config/awesome
git clone https://gitlab.com/dynamo-config/awesome ~/.config/awesome
git submodule update --init --remote
```
and create `Wallpaper` folder in your `Pictures` user folder
```
mkdir -p $(xdg-user-dir PICTURES)/Wallpaper
```

License
========

Copyright © 2019 Tran Duc Nam <dynamo.foss@gmail.com>

The project is licensed under Creative Common BY-NC-SA 4.0.
You can read it online at [here](http://creativecommons.org/licenses/by-nc-sa/4.0/).

Note
=====

My configuration is implementing, not recommended for use right now
