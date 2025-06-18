# Fish Shell Configuration
# Beautiful and functional fish setup

# Set fish greeting
set fish_greeting

# Set default editor
set -gx EDITOR vim

# Set PATH additions
set -gx PATH $HOME/.local/bin $PATH

# Color scheme
set fish_color_normal normal
set fish_color_autosuggestion 555 brblack
set fish_color_command 5fafd7
set fish_color_error ff6c6b
set fish_color_param normal
set fish_color_comment 888888
set fish_color_match --background=brblue
set fish_color_selection white --bold --background=brblack
set fish_color_search_match bryellow --background=brblack
set fish_color_history_current --bold
set fish_color_operator 00a6b2
set fish_color_escape 00a6b2
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_valid_path --underline
set fish_color_redirection fc9867
set fish_color_end bc23ff
set fish_color_quote 86dc2f
set fish_color_command_substitution 6699cc

# Pager colors
set fish_pager_color_completion normal
set fish_pager_color_description B3A06D yellow
set fish_pager_color_prefix white --bold --underline
set fish_pager_color_progress brwhite --background=cyan

# Enable vi mode
fish_vi_key_bindings

# Auto-suggestions
set fish_autosuggestion_enabled 1