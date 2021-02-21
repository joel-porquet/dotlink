# dotlink

## Introduction

`dotlink` is a simple dotfile manager.

Imagine you keep all your configuration in `~/etc`:

```
$ tree ~/etc
/home/user/etc
├── git
│   ├── dotlink.conf
│   ├── gitconfig
│   └── gitignore
├── vim
│   ├── colors
│   │   └── light.vim
│   ├── dotlink.conf
│   ├── gvimrc
│   └── vimrc
└── zsh
    ├── dotlink.conf
    ├── zshenv
    └── zshrc
```

Files `dotlink.conf` specify how the dotfiles should be installed:

```
$ cat etc/git/dotlink.conf
[slink]
gitconfig=~/.gitconfig
gitignore=~/.gitignore
```

Here, git's dotfiles should be installed as *symbolic links* to the specified
paths.

`dotlink` performs their install with a simple command:

```
$ dotlink install etc/git
```

You can confirm that the files were properly installed. Either manually:

```
$ ls -l ~/.git*
lrwxrwxrwx 1 user users 28 1970-01-01 00:00 /home/user/.gitconfig -> /home/user/etc/git/gitconfig
lrwxrwxrwx 1 user users 28 1970-01-01 00:00 /home/user/.gitignore -> /home/user/etc/git/gitignore
```

Or better, via `dotlink` itself:

```
$ dotlink status etc/git
[slink]: 'etc/git/gitconfig' => '~/.gitconfig'
[slink]: 'etc/git/gitignore' => '~/.gitignore'
```

## Install

### Local

`dotlink` is a simple bash script. If you want, you can simply download it and 
drop it into your dotfiles folder. This way it'll always be there wherever your 
dotfiles are.

### System-wide

#### Git

```
$ git clone
$ cd dotlink
$ sudo make install
```

#### Archlinux

A package is available in AUR:
<https://aur.archlinux.org/packages/dotlink-git/>. Use your favorite AUR
installer, such as [yay](https://github.com/Jguer/yay):

```
$ yay -S dotlink-git
```

## Usage

### `dotlink.conf` format

`dotlink.conf` files loosely follow the [INI file
format](https://en.wikipedia.org/wiki/INI_file), using sections under which keys
are associated to values.

```
[section_a]
key_a=value_a

[section_b]
key_b=value_b
```

A key is the target file (or directory) located in your dotfile folder, while a
value is the destination's path to which the target should be installed.

A target file should be expressed as a *relative path* from where the
`dotlink.conf` file is located. The destination should be expressed as an
*absolute path*.

The section above key/value pairs specifies how the targets should be installed.
There are four type of section:

- `slink`: install targets as a symbolic link
- `hlink`: install targets as a hard link
- `copy`: install targets as a copy
- `ignore`: do not install the targets (and don't complain about it)

### `dotlink` program

```
$ dotlink -h
Usage: dotlink [options] <command> <targets>...

Options:
   -h/-?/--help    Display this help message
   -v/--verbose    Verbose mode
   -n/--dryrun     Dryrun mode

Command:
   install         Install <targets>
   uninstall       Uninstall <targets>
   status          Get status about <targets>
```

## Credit and license

`dotlink` was written by Joël Porquet-Lupine and is licensed under the
[GPLv2](http://www.gnu.org/licenses/gpl-2.0.html)+.

For many parts of this work, I found inspiration in
[pass](https://git.zx2c4.com/password-store), the famous password manager
written by the great Jason Donenfeld.
