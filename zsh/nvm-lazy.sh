# This script should be sourced from .zprofile to take advantage of the $ZSH_EXECUTION_STRING check
export NVM_DIR="$HOME/.nvm"
export NVM_SYMLINK_CURRENT=true
NODE_VERSION_DIR=$(readlink ~/.nvm/current) # Assumes ~/.nvm/current is linked
__NODE_GLOBALS=("${(@f)$(find "$NODE_VERSION_DIR"/bin -maxdepth 1 -mindepth 1 -type l -print0 | xargs --null -n1 basename | sort --unique)}")
__NODE_GLOBALS+=(node nvm)

found=false
for value in "${__NODE_GLOBALS[@]}"; do
  # if zsh is trying to execute a command that matches one of the node globals in the current version
  if [[ $ZSH_EXECUTION_STRING == *"$value"* ]]; then
    # Forget about lazy loading and just add the current nvm node version to the PATH
    PATH=~/.nvm/current/bin:$PATH
    found=true
    break
  fi
done

# instead of using --no-use flag, load nvm lazily:
if ! $found; then
  _load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  }

  for cmd in "${__NODE_GLOBALS[@]}"; do
    eval "function ${cmd}(){ unset -f ${__NODE_GLOBALS[*]}; _load_nvm; unset -f _load_nvm; ${cmd} \"\$@\"; }"
  done
fi
unset cmd value found __NODE_GLOBALS

