# http://neurotap.blogspot.com/2012/04/character-level-diff-in-git-gui.html
intra_line_diff='--word-diff-regex="[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+"'

#-----------------------------------------------------------------------------
# o = working copy
#-----------------------------------------------------------------------------
alias g.cal="$HOME/.X4/global/scripts/git-cal"

# clone remote repository
alias g.clone="git clone"
alias g.c="git clone"
alias g.cr="git clone --recursive"
 
# show status of working copy
alias g.status='git status'
alias g.s='git status'

# show status of files in working copy
alias g.status.short='git status --short'

# diff working copy against current commit
alias g.diff='git diff'

# ... while showing changes within a line
alias g.diff.intraline='git diff '$intra_line_diff

# reset working copy to current index
alias g.reset='git reset --soft'

# reset working copy to upstream state
alias g.reset.upstream='git reset --soft @{u}'

# reset working copy to current commit
alias g.reset.hard='git reset --hard'

# reset working copy to upstream state
alias g.reset.hard.upstream='git reset --hard @{u}'

# stage deletion and also delete from working copy
alias g.rm='git rm -r --ignore-unmatch'

# list unknown files in working copy
alias g.list.unknown.status='git status --porcelain | sed -n "s/^?? *//p"'

# list unknown files in working copy that can be deleted
alias g.list.cleanable='git clean -n'

# delete unknown files from working copy
alias g.clean='git clean -f'

# Undo your last commit, but don't throw away your changes
alias g.undo="git reset --soft HEAD^ "

# Undo your last commit, but don't throw away your changes
alias g.redo="git reset --soft HEAD "

#-----------------------------------------------------------------------------
# i = index / stage
#-----------------------------------------------------------------------------

# stage changes interactively (like Darcs!)
alias g.add.interactive='git add -p'

# stage all changes in target
alias g.add='git add'

# stage all changes in working copy
alias g.stage='git add -u'

# diff index against current commit
alias g.diff.index='git diff --cached'

# ... while showing changes within a line
alias g.diff.index.intraline='git diff --cached '$intra_line_diff

# unstage changes from index but keep them in working copy
alias g.reset.index='git reset'

# unstage changes from both index and working copy
alias g.reset.mixed='git reset --mixed'

#-----------------------------------------------------------------------------
# t = stash
#-----------------------------------------------------------------------------

# stash current state and reset working copy to current commit
alias g.stash.reset='git stash save'

# stash current state but keep working copy as-is
alias g.stash.apply='git stash save && git stash apply'

# list all stashes
alias g.list.stashes='git stash list'

# list all stashes with diffs
alias g.list.stashes.diff='git stash list --patch-with-stat'

# create new branch from stash
alias g.branch.stash='git stash branch'

# unstash to working copy but keep stash
alias g.unstash.keep='git stash apply'

# unstash to working copy and delete stash
alias g.unstash.rm='git stash pop'

# delete stash
alias g.stash.drop='git stash drop'

# delete all stashes
alias g.stash.clear='git stash clear'

#-----------------------------------------------------------------------------
# m = commit message
#-----------------------------------------------------------------------------

# commit staged changes
alias g.m='git commit'

# commit staged changes with the given message
alias g.mm='git commit -m'

# commit staged changes as if on the given date
alias g.md='git commit --date'

# commit staged changes as if on the modification date of the given file
function g.mdf() {
  git commit --date="$(date -r "$1")"
}

# commit staged changes with the given version string as the message
function g.mv() {
  git commit -m "Version $1" && git tag "v$1"
}
function g.mV() {
  git tag -f "v$1"
}

# commit staged changes to a temporary "squash" commit, to be rebased later
alias g.mq='git commit -m "SQUASH $(date)"'

# amend current commit and edit its message
alias g.ma='git commit --amend'

# amend current commit but reuse its message
alias g.mA='git commit --amend --reuse-message=HEAD'

# commit an inverse commit to revert changes from the given commit
alias g.revert='git revert'

# delete current commit but keep its changes in working copy
alias g.reset.keep='git reset "HEAD^"'

