if [[ "$DISABLE_CORRECTION" == "true" ]]; then
  return
else
  alias man='nocorrect man'
  alias mv='nocorrect mv'
  alias mysql='nocorrect mysql'
  alias mkdir='nocorrect mkdir'
  alias gist='nocorrect gist'
  alias heroku='nocorrect heroku'
  alias rhc="nocorrect rhc"
  alias hpodder='nocorrect hpodder'
  alias ebuild='nocorrect ebuild'
  alias emerge='nocorrect emerge'
  alias sudo='nocorrect sudo'
  alias "_"='nocorrect sudo'
  alias pip="nocorrect pip"
fi