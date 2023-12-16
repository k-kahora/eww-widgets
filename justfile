set positional-arguments


show-directory:
  echo 
kill: 
  eww kill --config ./
log:
  eww log --config ./
init:
  eww daemon --config ./
open:
  eww open example --config ./
inspect:
  eww inspector --config ./
update var val:
  eww update {{var}}={{val}} --config ./
  