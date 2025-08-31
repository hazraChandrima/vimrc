#!/usr/bin/env bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${CYAN}$1${NC}"
}



select_colorscheme() {
    echo
    print_header "Choose Your Colorscheme"
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
                LIGHTLINE_COLORSCHEME="tender"
                break
                ;;
            2)
                SELECTED_COLORSCHEME="gruvbox"
                LIGHTLINE_COLORSCHEME="gruvbox"
                break
                ;;
            3)
                SELECTED_COLORSCHEME="default"
                LIGHTLINE_COLORSCHEME="default"
                break
                ;;
            *)
                print_error "Please enter 1, 2, or 3."
                ;;
        esac
    done
    print_success "Selected colorscheme: $SELECTED_COLORSCHEME"
}



update_colorscheme() {
    local vimrc_file="$1"
    local colorscheme="$2"
    local lightline_colorscheme="$3"
    
    sed -i "s/^colorscheme .*/colorscheme $colorscheme       \" Selected during installation/" "$vimrc_file"
    
    sed -i "/if has('gui_running')/,/endif/ s/colorscheme .*/    colorscheme $colorscheme/" "$vimrc_file"
    
    sed -i "s/'colorscheme': '[^']*'/'colorscheme': '$lightline_colorscheme'/" "$vimrc_file"
    
    print_success "Colorscheme updated successfully in $vimrc_file"
}



install_dependencies() {
    print_status "Installing dependencies..."
    
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y git python3 vim-gtk3
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y git python3 gvim
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm git python gvim
    elif command -v zypper &> /dev/null; then
        sudo zypper install -y git python3 gvim
    else
        print_warning "Could not detect package manager. Stop being lazy and install git, python3, gvim, and fzf manually."
        return 1
    fi
    
    # fzf is really helpful...
    if ! command -v fzf &> /dev/null; then
        print_status "Installing fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
        print_success "fzf installed successfully"
    else
        print_success "fzf is already installed"
    fi
}


backup_existing_config() {
    if [ -f ~/.vimrc ]; then
        mv ~/.vimrc ~/.vimrc.backup
        print_success "Backup created: ~/.vimrc.backup"
    fi
    
    if [ -d ~/.vim ]; then
        mv ~/.vim ~/.vim.backup
        print_success "Backup created: ~/.vim.backup"
    fi
}


setup_vim_config() {
    cp .vimrc ~/
    if [ -d .vim ]; then
        cp -r .vim/ ~/
    fi
}


install_vim_plug() {
    if [ ! -f ~/.vim/autoload/plug.vim ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        print_success "vim-plug installed successfully"
    else
        print_success "vim-plug is already installed"
    fi
}


install_plugins() {
    vim +PlugInstall +qall
    print_success "Vim plugins installed successfully"
}



main() {
    if [ "$EUID" -eq 0 ]; then
        print_error "Please don't run this script as root"
        exit 1
    fi
    
    echo
    print_header "╔══════════════════════════════════════╗"
    print_header "║       Vim Configuration Setup        ║"
    print_header "╚══════════════════════════════════════╝"
    echo
    
    select_colorscheme
    echo
    
    print_status "Starting installation..."
    install_dependencies
    backup_existing_config
    setup_vim_config
    update_colorscheme ~/.vimrc "$SELECTED_COLORSCHEME" "$LIGHTLINE_COLORSCHEME"
    install_vim_plug
    install_colorscheme_plugins "$SELECTED_COLORSCHEME"
    install_plugins

    print_success "Setup Completed."
    echo
}
