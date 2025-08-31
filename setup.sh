#!/usr/bin/env bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

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



dependencies() {
    if ! command -v git >/dev/null 2>&1 || ! command -v python >/dev/null 2>&1 || ! command -v vim >/dev/null 2>&1 || ! command -v fzf >/dev/null 2>&1; then
        print_warning "Ensure you have these installed in your system :"
        echo "${YELLOW}- git"
        echo "- python"
        echo "- vim"
        echo "- fzf${NC}"
        echo
        print_header "If any of these are missing, install them manually and rerun this script."
        exit 0
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
    
    dependencies
    select_colorscheme
    echo
    
    backup_existing_config
    setup_vim_config
    update_colorscheme ~/.vimrc "$SELECTED_COLORSCHEME" "$LIGHTLINE_COLORSCHEME"
    install_plugins

    print_success "Setup Completed."
    echo
}

main
