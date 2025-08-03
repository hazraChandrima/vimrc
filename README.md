# My minimal vimrc

This is a simple and minimal vim configuration that I use often.
Honestly, I don't know why I made this. No one's gonna read this... just like my DMs.

Anyways, I'll be switching to NeoVim very soon, so I just wanted to start with Vim first.

And most importantly, this is for Linux users (works on macOS too), cuz anyone using Windows must be happy with their VSCode extensions.

## What does it look like??

![oopsie! it broke :\\](preview.png)

## Low-key features this vimrc offers
- Gruvbox colorscheme with a dark background
- ALE for asynchronous linting
- NERDTree for file navigation
- Custom status line with Git branch display
- Convenient key mappings for faster editing
- fzf for fuzzy file and text search
- Python script execution with the F5 key

## If you consider trying it out

### Just make sure you have

* Git (for plugin installation and Git branch detection in the status line)
* Python3 (for running scripts with F5)
* curl (for downloading vim-plug)
* fzf (for fuzzy finding)

### 1. Install vim-plug

It uses [vim-plug](https://github.com/junegunn/vim-plug) for plugin management.

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### 2. Clone this repo

```bash
git clone --depth=1  https://github.com/hazraChandrima/vimmy.git
cd vimmy/
```

### 3. Backup your old `.vimrc` (if you have a superior vimrc)

```bash
mv ~/.vimrc ~/.vimrc.backup
```

### 4. Copy the files to your home directory

```bash
cp .vimrc ~/
mkdir -p ~/.vim/colors
cp .vim/colors/gruvbox.vim ~/.vim/colors/
```

Or you can just symlink them:

```bash
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.vim/colors ~/.vim/colors
```

### 5. Install plugins

Open Vim and run:

```vim
:PlugInstall
```

That's all it takes...

You can add more color schemes by placing them in .vim/colors/

## Key Mappings (you may change 'em if you want)

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
| `Ctrl+p`          | Open fzf and fuzzy search files in the current directory  |


## If something goes wrong

It would be a shame. But the good news is, you're smart enough to fix it.
