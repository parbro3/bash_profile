#************************************************** bash ********************************************************
alias rc="vim ~/.bash_profile"
alias src="source ~/.bash_profile"
alias google="ping 8.8.8.8"

#**************************************************git commands********************************************************
alias t="git log --graph --oneline --all --author-date-order"
alias b="git branch -l --column"
alias s="git status"
alias gs="git stage "
alias gc="git commit -m "
alias last="git show --stat --oneline HEAD"
alias changes="git diff --name-only master"

#********************************************** SFDX Commands ********************************************************

sfdxorg () { sfdx force:config:set defaultusername=$1; }

#*********************************************************************************************************************

pingAll () {
    x=0
    while [ $x -lt 255 ]; do
    ping -c 1 10.1.10.$x &
    x=$(expr $x + 1)
    done
    # Wait a few seconds for the pings above to finish
    arp -a
}

#activates git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#Overrides method in git completion for local branches only.
 _git_checkout ()
 {
     __git_has_doubledash && return
 
     case "$cur" in
     --conflict=*)
         __gitcomp "diff3 merge" "" "${cur##--conflict=}"
         ;;
     --*)
         __gitcomp_builtin checkout
         ;;
     *)
         # check if --track, --no-track, or --no-guess was specified
         # if so, disable DWIM mode
         local flags="--track --no-track --no-guess" track_opt="--track"
         if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
            [ -n "$(__git_find_on_cmdline "$flags")" ]; then
             track_opt=''
         fi
        
         #top command is for all branches. bottom command is for local branches
         #__git_complete_refs $track_opt
         __gitcomp_direct "$(__git_heads "" "$cur" " ")"

         ;;
     esac
 }



#**************************************************Navigation**********************************************************
alias .1='cd ../ && ls'                     # Go back 3 directory levels
alias .2='cd ../../ && ls'                     # Go back 3 directory levels
alias .3='cd ../../../ && ls'                     # Go back 3 directory levels
alias .4='cd ../../../../ && ls'                  # Go back 4 directory levels
alias .5='cd ../../../../../ && ls'               # Go back 5 directory levels
alias .6='cd ../../../../../../ && ls'            # Go back 6 directory levels

#Opens any file in MacOS Quicklook Preview
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           

alias c='src; clear'

#*************************************************Random commands******************************************************
#open a finder in the current directory
alias f='open -a Finder ./'

#show your bash history
alias h="history"
alias ll="ls -l"
alias la="ls -a"

cs() {
    cd $1 && ls 
}

#*************************************************Prompt Displays******************************************************

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


# declares an array with the emojis we want to support
EMOJIS=(🚀)

# selects a random element from the EMOJIS set
SELECTED_EMOJI=${EMOJIS[$RANDOM % ${#EMOJIS[@]}]};

# declare the terminal prompt format
#export PS1='${SELECTED_EMOJI}  [\u@\h \W]$ '

#simple ps
#export PS1="\w @ \h(\u): "

#username@domain $ repo (branch)
#export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

#username@dns:directory (branch)
# L $ >
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$(parse_git_branch)\n\[\033[36m\]└─ \[\033[36m\]\$\[\033[36m\] ▶\[\033[0m\] "

#username@dns:directory (branch)
# -->
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[35m\]\$(parse_git_branch)\n\[\033[36m\]└───\[\033[36m\]▶\[\033[0m\] ${SELECTED_EMOJI}"

#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[35m\]\$(parse_git_branch)\n\[\033[36m\]└───\[\033[36m\]▶\[\033[0m\] "

#PS1='$(printf "%*s\r%s" $(( COLUMNS-1 )) "[$(git branch 2>/dev/null | grep '^*' | sed s/..//)] $(date +%H:%M:%S)" "\u@\h:$PWD$ ")'

branchColor=$(tput bold; tput setaf 4; tput setab 7)
dateColor=$(tput bold; tput setaf 125; tput setab 7)

columns=$(expr $COLUMNS + 34)

rightprompt()
{
    printf "%*s" $columns "${branchColor}$(parse_git_branch) ${dateColor}$(date +"%T ")"
}

PS1='\[$(tput sc; rightprompt; tput rc)\]\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\n\[\033[36m\]└───\[\033[36m\]▶\[\033[0m\] '


#switch yellow and green from above
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[33m\]\h:\[\033[32;1m\]\w\[\033[35m\]\$(parse_git_branch)\n\[\033[36m\]└───\[\033[36m\]▶\[\033[0m\] "

#same as above but different colors
#export PS1="\[\033[33m\]\u\[\033[m\]@\[\033[36m\]\h:\[\033[35;1m\]\w\[\033[32m\]\$(parse_git_branch)\n\[\033[33m\]└───\[\033[33m\]▶\[\033[0m\] "

#same as above but with new line to start
#export PS1="\n\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[35m\]\$(parse_git_branch)\n\[\033[36m\]└───\[\033[36m\]▶\[\033[0m\] "

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'


#*************************************************Networking******************************************************
alias ports='sudo lsof -i | grep LISTEN'
alias cpu='top -u'
alias mem='top -o MEM'
alias devices='arp -a'
alias root='sudo su'
alias touchbar='sudo pkill TouchBarServer'
