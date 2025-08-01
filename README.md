# My stupid Vim Configuration

This repository contains my personal Vim configuration with plugins and custom mappings to enhance productivity. It uses [vim-plug](https://github.com/junegunn/vim-plug) for plugin management.

## some ass Features
- Gruvbox colorscheme with a dark background
- ALE for asynchronous linting
- NERDTree for file navigation
- Custom status line with Git branch display
- Useful key mappings for faster editing
- Python script execution with the F5 key
- Optimized settings for better editing experience

## Installation

### 1. Install vim-plug
Run the following command to install vim-plug:
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
````

### 2. Clone this repository

```bash
git clone https://github.com/hazraChandrima/vimmy.git
```

### 3. Backup your old `.vimrc` (optional)

```bash
mv ~/.vimrc ~/.vimrc.backup
```

### 4. Symlink the provided vimrc

```bash
ln -s ~/vimmy/.vimrc ~/.vimrc
```

### 5. Install plugins

Open Vim and run:

```vim
:PlugInstall
```

## Dependencies

* Git (for plugin installation and Git branch detection in the status line)
* Python3 (for running scripts with F5)
* curl (for downloading vim-plug)
* Gruvbox and Molokai themes (installed automatically by vim-plug)

## Key Mappings

| Mapping           | Action                                                    |
| ----------------- | --------------------------------------------------------- |
| `jj`              | Exit insert mode                                          |
| `<leader>\`       | Jump back to the last cursor position                     |
| `<leader>p`       | Print current file to default printer                     |
| `<space>`         | Acts as `:` in command mode                               |
| `o` / `O`         | Open a new line below/above and return to normal mode     |
| `n` / `N`         | Move to next/previous search result and center the cursor |
| `Y`               | Yank from cursor to the end of the line                   |
| `<F5>`            | Save and run current Python file                          |
| `<F3>`            | Toggle NERDTree                                           |
| `Ctrl+j/k/h/l`    | Navigate between split windows                            |
| `Ctrl+Arrow Keys` | Resize split windows                                      |


## How It Works

* Plugins are managed via vim-plug and installed into `~/.vim/plugged`.
* Colorscheme is set to Gruvbox (dark mode) by default.
* The configuration supports GUI Vim (GVim) with custom settings.
