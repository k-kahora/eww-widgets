set positional-arguments

show-directory:
  echo 
kill: 
  eww kill --config ./
  swww kill
log:
  eww log --config ./
init:
  eww daemon --config ./
open:
  swww init
  eww open example --config ./
inspect:
  eww inspector --config ./
update var val:
  eww update {{var}}={{val}} --config ./
  
reset:
  eww kill --config ./
  eww open example --config ./