# SPAJIC

## Overmind
use overmind to start all necessary processes, listed in Procfile

prereqs: overmind in /usr/local/bin, tmux

start: overmind d

connect tmux to one of overminded processes: overmind connect web
