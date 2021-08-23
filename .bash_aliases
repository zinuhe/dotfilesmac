# ----------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------

alias cls=clear          # Clear your terminal screen
alias lsld="ls -ld */"   # List all directories in current directory in long list format

lsl() {
    cls
    ls -l -G           # list all files starting with parameter input %1
}

alias lsla="ls -la -G"   # List all files in current directory
lss() {
    ls -ld $1*           # list all files starting with parameter input %1
}

# ----------------------------------------------------------------------
# Routes
# Repos route
cdr() {
    cd ~/Documents/DEV/"$1"
}

alias cathosts="cat /etc/hosts"
alias vihosts="sudo vi /etc/hosts" 

# ----------------------------------------------------------------------
# Golang
alias cdrgo="cd ~/Documents/DEV/Go/goworkspace/src/github.com/zinuhe/"

grun() {
    go run $(find . -name '*.go' -and -not -name '*_test.go' -maxdepth 1)
}

gtest() {
    echo "${YELLOW}go test ./... -cover -v${NOCOLOR}"
    go test ./... -cover -v
}

gtest2() {
    echo "${YELLOW}go test -cover -v${NOCOLOR}"
    go test -cover -v "$@"
}

gtest3() {
    echo "${YELLOW}go test $1*.go -cover -v${NOCOLOR}"
    go test $1*.go -cover -v "$@"
}

# ----------------------------------------------------------------------
# Docker

#docker-compose ps --service

alias d-c="docker-compose"

d-cdown() {
    echo "${YELLOW}docker-compose down${NOCOLOR}"
    docker-compose down
}

d-cup() {
    echo "${YELLOW}docker-compose up -d${NOCOLOR}"
    docker-compose up -d
}

d() {
    docker $1 $2 $3 $4 $5
}

# ----------------------------------------------------------------------
# GIT

#git branch --show-current

gb() {
    cls
    echo "${YELLOW}git branch${NOCOLOR}"
    git branch "$@"
}
gbranch() {
    gb
}

gco() {
    echo "${YELLOW}git checkout${NOCOLOR}"
    git checkout
}
gcheckout() {
    gco
}

#list the commits waiting to be pushed
gcherry() {
    echo "${YELLOW}git cherry -v${NOCOLOR}"
    git cherry -v
}

gc() {
    echo "${YELLOW}git commit${NOCOLOR}"
    git commit
}
gcommit() {
    gc
}

#git diff --stat --cached origin/branchname
#It shows commited files with differences.

gdiff() {
    echo "${YELLOW}git diff --stat --cached origin/`git branch --show-current`${NOCOLOR}"
    git diff --stat --cached origin/`git branch --show-current`
}


#gf="git fetch"
#alias gf="echo $gf && $gf"
#alias gfetch="git fetch"

gf() {
    cls
    echo "${YELLOW}git fetch${NOCOLOR}"
    git fetch
}
gfetch() {
    gf
}


gl() {
    cls
    echo "${YELLOW}git log --oneline${NOCOLOR}"
    git log --oneline
}
glog() {
    gl
}

gp() {
    echo "${YELLOW}git pull${NOCOLOR}"
    git pull
}
gpull() {
    gp
}

gpush() {
    echo "${YELLOW}git push${NOCOLOR}"
    git push
}

#git show commit_id --name-only

gs() {
    cls
    echo "${YELLOW}git status${NOCOLOR}"
    git status
}
gstatus() {
    gs
}

gss() {
    echo "${YELLOW}git submodule status${NOCOLOR}"
    git submodule status
}


alias gpa="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;"

gsgb() {
    echo "${YELLOW}git submodule foreach 'git branch'${NOCOLOR}"
    git submodule foreach 'git branch'
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

# source $HOME/.zshrc
alias sc="source ~/.zshrc"

# ----------------------------------------------------------------------
# Testing zone

#alias abc="find . -type d -depth 1 -exec echo ls -la;"
#find . -type d -depth 1 -exec echo git --git-dir={}/.git --work-tree=$PWD/{} status \;

