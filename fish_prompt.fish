

################################################################################
# setup pathes
set PATH "/home/fransua/.miniconda2/bin" $PATH
eval "register-python-argcomplete conda" > /dev/null

set PYTHONPATH $PYTHONPATH "/home/fransua/Tools/IMP20/lib"
set PYTHONPATH $PYTHONPATH "/home/fransua//Tools/mirnylib"
set PYTHONPATH $PYTHONPATH "/home/fransua/Tools/hiclib/src"

# for elpy
set HDF5_DISABLE_VERSION_CHECK 2

set PERL5LIB "/home/fransua/Tools/biomart-perl/lib/"
set PERL5LIB $PERL5LIB "/home/fransua/Tools/Perl/bioperl-1.2.3/"
set PERL5LIB $PERL5LIB "/home/fransua/Tools/Perl/ensembl/modules/"
set PERL5LIB $PERL5LIB "/home/fransua/Tools/Perl/ensembl-compara/modules/"

################################################################################
# shortcuts
alias ssh "ssh -X"
alias grep "grep --color"
alias rm "rm -i" 
alias mv "mv -i" 
alias cp "cp -i" 

set fish_greeting '
 :P
'

################################################################################
# welcome message
# if [ ( math (random) "% 2") -eq 1 ]
# 	set fish_greeting (fortune | cowthink -f obe)
# else
# 	set fish_greeting (fortune | cowsay -f (ls /usr/share/cowsay/cows -1 | sed 's/\.cow//' | cat -n | grep -P " "(math (random) " % 53 + 1")"\t" | sed 's/ \+[0-9]\+\t//'))
# end

################################################################################
# load fish_timer
source ~/.config/fish/functions/fish_command_timer.fish
set fish_command_timer_color yellow

################################################################################
# check if connected through ssh, and store it as color
if [ -z "$SSH_CLIENT" ]
    set machine_color green
else
    set machine_color cyan
end


function fish_prompt
    and set retc $machine_color; or set retc red # check status of previous jobs and store it as color

    ############################################################################
    # setup fish_git
    
    # define theme for git prompt
    if not set -q __fish_git_prompt_show_informative_status
    	set -g __fish_git_prompt_show_informative_status 1
    end
    if not set -q __fish_git_prompt_hide_untrackedfiles
    	set -g __fish_git_prompt_hide_untrackedfiles 1
    end
    
    if not set -q __fish_git_prompt_color_branch
    	set -g __fish_git_prompt_color_branch red
    end
    if not set -q __fish_git_prompt_showupstream
    	set -g __fish_git_prompt_showupstream "informative"
    end
    if not set -q __fish_git_prompt_char_upstream_ahead
    	set -g __fish_git_prompt_char_upstream_ahead "↑"
    end
    if not set -q __fish_git_prompt_char_upstream_behind
    	set -g __fish_git_prompt_char_upstream_behind "↓"
    end
    if not set -q __fish_git_prompt_char_upstream_prefix
    	set -g __fish_git_prompt_char_upstream_prefix ""
    end

    if not set -q __fish_git_prompt_char_upstream_ahead
    	set -g __fish_git_prompt_char_stateseparator ""
    end
    
    if not set -q __fish_git_prompt_char_stagedstate
    	set -g __fish_git_prompt_char_stagedstate "●"
    end
    # changes to commit
    if not set -q __fish_git_prompt_char_dirtystate
    	set -g __fish_git_prompt_char_dirtystate "✚"
    end
    # untracked files
    if not set -q __fish_git_prompt_char_untrackedfiles
    	set -g __fish_git_prompt_char_untrackedfiles "…"
    end
    # conflict
    if not set -q __fish_git_prompt_char_conflictedstate
    	set -g __fish_git_prompt_char_conflictedstate "✖"
    end
    # up to date
    if not set -q __fish_git_prompt_char_cleanstate
    	set -g __fish_git_prompt_char_cleanstate "✔"
    end
    
    if not set -q __fish_git_prompt_color_dirtystate
    	set -g __fish_git_prompt_color_dirtystate white
    end
    if not set -q __fish_git_prompt_color_stagedstate
    	set -g __fish_git_prompt_color_stagedstate yellow
    end
    if not set -q __fish_git_prompt_color_invalidstate
    	set -g __fish_git_prompt_color_invalidstate red
    end
    if not set -q __fish_git_prompt_color_untrackedfiles
    	set -g __fish_git_prompt_color_untrackedfiles brown
    end
    if not set -q __fish_git_prompt_color_cleanstate
    	set -g __fish_git_prompt_color_cleanstate green
    end

    ############################################################################
    # Prompt built
    
    # HOST
    set_color $retc
    echo -n (hostname)
    set_color normal

    # PWD
    set_color -o blue
    # echo -n :(pwd|sed "s=$HOME=~=")
    echo -n " "(prompt_pwd)/
    set_color normal

    # JOBS
    if [ (count (jobs)) -gt 0 ]
        set_color red
        echo -n " "[(count (jobs))]
        set_color normal
    end

    # GIT
    echo -n (__fish_git_prompt)
    set_color normal
    
    if [ (whoami) = "root" ]
	    set_color -o red
	    echo -n ' # '
    else
	    echo -n '$ '
    end

    ###########################################################################
    # notify if command took lot of time
    if [ -z $CMD_DURATION ]
	    set CMD_DURATION 0
    end
    
    if [ $CMD_DURATION -gt 10000 ]
	    if [ $retc = "green" ]
		    # notify-send -i face-cool -t 15000 "$history[1]" "Time $CMD_DURATION_STR"
		    notify-send -i emblem-default -t 15000 "$history[1]" "Time $CMD_DURATION_STR"
		    # notify-send -i weather-clear -t 15000 "$history[1]" "Time $CMD_DURATION_STR"
	    else
		    # notify-send -i face-cool -t 15000 "$history[1]" "Time $CMD_DURATION_STR"
		    notify-send -i emblem-important -t 15000 "$history[1]" "Time $CMD_DURATION_STR"
		    # notify-send -i weather-storm -t 15000 "$history[1]" "Time $CMD_DURATION_STR"
	    end
    end
    
    set_color normal
end
