# Fish Shell Aliases
# Useful aliases for improved productivity

# System aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# File operations
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -pv'

# System information
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps auxf'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias top='htop'

# Pacman aliases
alias pacman='sudo pacman'
alias pacs='sudo pacman -S'
alias pacu='sudo pacman -Syu'
alias pacr='sudo pacman -R'
alias pacss='pacman -Ss'
alias pacsi='pacman -Si'
alias pacqi='pacman -Qi'
alias pacqs='pacman -Qs'
alias pacorphans='sudo pacman -Rns (pacman -Qtdq)'

# Yay aliases
alias yays='yay -S'
alias yayu='yay -Syu'
alias yayss='yay -Ss'
alias yaysi='yay -Si'

# Git aliases
alias g='git'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gl='git log --oneline'
alias glog='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# Network aliases
alias ping='ping -c 5'
alias wget='wget -c'
alias ports='netstat -tulanp'
alias myip='curl http://ipecho.net/plain; echo'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'

# File finding
alias ff='find . -type f -name'
alias fd='find . -type d -name'

# Quick edit
alias vi='vim'
alias nano='nano -w'
alias edit='$EDITOR'

# Process management
alias psa='ps aux'
alias psg='ps aux | grep'
alias killall='killall -v'

# Archive extraction
alias extract='tar -xf'
alias tarzip='tar -czf'
alias tarunzip='tar -xzf'

# Hyprland specific
alias hyprconf='vim ~/.config/hypr/hyprland.conf'
alias waybarconf='vim ~/.config/waybar/config'
alias kittyconf='vim ~/.config/kitty/kitty.conf'
alias fishconf='vim ~/.config/fish/config.fish'

# Quick shortcuts
alias c='clear'
alias h='history'
alias j='jobs -l'
alias q='exit'
alias reload='source ~/.config/fish/config.fish'

# Safety aliases
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Fun aliases
alias please='sudo'
alias fucking='sudo'
alias weather='curl wttr.in'