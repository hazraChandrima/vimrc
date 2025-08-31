#!/usr/bin/env bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

header() {
    echo -e "${CYAN}$1${NC}"
}


select_colorscheme() {
    echo
    header "Choose Your Colorscheme"
    echo
    echo -e "${MAGENTA}Available colorschemes:${NC}"
    echo "  1) tender   - A clean theme (my personal fav)"
    echo "  2) gruvbox  - A retro groove color scheme"
    echo "  3) default  - Vim's default"
    echo
    
    while true; do
        echo -ne "${CYAN}Enter your choice (1-3): ${NC}"
        read -r choice
        
        case $choice in
            1)
                SELECTED_COLORSCHEME="tender"
                break
                ;;
            2)
                SELECTED_COLORSCHEME="gruvbox"
                break
                ;;
            3)
                SELECTED_COLORSCHEME="default"
                break
                ;;
            *)
                error "Please enter 1, 2, or 3."
                ;;
        esac
    done
    success "Selected colorscheme: $SELECTED_COLORSCHEME"
}


install_nerd_font() {
    header "Installing FiraCode Nerd Font..."
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    curl -fLo "FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
    unzip -o FiraCode.zip
    rm FiraCode.zip
    fc-cache -fv
    success "Installed FiraCode Nerd Font cuz u don't seem to have one :/"
}


check_dependencies() {
    if ! command -v git >/dev/null 2>&1 || ! command -v python3 >/dev/null 2>&1 || ! command -v vim >/dev/null 2>&1 || ! command -v fzf >/dev/null 2>&1; then
        warning "Ensure you have these installed in your system :"
        echo -e "${YELLOW}- python3"
        echo -e "- vim"
        echo -e "- fzf${NC}"
        echo
        header "If any of these are missing, install them manually and rerun this script."
        exit 0
    fi
}



if [ "$EUID" -eq 0 ]; then
    error "Please don't run this script as root"
    exit 1
fi

# this looks crappy tho...may remove it later
echo
header "╔══════════════════════════════════════╗"
header "║       Vim Configuration Setup        ║"
header "╚══════════════════════════════════════╝"
echo

if fc-list | grep -qi "Nerd Font"; then
    success "tis good that you have a Nerd Font"
else
    install_nerd_font
fi

check_dependencies
select_colorscheme
echo

if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.backup
    success "Backup created: ~/.vimrc.backup"
fi

if [ -d ~/.vim ]; then
    mv ~/.vim ~/.vim.backup
    success "Backup created: ~/.vim.backup"
fi

cp .vimrc ~/
if [ -d .vim ]; then
    cp -r .vim/ ~/
fi

sed -i "s/^colorscheme .*/colorscheme $SELECTED_COLORSCHEME      \" Selected during installation/" ~/.vimrc
sed -i "/if has('gui_running')/,/endif/ s/colorscheme .*/    colorscheme $SELECTED_COLORSCHEME/" ~/.vimrc
sed -i "s/'colorscheme': '[^']*'/'colorscheme': '$SELECTED_COLORSCHEME'/" ~/.vimrc
success "Colorscheme updated successfully in ~/.vimrc"

vim +PlugInstall +qall
success "Vim plugins installed successfully"
success "Setup Completed."
