# ----------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------

alias ..="cd .."
alias cls=clear          # Clear your terminal screen

alias lsl="ls -l -G"     # List all files in current directory
alias lsla="ls -la -G"   # List all files and directories (color) in current directory
alias lsd="ls -ld */"    # List all directories in current directory in long list format

# list all files/directories starting with the given prefix
lss() {
    echo "${YELLOW}ls -ld -G $1*${NOCOLOR}"
    ls -ld -G $1*        # list all files starting with parameter input %1
}

# ----------------------------------------------------------------------
# Routes

# cd into a project folder under ~/Documents/Gameaddik
cdg() {
    cd ~/Documents/Gameaddik/"$1"
}

# cd into a repo folder under ~/Documents/Gameaddik/Repos
cdgr() {
    cd ~/Documents/Gameaddik/Repos/"$1"
}


alias cathosts="cat /etc/hosts"
alias vihosts="sudo vi /etc/hosts" 

# ----------------------------------------------------------------------
# Python


# ----------------------------------------------------------------------
# Docker

#docker compose ps --service

alias d-c="docker compose"

# stop and remove containers from docker-compose
d-cdown() {
    echo "${YELLOW}docker compose down${NOCOLOR}"
    docker compose down
}

# start containers from docker-compose in detached mode
d-cup() {
    echo "${YELLOW}docker compose up -d${NOCOLOR}"
    docker compose up -d
}

# remove unused docker data (stopped containers, dangling images, networks)
d-prune() {
    echo "${YELLOW}docker system prune -f${NOCOLOR}"
    docker system prune -f
}

# list running containers
d-ps() {
    echo "${YELLOW}docker ps${NOCOLOR}"
    docker ps
}

# shortcut for any docker command, e.g. d ps -a
d() {
    echo "${YELLOW}docker $@${NOCOLOR}"
    docker "$@"
}

# ----------------------------------------------------------------------
# GIT

# show working tree status
gs() {
    echo "${YELLOW}git status${NOCOLOR}"
    git status
}
# alias for gs
gstatus() {
    gs
}

# stage files, e.g. ga file1 file2
ga() {
    echo "${YELLOW}git add $@${NOCOLOR}"
    git add "$@"
}

# stage all changes
gaa() {
    echo "${YELLOW}git add -A${NOCOLOR}"
    git add -A
}

# list local branches
gb() {
    cls
    echo "${YELLOW}git branch${NOCOLOR}"
    git branch
}
# alias for gb
gbranch() {
    gb
}

#list both local and remote branches
gba() {
    cls
    echo "${YELLOW}git branch -a${NOCOLOR}"
    git branch -a
}
# alias for gba
gbrancha() {
    gba
}

#list only remote branches
gbr() {
    cls
    echo "${YELLOW}git branch -r${NOCOLOR}"
    git branch -r
}
# alias for gbr
gbranchr() {
    gbr
}

# checkout the given branch
gco() {
    echo "${YELLOW}git checkout $1${NOCOLOR}"
    git checkout "$1"
}
# alias for gco
gcheckout() {
    gco "$1"
}

#list the commits waiting to be pushed
gcherry() {
    echo "${YELLOW}git cherry -v${NOCOLOR}"
    git cherry -v
}

# commit staged changes, e.g. gc -m "message"
gc() {
    echo "${YELLOW}git commit $1${NOCOLOR}"
    git commit "$@"
}
# alias for gc
gcommit() {
    gc "$@"
}

# show unstaged changes
gd() {
    echo "${YELLOW}git diff${NOCOLOR}"
    git diff
}

# show diff stats between staged changes and origin's current branch
gdiff() {
    echo "${YELLOW}git diff --stat --cached origin/`git branch --show-current`${NOCOLOR}"
    git diff --stat --cached origin/`git branch --show-current`
}

#gf="git fetch"
#alias gf="echo $gf && $gf"
#alias gfetch="git fetch"

# fetch changes from remote
gf() {
    cls
    echo "${YELLOW}git fetch${NOCOLOR}"
    git fetch
}
# alias for gf
gfetch() {
    gf
}

# show commit log, one line per commit
gl() {
    cls
    echo "${YELLOW}git log --oneline${NOCOLOR}"
    git log --oneline
}
# alias for gl
glog() {
    gl
}

# show commit log as a graph, with all branches
glol() {
    cls
    echo "${YELLOW}git log --oneline --graph --decorate --all${NOCOLOR}"
    git log --oneline --graph --decorate --all
}

