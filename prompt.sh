GREEN="\001$(tput setaf 2)\002"
ORANGE="\001$(tput setaf 3)\002"
RED="\001$(tput setaf 1)\002"
ENDCOLOR="\001$(tput sgr0)\002"

export COMPUTER_NAME=`hostname -s`

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/⎇ \1/'
}

get_git_info() {
  echo "${ORANGE}`parse_git_branch`${GREEN}"
}

get_prompt() {
  DIR=`pwd`;
  CURRENT_BRANCH=""
  GIT_INFO=`get_git_info`
  if [[
    # <!--
    # macOS:
      "$DIR" == "/Users/$USER/"* ||
      "$DIR" == "/Users/$USER" ||
    # Linux:
      "$DIR" == "/home/$USER/"* ||
      "$DIR" == "/home/$USER" ||
    # -->
    0 -eq 1
  ]]; then
    PROMPT_CHAR=λ
  else
    PROMPT_CHAR=θ
  fi;

  export PS1="$GREEN""┌$USER@$COMPUTER_NAME:$RED`
         `""$DIR$GREEN$GIT_INFO\n└$PROMPT_CHAR $ENDCOLOR"
}

PROMPT_COMMAND="get_prompt"
