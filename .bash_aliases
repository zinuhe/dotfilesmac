# ----------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------

alias cls=clear          # Clear your terminal screen

alias lsl="ls -l -G"     # List all files in current directory
alias lsla="ls -la -G"   # List all files and directories (color) in current directory
alias lsd="ls -ld */"    # List all directories in current directory in long list format

lss() {
    ls -ld -G $1*        # list all files starting with parameter input %1
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
alias gclean="go clean"
#Delete $GOPATH/bin and the executable in the directory if you used go build.
gocache() {
    go clean
    rm -r ~/$GOPATH/bin/*
    rm -r ~/$GOPATH/go/bin/*
}

#alias grun="go run $(find . -name '*.go' -and -not -name '*_test.go' -maxdepth 1)"
alias grun="go run"

# To run golangci-lint
glint() {
    echo "${YELLOW}golangci-lint run${NOCOLOR}"
    golangci-lint run
}

# To run helm linter
ghelm() {
    echo "${YELLOW}helm lint .${NOCOLOR}"
    helm lint .
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

gb() {
    cls
    echo "${YELLOW}git branch${NOCOLOR}"
    git branch
}
gbranch() {
    gb
}

#list both local and remote branches
gba() {
    cls
    echo "${YELLOW}git branch -a${NOCOLOR}"
    git branch -a
}
gbrancha() {
    gba
}

#list only remote branches
gbr() {
    cls
    echo "${YELLOW}git branch -r${NOCOLOR}"
    git branch -r
}
gbranchr() {
    gbr
}

gco() {
    echo "${YELLOW}git checkout $1${NOCOLOR}"
    git checkout $1
}
gcheckout() {
    gco $1
}

#list the commits waiting to be pushed
gcherry() {
    echo "${YELLOW}git cherry -v${NOCOLOR}"
    git cherry -v
}

gc() {
    echo "${YELLOW}git commit $1${NOCOLOR}"
    git commit "$@"
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

# forget to create a new branch, and made all your changes in the wrong branch?
# Moves all your changes to your newly created branch.
git switch -c "new_branch"


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
# unalias alias-name

# ----------------------------------------------------------------------
# Testing zone

#alias abc="find . -type d -depth 1 -exec echo ls -la;"
#find . -type d -depth 1 -exec echo git --git-dir={}/.git --work-tree=$PWD/{} status \;
