FROM debian

RUN apt-get update && apt-get install -y \
less \
git

RUN : "git関連の設定をbashrcにappend" && { \
  echo 'source /usr/share/bash-completion/completions/git'; \
  echo 'source /etc/bash_completion.d/git-prompt'; \
  echo "export PS1='[\\u@\\h \\W\$(__git_ps1 \" (%s)\")]\\\$ '" ; \
} | tee -a /etc/bash.bashrc
ENV PROMPT_COMMAND '__git_ps1 "\w" "\\\$ "'
ENV GIT_PS1_SHOWDIRTYSTATE true
ENV GIT_PS1_SHOWCOLORHINTS true
COPY dotfiles/.gitconfig /root/.gitconfig

WORKDIR /root

CMD [ "bash" ]
