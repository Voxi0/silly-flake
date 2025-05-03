{ lib, config, pkgs, ... }: 
{
    home.file.".bashrc".text = ''
        # Just a slightly modified Ubuntu default `.bashrc` - I got it from here -> https://gist.github.com/marioBonales/1637696
        # Don't do anything if not running interactively
        [ -z "$PS1" ] && return

        # Don't put duplicate lines in history or force `ignoredups` and `ignorespace`
        HISTCONTROL=ignoredups:ignorespace

        # Append to the history file instead of overwriting it
        shopt -s histappend

        # Set history length
        HISTSIZE=1000
        HISTFILESIZE=2000

        # Update `LINES` and `COLUMNS` if necessary after checking the window size after each command
        shopt -s checkwinsize

        # Make less more friendly for non-text input files
        [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

        # Set the variable identifying the chroot you work in (Used in the prompt below)
        if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
            debian_chroot=$(cat /etc/debian_chroot)
        fi

        # Set a fancy prompt - Non-color unless we know we "want" color
        case "$TERM" in
            xterm-color) color_prompt=yes;;
        esac

        # If this is an Xterm set the title to "user@host:dir"
        case "$TERM" in
        xterm*|rxvt*)
            PS1="\[\e]0;$remove-me{debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
            ;;
        *)
            ;;
        esac

        # Enable color support of `ls` and also add handy aliases
        if [ -x /usr/bin/dircolors ]; then
            test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
            alias ls='ls --color=auto'
            #alias dir='dir --color=auto'
            #alias vdir='vdir --color=auto'

            alias grep='grep --color=auto'
            alias fgrep='fgrep --color=auto'
            alias egrep='egrep --color=auto'
        fi

        # Alias definitions
        # Put all your additions into a separate file e.g. `~/.bash_aliases` instead of adding them here
        if [ -f ~/.bash_aliases ]; then
            . ~/.bash_aliases
        fi

        # Enable programmable completion features
        # You don't need to enable this if it's already enabled in `/etc/bash.bashrc` and `/etc/profile` sources `/etc/bash.bashrc`
        if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
            . /etc/bash_completion
        fi

        # ~/bin to the system binaries
        export PATH="$HOME/bin:$PATH"

        # Run fetch if not in VSCodium to reduce clutter in VSCodium
        if [ $TERM_PROGRAM != "vscode" ]; then
            fastfetch
            echo
            date
        fi
    '';   

    home.file.".bash_aliases".text = ''
        alias c="clear"
        alias t="touch"

        # `alert` alias for long running commands - Use it like, `sleep 10; alert`
        alias alert="notify-send --urgency=low -i \"$( [ $? = 0 ] && echo terminal || echo error )\" \"$(history | tail -n1 | sed -e 's/^\s*[0-9]\\+\\s*//;s/[;&|]\\s*alert$//')\""

        # Useful aliases for `ls`
        alias ll="ls -alF"
        alias la="ls -A"
        alias l="ls -CF"
    '';
}