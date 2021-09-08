# colors for ls, etc.
alias d="ls -F"
alias ls="ls -F"
alias ll="ls -F -l"
alias dc="cd"

umask 022

export EDITOR=vim
export PATH=~/build/depot_tools:/usr/local/bin:/usr/games/:~/build/android-sdk-linux_86/tools:$PATH

chpwd() {
	#[[ -t 1 ]] | return
	case $TERM in
		xterm*|rxvt|Eterm|eterm)
			print -Pn "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"
	                ;;
	        screen)
	                print -Pn "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"
	                ;;
	esac
}

git_prompt() {
  ref=$(git symbolic-ref HEAD 2>/dev/null | awk -F '/' '{print $NF}')
  echo $ref
}

# initially set the title
chpwd

export HISTSIZE=2000
export HISTFILE=~/.history
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"


# autocompletion
autoload -U compinit promptinit
compinit

# prompt
promptinit

fortune -s

setopt prompt_subst
export PROMPT='${PR_GREEN}%n ${PR_MAGENTA}[$(git_prompt)] ${PR_RED}%~${PR_NO_COLOR} %# '
export RPROMPT='${PR_RED}[${PR_BLUE}%*${PR_RED}]${PR_NO_COLOR}'

[ "$COLORTERM" = "gnome-terminal" ] && export TERM="xterm-256color"

alias appcfg="~/build/google_appengine/appcfg.py"
alias dev_appserver="~/build/google_appengine/dev_appserver.py"

setopt NO_BEEP

export CK_GITHUB_USERNAME=hatstand
export AWS_REGION=eu-west-1
export AWS_ACCESS_KEY_ID=AKIAR7QC2RSUGQAPZNIY

export PATH=$PATH:/usr/local/go/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$HOME/bin:$HOME/code/ck/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/john/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/john/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/john/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/john/google-cloud-sdk/completion.zsh.inc'; fi

export GOPRIVATE='github.com/creditkudos/*'


alias lint="git diff -z --name-only --diff-filter=ACMR origin/master | xargs -0 ./bin/bundle exec rubocop -a --color"
