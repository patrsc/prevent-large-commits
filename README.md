# Prevent Git commits with large files

To abort git commits with files larger than **100 MB** and give a 
warning with files larger than **20 MB**, run the following code in Git Bash:

```bash
bash -c "git clone https://github.com/patrsc/prevent-large-commits.git && cd prevent-large-commits && bash install.sh && cd .. && rm -rf prevent-large-commits"
```

**Warning:** this will *always* use hooks defined in `~/.git_hooks/`, which might be undesired if you have repositories with custom hooks.

If you want to set a different global size limit, define it as follows (values in bytes):

```bash
git config --global hooks.filesizesoftlimit 20000000
git config --global hooks.filesizehardlimit 100000000
```

If you want to set a different limit for some repositories, open Git Bash 
in such a repository and run:

```bash
git config hooks.filesizesoftlimit 20000000
git config hooks.filesizehardlimit 100000000
```

## References

* https://stackoverflow.com/questions/39576257/how-to-limit-file-size-on-commit
* https://kiwidamien.github.io/prevent-big-commits.html
