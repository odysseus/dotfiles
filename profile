export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# PATH
PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/bin


HOMEBREW_GITHUB_API_TOKEN="cb44c6e3948e7c05eedfbc81fe534ad2c33830fc"

alias gs='git status'
alias gaa='git add -A :/'
alias gcam='git add -A :/ && git commit -am'

alias vimprofile="vim ~/.profile"
alias reprofile="source ~/.profile"

export GOPATH="/Users/ryan/Copy/code/go"
export GOBIN="/Users/ryan/Copy/code/go/bin"

# PyEnv
eval "$(pyenv init -)"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/ryan/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/Users/ryan/google-cloud-sdk/completion.bash.inc'

alias goapp=~/google-cloud-sdk/platform/google_appengine/goapp

