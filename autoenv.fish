if [ -z $AUTOENV_AUTH_FILE ]
  set AUTOENV_AUTH_FILE "$HOME/.autoenv_authorized"
end

function _autoenv_exec
  if [ ! -f $argv ]
    return
  end

  if which shasum > /dev/null ^ /dev/null
    set hash (shasum $argv | cut -d' ' -f 1)
  else
    set hash (sha1sum $argv | cut -d' ' -f 1)
  end

  if grep "$argv:$hash" "$AUTOENV_AUTH_FILE"  > /dev/null ^ /dev/null
    . $argv
  else
    echo "> WARNING"
    echo "> This is the first time you are about to source \"$argv\""
    echo
    echo "----------------"
    echo
    cat $argv
    echo
    echo "----------------"
    echo
    echo -n "Are you sure you want to allow this? (y/N)"

    read answer

    if [ $answer = "y" -o $answer = "Y" ]
      echo "$argv:$hash" >> $AUTOENV_AUTH_FILE
      . $argv
    end
  end
end

function _autoenv_explodepath
  set curpath $argv

  if [ -z $curpath ]
    set curpath "/"
  end

  while [ ! $curpath = "/" ]
    echo $curpath
    set curpath (dirname $curpath)
  end

  echo "/"
end

function _autoenv --on-variable PWD
  if status --is-command-substitution
    return
  end

  set -l newpath $PWD

  if [ -z $AUTOENV_OLDPATH ]
    _autoenv_exec "/.env.fish"
    set -g AUTOENV_OLDPATH "/"
  end

  if [ $newpath = $AUTOENV_OLDPATH ]
    return
  end

  set newpath (_autoenv_explodepath $newpath)[-1..1]
  set AUTOENV_OLDPATH (_autoenv_explodepath $AUTOENV_OLDPATH)[-1..1]

  set -l commonindex 1

  for i in (seq (count $newpath))
    if [ (count $AUTOENV_OLDPATH) -lt $i ]
      break
    end

    if [ $newpath[$i] = $AUTOENV_OLDPATH[$i] ]
      set commonindex $i
    else
      break
    end
  end

  if [ $commonindex -lt (count $AUTOENV_OLDPATH) ]
    for op in $AUTOENV_OLDPATH[-1..(math $commonindex+1)]
      _autoenv_exec $op/.out.fish
    end
  end

  if [ $commonindex -lt (count $newpath) ]
    for op in $newpath[(math $commonindex+1)..-1]
      _autoenv_exec $op/.env.fish
    end
  end

  set -g AUTOENV_OLDPATH $PWD
end
