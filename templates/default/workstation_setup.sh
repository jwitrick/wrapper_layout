# Aliases and commands

export EDITOR='vim'
function gitbranch() { git branch $@ ; git checkout $@ ; }

alias gittag='git branch -D temp; git branch temp; git checkout temp; git fetch --tags; git tag'
alias gitmaster='git checkout master; git branch -D temp'

if [[ ! -d $HOME/.chefdk ]]; then
  `/opt/chefdk/embedded/bin/gem install nokogiri -- --use-system-libraries=true --with-xml2-include=/usr/include/libxml2`
fi

# Set chefdk forChange the default formatting of the history in bash
eval "$(chef shell-init bash)"
