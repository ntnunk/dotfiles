PROMPT='
%n@%m %{$fg[yellow]%}$(virtualenv_prompt_info) %{$fg[cyan]%}$(shrink_path -f)
%? $(git_prompt_info)%{$fg_bold[blue]%}%% %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}"


