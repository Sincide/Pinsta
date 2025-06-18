# Fish Shell Beautiful Prompt
# A clean, informative, and colorful prompt

function fish_prompt
    # Colors
    set -l normal (set_color normal)
    set -l magenta (set_color magenta)
    set -l yellow (set_color yellow)
    set -l green (set_color green)
    set -l red (set_color red)
    set -l gray (set_color -o black)
    set -l blue (set_color blue)
    set -l cyan (set_color cyan)
    
    # Get current directory
    set -l cwd (basename (prompt_pwd))
    
    # Get git status if in git repo
    set -l git_info ""
    if git rev-parse --git-dir >/dev/null 2>&1
        set -l git_branch (git branch 2>/dev/null | sed -n '/\* /s///p')
        set -l git_dirty ""
        if not git diff-index --quiet HEAD -- 2>/dev/null
            set git_dirty "*"
        end
        set git_info "$gray($green$git_branch$red$git_dirty$gray)"
    end
    
    # Get last command status
    set -l last_status $status
    set -l status_color $green
    if test $last_status -ne 0
        set status_color $red
    end
    
    # User and hostname
    set -l user_host "$blue$USER$gray@$cyan$hostname"
    
    # Current time
    set -l current_time "$gray["(date +%H:%M)"]"
    
    # Build prompt
    echo -n -s $current_time " " $user_host " " $magenta$cwd " " $git_info $normal
    echo -n -s $status_color " ❯ " $normal
end

function fish_right_prompt
    # Right side prompt with additional info
    set -l gray (set_color -o black)
    set -l normal (set_color normal)
    
    # Show current jobs if any
    set -l job_count (jobs | wc -l)
    if test $job_count -gt 0
        echo -n -s $gray "["$job_count" jobs]" $normal
    end
end

function fish_mode_prompt
    # Vi mode indicator
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo '[N]'
        case insert
            set_color --bold green  
            echo '[I]'
        case replace_one
            set_color --bold yellow
            echo '[R]'
        case visual
            set_color --bold brmagenta
            echo '[V]'
        case '*'
            set_color --bold red
            echo '[?]'
    end
    set_color normal
    echo -n ' '
end