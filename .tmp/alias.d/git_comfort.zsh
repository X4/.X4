# GIT
alias g.sub="git submodule init && git submodule update" #update all git submodules
alias g.pullall="find . -type d -name .git -exec sh -c \"cd \"{}\"/../ && pwd && git pull && git submodule init && git submodule update\" \; "    # find all .git directories and exec "git pull" on the parent.
alias g.c="git clone "
alias g.s="git status -sb "
alias g.pm="git push -u origin master "
alias g.m="git commit "
alias g.mm="git commit --amend -C HEAD "
alias g.rm="set LANG en_US.UTF-8; git status | grep deleted | awk '{print \$3}' | xargs git rm "
alias g.log="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias g.undo="git reset --soft HEAD^ " # Undo your last commit, but don't throw away your changes
alias g.redo="git reset --soft HEAD "
alias g.changelog="git --no-pager log --format=\"%ai %aN %n%n%x09* %s%d%n\" | sed \"s/\*\ \*/*/g\" > ChangeLog"
alias g.ignore="find . -type d -empty -exec touch {}/.keep \; "
alias g.export="git archive --format=tar --remote=$1 master | tar -xf - " #only works with ssh://
alias g.whereami="git rev-parse --abbrev-ref HEAD " # prints only the current branch
alias g.gitolite="cat /home/git/.gitolite/logs/gitolite-`date +%Y-%m -d -30days`.log | cut -f2 | sort | uniq -c | sort -n -r "