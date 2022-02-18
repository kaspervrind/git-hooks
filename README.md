# git-hooks
dump of my useful git hooks. 



Add this to your bash aliases for easy access:
```shell
add_git_hooks () {
        echo "adding git hooks"
        cd .git/hooks
        echo "adding symlink"
        ln -s [FOLDER_OF_THIS_GIT_LIBRARY]
        cd -
}
```

Start the alias in your development project with:
```shell
$ add_git_hooks
```
