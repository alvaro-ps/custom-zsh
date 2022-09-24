basepath=$(cd $(dirname "$0") && pwd)
# hard link to the custom vimrc file
ln -f $basepath"/vimrc" ~/.vimrc


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
