function fish_prompt
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    pyenv init - | source
end

alias g git

abbr -a -g la 'ls -la'

abbr -a -g c clear
abbr -a -g t tmux

abbr -a -g ga 'g add'
abbr -a -g gaa 'g add .'
abbr -a -g grs 'g reset --soft HEAD~1'
abbr -a -g grh 'g reset --hard HEAD~1'
abbr -a -g gs 'g status'
abbr -a -g gca 'g commit --amend'
abbr -a -g gl 'g log'
abbr -a -g gc 'g commit -m '
abbr -a -g grst 'g reset --staged '

abbr -a -g qd 'quasar dev'

starship init fish | source
