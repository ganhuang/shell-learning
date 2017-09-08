# Some notes for me to learn `Shell`

- [sed_usage](sed_usage.md)

- Change your shell prefix

```
PS1="\e[1;32m[\\u \\w]\\$\e[m "
[ghuang ~/git/ganhuang/shell-learning]$
```
- Peer's certificate issuer has been marked as not trusted by the user.

```
git config --system http.sslverify false
```
- Groovy-based DSL jenkins

- [sexy promot](https://github.com/twolfson/sexy-bash-prompt) 

```(cd /tmp && git clone --depth 1 --config core.autocrlf=false https://github.com/twolfson/sexy-bash-prompt && cd sexy-bash-prompt && make install) && source ~/.bashrc
```

- tmux

```
tmux -S /var/tmux new -s shared
tmux -S /var/tmux attach -t shared

export TMUX_GROUP=tmux
groupadd $TMUX_GROUP
mkdir /var/tmux
chgrp $TMUX_GROUP /var/tmux
chmod g+ws /var/tmux
usermod -aG $TMUX_GROUP user1
usermod -aG $TMUX_GROUP user2
```

# shell prompt
```
(cd /tmp && git clone --depth 1 --config core.autocrlf=false https://github.com/twolfson/sexy-bash-prompt && cd sexy-bash-prompt && make install) && source ~/.bashrc
```
