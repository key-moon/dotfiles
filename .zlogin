zplug update

if which ghq >/dev/null 2>&1; then
  ghq_root="$(ghq root)"
  ghq_list="$(ghq list | grep key-moon | grep -v ac-predictor-data)"
  for repo in ${(f)ghq_list}; do
    ghq get -u $repo &
  done
  wait
fi
