# Execute code that does not affect the current session in the background.

zrecompile -p -R ~/.zshrc -- -M ~/.zcompdump --  > /dev/null

for ((i=1; i <= $#fpath; ++i)); do
  dir=$fpath[i]
  zwc=${dir:t}.zwc
  if [[ $dir == (.|..) || $dir == (.|..)/* ]]; then
    continue
  fi
  files=($dir/*(N-.))
  if [[ -w $dir:h && -n $files ]]; then
    files=(${${(M)files%/*/*}#/})
    if ( cd $dir:h &&
         zrecompile -p -U -z $zwc $files ); then
      fpath[i]=$fpath[i].zwc
    fi
  fi
done

#{
  # Compile the completion dump to increase startup speed.
  #zshdump="${ZDOTDIR:-$HOME}/.zshrc"
  #zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  #if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    #zcompile "$zcompdump"
    #zrecompile -p -R "$zshdump" -- -M "$zcompdump" --  > /dev/null
  #fi
#} &!