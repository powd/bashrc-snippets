alias qq='docker'

alias qqs='docker stop'
alias qqr='docker rm'
alias QQ='docker images'
alias qqp='docker ps --format "{{.ID}}\t{{.Status}}\t{{.Names}}\t{{.Ports}}"'
alias qqpp='docker ps -a'
alias qqppp='docker ps'
alias qqx='docker exec -it'
alias qql='docker logs -f'
alias qqlll='docker logs'
alias qqR='docker run'
alias qqv='docker volume'
alias qqvvv='docker volume ls'
alias qqvr='docker volume rm'

function qqd {
  docker stop $1 && docker rm $1
}

function qqb {
   docker exec -it $1 bash
}

function qqsh {
   docker exec -it $1 sh
}

function qqqv {
  docker volume ls --format '{{.Name}}' \
    | grep "^[^ ]*$1[^ ]*" \
    | head -1 \
    | tr -d '\n' \
    | tee >(test -n "$(cat)" || (echo 'Volume not found!' 1>&2 && false )) \
    | cat
}

# TODO: Swap Name and ID and get rid of "$", letting the user to use grep's "\$"
function qqq {
  docker ps -a --format '{{.Names}}$ {{.ID}}' \
    | grep "^[^ ]*$1[^ ]* " \
    | head -1 \
    | awk '{printf "%s%s", $2, RT}' \
    | tee >(test -n "$(cat)" || (echo 'Container not found!' 1>&2 && false )) \
    | cat
}

function QQQ {
  # TODO: May be simplified, second column not needed (pasted from qqq)
  docker ps -a --format '{{.Image}}$ {{.ID}}' \
    | grep "^[^ ]*$1[^ ]* " \
    | head -1 \
    | awk '{printf "%s%s", $1, RT}' \
    | tee >(test -n "$(cat)" || (echo 'Image not found!' 1>&2 && false )) \
    | cat
}

function qqqd {
  docker stop `qqq $1` && docker rm `qqq $1`
}

function qqqvr {
  docker volume rm `qqqv $1`
}

function qqp_inline_ids {
  docker ps --format '{{.ID}}' | tr '\n' ' '
}

function qqpp_inline_ids {
  docker ps -a --format '{{.ID}}' | tr '\n' ' '
}

function qqqb {
  SEARCH_TERM="$1" && shift 1 && docker exec -it `qqq $SEARCH_TERM` bash $@
}

function qqqB {
  SEARCH_TERM="$1" && shift 1 && docker exec -u 0 -it `qqq $SEARCH_TERM` bash $@
}

function qqql {
  SEARCH_TERM="$1" && shift 1 && docker logs -f `qqq $SEARCH_TERM` $@
}

function qqqlll {
  SEARCH_TERM="$1" && shift 1 && docker logs `qqq $SEARCH_TERM` $@
}

function qqqx {
  SEARCH_TERM="$1" && shift 1 && docker exec -it `qqq $SEARCH_TERM` $@
}

function QQQR {
  SEARCH_TERM="$1" && shift 1 && docker run `QQQ $SEARCH_TERM` $@
}

alias qqss='docker stop `qqpp_inline_ids`'
alias qqrr='docker rm `qqpp_inline_ids`'
alias qqrrr='docker rm `qqpp_inline_ids` -f'
alias qqdd='qqss && qqrr'
alias qqddd='qqss && qqrrr'

alias qqll='docker logs -f `qqp_inline_ids`'

alias qquu='docker system prune'
alias qquuv='docker volume prune'
alias QQuu='docker image prune -a'
