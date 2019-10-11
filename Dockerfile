FROM debian

RUN apt-get update && apt-get install -y \
bash-completion \
curl \
vim \
less \
git

RUN : "git関連の設定をbashrcにappend" && { \
  echo 'source /usr/share/bash-completion/bash_completion'; \
  echo 'source /etc/bash_completion.d/git-prompt'; \
} | tee -a /etc/bash.bashrc
ENV PROMPT_COMMAND '__git_ps1 "\w" "\\\$ "'
ENV GIT_PS1_SHOWDIRTYSTATE true
ENV GIT_PS1_SHOWCOLORHINTS true
COPY dotfiles/.gitconfig /etc/gitconfig

RUN curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-19.03.3.tgz \
  | tar -xzC /usr/local/bin --strip=1 docker/docker

CMD [ "bash" ]