# pull from remote
gp() {
    echo "${YELLOW}git pull${NOCOLOR}"
    git pull
}
# alias for gp
gpull() {
    gp
}

# push to remote
gpush() {
    echo "${YELLOW}git push${NOCOLOR}"
    git push
}

# undo the last commit but keep the changes staged
gundo() {
    echo "${YELLOW}git reset --soft HEAD~1${NOCOLOR}"
    git reset --soft HEAD~1
}


alias gpa="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;"

# list branches inside each git submodule
gsgb() {
    echo "${YELLOW}git submodule foreach 'git branch'${NOCOLOR}"
    git submodule foreach 'git branch'
}

# forget to create a new branch, and made all your changes in the wrong branch?
# Moves all your changes to your newly created branch.
# git switch -c "new_branch"


# ----------------------------------------------------------------------
# Ghostty

# curated palette of eye-friendly colors, usable by name in tabcolor/tabcolors
typeset -a TABCOLOR_NAMES=(
    "blue1" "green1" "red1" "yellow1" "purple1" "orange1" "cyan1" "gray1"
)
typeset -A TABCOLOR_PALETTE=(
    "blue1"   "#2d4159"
    "green1"  "#33513c"
    "red1"    "#5c3535"
    "yellow1" "#5c4d2d"
    "purple1" "#3d3157"
    "orange1" "#5c4433"
    "cyan1"   "#2d5c56"
    "gray1"   "#3b4252"
)
typeset -A TABCOLOR_LABELS=(
    "blue1"   "Azul suave"
    "green1"  "Verde suave"
    "red1"    "Rojo suave"
    "yellow1" "Amarillo mostaza"
    "purple1" "Morado suave"
    "orange1" "Naranja suave"
    "cyan1"   "Cyan suave"
    "gray1"   "Gris azulado"
)

# set the current tab's background color, e.g. tabcolor blue1 or tabcolor "#1e3a5f"
tabcolor() {
    local input="${(L)*}"
    local hex="${TABCOLOR_PALETTE[$input]:-$*}"
    echo -ne "\e]11;$hex\a"
}

# reset the current tab's background color to the config default
tabcolorreset() {
    echo -ne "\e]111\a"
}

# set the current tab's title, e.g. tabtitle "my project"
tabtitle() {
    echo -ne "\e]0;$1\a"
}

# preview the curated palette rendered with its real color: swatch, full name, hex, short name
tabcolors() {
    local name label hex r g b
    for name in "${TABCOLOR_NAMES[@]}"; do
        hex="${TABCOLOR_PALETTE[$name]}"
        label="${TABCOLOR_LABELS[$name]}"
        r=$((16#${hex:1:2}))
        g=$((16#${hex:3:2}))
        b=$((16#${hex:5:2}))
        printf "\e[48;2;%d;%d;%dm    \e[0m  %-18s %-10s %s\n" "$r" "$g" "$b" "$label" "$hex" "$name"
    done
}

# ----------------------------------------------------------------------
# Brew
alias bupd="brew update"
alias bupg="brew upgrade"
alias bo="brew outdated"
alias bl="brew list --version"

# ----------------------------------------------------------------------
# Others
# open ~/.zshrc in using the default editor specified in $EDITOR
alias ec="subl ~/.zshrc"

# source ~/.zshrc
alias sc="source ~/.zshrc"
# unalias alias-name

# list all aliases and functions defined in this file, with descriptions
al() {
    echo "${YELLOW}--- Aliases ---${NOCOLOR}"
    alias
    echo ""
    echo "${YELLOW}--- Functions ---${NOCOLOR}"
    awk '
        /^#[[:space:]]*-+[[:space:]]*$/ { comment=""; next }
        /^#/ {
            c = $0
            sub(/^#[ \t]*/, "", c)
            comment = c
            next
        }
        /^[a-zA-Z_-]+\(\)/ {
            name = $0
            sub(/\(\).*/, "", name)
            if (comment != "") print name " -- " comment
            else print name
            comment = ""
            next
        }
        { comment = "" }
    ' ~/.bash_aliases
}

# ----------------------------------------------------------------------
# Testing zone

#alias abc="find . -type d -depth 1 -exec echo ls -la;"
#find . -type d -depth 1 -exec echo git --git-dir={}/.git --work-tree=$PWD/{} status \;
