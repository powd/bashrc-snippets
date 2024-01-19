function que {
  which $1 || type $1 
}

alias teen='tee /dev/null < /dev/null'

function md5rn {
  echo `cat /dev/random | head -c 100 | md5 | head -c $1`
}

alias md5r8='md5rn 8'
alias md5r16='md5rn 16'
alias md5r32='md5rn 32'
alias md5r='md5rn 32'