# check out changes from current commit
alias g.checkout='git checkout'
alias g.co='git checkout'

# update working copy to current commit
alias g.checkout.head='git checkout HEAD --'

# cherry pick the given commit into current branch
alias g.cherrypick='git cherry-pick'
alias g.cherryick.continue='git cherry-pick --continue'
alias g.cherrypick.abort='git cherry-pick --abort'
alias g.cherrypick.skip='git cherry-pick --skip'

# show current commit in detail
alias g.show='git show'

#-----------------------------------------------------------------------------
# b = branch
#-----------------------------------------------------------------------------

# create branch with given name
alias g.branch='git checkout -b'

# list all branches
alias g.list.branches='git branch -av'

# list all branches with commit details
alias g.list.branches.detailed='git branch -v'

# delete merged branch
alias g.branch.rm='git branch -d'

# delete branch forcefully
alias g.branch.rm.force='git branch -D'

# rename current branch to given namee
alias g.branch.rename='git branch -m'

# rename current branch to given name forcefully
alias g.branch.rename.force='git branch -M'

# show only the current branch
alias g.whereami="git rev-parse --abbrev-ref HEAD "

# show current branch name
# http://stackoverflow.com/a/9753364
gb1() {
  git symbolic-ref --short HEAD
}

# show current remote branch name
# http://stackoverflow.com/a/9753364
gbh() {
  git rev-parse --abbrev-ref '@{u}'
}

# set upstream branch for tracking
gbH() {
  branch=$(gb1)
  remote=${1:-origin}
  echo "$remote" | fgrep -vq "/" && remote="$remote/$branch"
  git branch -u "$remote" "$branch"
}

#-----------------------------------------------------------------------------
# m = merge
#-----------------------------------------------------------------------------

# merge commits
alias g.merge='git merge --no-ff'

# merge commits but don't record a special merge commit
alias g.merge.ff='git merge --ff'

#-----------------------------------------------------------------------------
# r = rebase
#-----------------------------------------------------------------------------

alias g.rebase='git rebase'
alias g.rebase.interactive='git rebase --interactive'
alias g.rebase.continue='git rebase --continue'
alias g.rebase.abort='git rebase --abort'
alias g.rebase.skip='git rebase --skip'
# rebase against upstream branch
alias g.rebase.upstream='git rebase @{u}'

#-----------------------------------------------------------------------------
# k = conflict
#-----------------------------------------------------------------------------

# list all conflicted files
alias g.list.conflicts='git ls-files --unmerged | cut -f2 | uniq'

# add changes from all conflicted files
alias g.conflict.add='git add $(gkl)'

# edit conflicted files
alias g.conflict.edit='edit-merge-conflict $(gkl)'

# use local version of the given files
alias g.conflict.local='git checkout --theirs --'

# use local version of all conflicted files
alias g.conflict.local.all='gko $(gkl)'

# use upstream version of the given files
alias g.conflict.upstream='git checkout --ours --'

# use upstream version of all conflicted files
alias g.conflict.upstream.all='gkt $(gkl)'

#-----------------------------------------------------------------------------
# f = files
#-----------------------------------------------------------------------------

# list all known files
alias g.ls='git ls-files'

# list ignored files
alias g.list.ignored='git status --porcelain --short --ignored | sed -n "s/^!! //p"'

# create .keep files in empty directories
alias g.add.emptydirs="find . -type d -empty -exec touch {}/.keep \; git add ."

# list staged files
alias g.list.staged='git ls-files --cached'

# list modified files
alias g.list.modified='git ls-files --modified'

# list unknown files
alias g.list.unknown='git ls-files --others'

# list deleted files
alias g.list.deleted='git ls-files --killed'

#-----------------------------------------------------------------------------
# l = log
#-----------------------------------------------------------------------------

# show commit log
alias g.log='git log --decorate --graph'

# show pretty commit log
alias g.logy="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

# show most recent log entry
alias g.log.recent='git log --decorate --graph --name-status -1'

