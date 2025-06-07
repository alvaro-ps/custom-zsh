basepath=$(cd $(dirname "$0") && pwd)
#set vi mode in bash
set -o vi
#set page up and down to browse through history
bindkey "\e[5~" 'history-search-backward'
bindkey "\e[6~" 'history-search-forward'

source "${basepath}/api_keys.sh"
