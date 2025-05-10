#!/bin/bash

if tmux ls; then
 # server exists
  SESSION=$(echo $(tmux ls -F '#S' -f '#{==:#{session_attached},0}') $(tmux display -p '#{?#{session_attached},,#S}') | awk -F ' ' '{print $NF}')
  if [ -z "$SESSION" ] ; then
    tmux
  else
    tmux attach-session -t $SESSION
  fi
else
 # server must spawned from zsh
  echo "launching..."
  /bin/zsh -l -i -c tmux
fi