# show log with affected files
alias g.log.affected='git log --decorate --graph --name-status'

# show log like `ls -l`
alias g.log.detail='git log --decorate --graph --oneline'

# show log with diffs
alias g.log.diff='git log --decorate --graph --patch-with-stat'

# ... while showing changes within a line
alias g.log.diff.intraline='git log --decorate --graph --patch-with-stat '$intra_line_diff

# pretty git changelog
glp() {
  git log --pretty='  * %s. %b'$'\n' "$@"
}

# create ChangeLog file out of git history
alias g.changelog="git --no-pager log --format=\"%ai %aN %n%n%x09* %s%d%n\" | sed \"s/\*\ \*/*/g\" > ChangeLog"

# show gitolite logs
alias g.gitolite="cat /home/git/.gitolite/logs/gitolite-`date +%Y-%m -d -30days`.log | cut -f2 | sort | uniq -c | sort -n -r "

# add .keep files into empty directories
alias g.ignore.empty="find . -type d -empty -exec touch {}/.keep \; "

# stage deletion without changing working copy
alias g.ignore.sync='git rm -r --cached --ignore-unmatch'

#-----------------------------------------------------------------------------
# L = reflog
#-----------------------------------------------------------------------------

# show reference log
alias g.reflog='git reflog --decorate'

alias g.reflog.intraline='git log --decorate --graph --oneline `git reflog --decorate --pretty=%h`'

# search reflog for all commits related to the given files
gLf() {
  git log --decorate --graph $(git rev-list --all "$@")
}

# search reflog for all commits related to the given files, show with diffs
gLfd() {
  git log --decorate --graph --patch-with-stat $(git rev-list --all "$@")
}

#-----------------------------------------------------------------------------
# h = remote hosts
#-----------------------------------------------------------------------------

# list all remotes
alias g.list.remotes='git remote -v'

# add remote
alias g.add.remote='git remote add'

# delete remote
alias g.rm.remote='git remote rm'

# show current remote name
# http://stackoverflow.com/a/7251377
alias g.show.remote='git config branch.$(gb1).remote'

# show current remote URL
# http://stackoverflow.com/a/7251377
alias g.show.remote.url='git config remote.$(git config branch.$(gb1).remote).url'

# diff remote tracking branch
alias g.diff.remote='git diff @{u}'

# ... while showing changes within a line
alias g.diff.remote.intraline='git diff @{u} '$intra_line_diff

# Creates master.tar out of remote repo (ssh:// only)
alias g.export="git archive --format=tar --remote=$1 master | tar -xf - "


#-----------------------------------------------------------------------------
# p = push
#-----------------------------------------------------------------------------

# push commits
alias g.push='git push'

# push commits forcefully
alias g.push.force='git push --force'

# push tags
alias g.push.tags='git push --tags'

# push tags forcefully
alias g.push.tags.force='git push --tags --force'

#-----------------------------------------------------------------------------
# g = fetch
#-----------------------------------------------------------------------------

# fetch commits
alias g.fetch='git fetch'

# fetch commits from all repos in current dir
alias g.fetchall="find . -type d -name .git -exec sh -c \"cd \"{}\"/../ && pwd && git fetch && git submodule init && git submodule update\" \; "

# pull and merge commits
alias g.pull='git pull'

# pull and rebase commits
alias g.pull.rebase='git pull --rebase'

# pull commits from all repos in current dir
alias g.pullall="find . -type d -name .git -exec sh -c \"cd \"{}\"/../ && pwd && git pull && git submodule init && git submodule update\" \; "    # find all .git directories and exec "git pull" on the parent.

#-----------------------------------------------------------------------------
# u = submodule
#-----------------------------------------------------------------------------

# list all submodules
alias g.list.submodules='git submodule'

# add submodule
alias g.add.submodule='git submodule add'

# reset submodules to known state
alias g.submodule.update='git submodule update'

# register new URLs for submodules
alias g.submodule.sync='git submodule sync'

alias g.submodule.init="git submodule init && git submodule update" #update all git submodules
