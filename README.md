# Andrew Wright's Dotfiles/Nix Config

I use [nix]() and [home manager]() to manage my applications and dotfiles.

I use `zsh` as my main shell, customized using `oh-my-zsh`.

TODO update screenshot
![Terminal.app](https://raw.github.com/nicksp/dotfiles/master/iterm/nick-terminal.png)

## Acknowledgements

### Config
- My original dotfiles (pre nix) were based on [Nick Plekhanov's Dotfiles](https://github.com/nicksp/dotfiles)

### Scripts
- Brightness script based on the script by Jon Gjengset: https://github.com/jonhoo/configs/blob/master/bins/bin/adjust-brightness 

### Themes

- [agnoster - ZSH Theme](https://github.com/agnoster/agnoster-zsh-theme)

### TODO
The following are repos/articles I want to look at which I might use ideas from:

- https://github.com/disassembler/network
- https://hugoreeves.com/posts/2019/nix-home

- [𝝺 Pure - ZSH Theme](https://github.com/marszall87/lambda-pure)
- [Spaceship prompt - ZSH Theme](https://github.com/denysdovhan/spaceship-prompt)
- [Classy Touch - ZSH Theme](https://github.com/yarisgutierrez/classyTouch_oh-my-zsh)
- [Typewritten - ZSH Theme](https://github.com/reobin/typewritten)

## Features

- Handy [binary scripts](bin/)

## Installation

TODO

## Customize

### Local Settings

The dotfiles can be easily extended to suit additional local requirements by using the following files:

#### `~/.zsh.local`

If the `~/.zsh.local` file exists, it will be automatically sourced. 

#### `~/.gitconfig.local`

TODO update

If the `~/.gitconfig.local` file exists, it will be automatically
included after the configurations from [`~/.gitconfig`](git/gitconfig), thus, allowing
its content to overwrite or add to the existing `git` configurations.

**Note:** Use `~/.gitconfig.local` to store sensitive information such
as the `git` user credentials, e.g.:

```sh
[user]
  name = Nick Plekhanov
  email = nick@example.com
```
