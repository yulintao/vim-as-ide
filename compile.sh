#! /bin/sh

sudo apt install tmux autojump zsh

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

git clone https://github.com/zsh-users/zsh-autosuggestions .oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
