basepath=$(cd $(dirname "$0") && pwd)
# hard link to the custom vimrc file
ln -f "${basepath}/vimrc" ~/.vimrc
ln -f "${basepath}/coc-settings.json" ~/.vim/coc-settings.json

ln -f "${basepath}/nvim/init.vim" "${HOME}/.config/nvim/init.vim"
ln -f "${basepath}/nvim/lua/plugins.lua" "${HOME}/.config/nvim/lua/plugins.lua"

mkdir -p "${HOME}/.sbt/1.0/plugins"
ln -f "${basepath}/nvim/plugins.sbt" "${HOME}/.sbt/1.0/plugins/plugins.sbt"
alias vim=nvim


vck () {
    # open files that match the given regex
    REGEX="$1"
    DIRECTORY=$2

    # remove arguments from the list of arguments, so that we can pass them to ack
    [ -n "$REGEX" ] && shift
    [ -n "$DIRECTORY" ] && shift

    FILES_MATCHING_REGEX=$(ack -l "$REGEX" $DIRECTORY $@)
    if [ -z "$FILES_MATCHING_REGEX" ]; then
        echo "No files matching '"$REGEX"'"
        return
    fi
    # remove trailing slashes from the regex that will be passed to VIM, as it does not
    # need them
    VIM_REGEX=$(echo "$REGEX" | tr -d '\\')
    echo "$FILES_MATCHING_REGEX" | xargs -o vim +/"$VIM_REGEX"
}
