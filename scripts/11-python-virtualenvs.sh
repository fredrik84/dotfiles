#!/bin/bash
cat >> ~/.bashrc <<EOF
# Enable pyenv
export PYENV_ROOT="\$HOME/.pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init --path)"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"

# Enable direnv
eval "\$(direnv hook bash)"

# Optional: auto-activate .venv if present (for convenience)
function auto_venv_direnv() {
  if [[ -f .venv/bin/activate && ! -f .envrc ]]; then
    echo 'source .venv/bin/activate' > .envrc
    direnv allow
  fi
}
PROMPT_COMMAND="auto_venv_direnv;\$PROMPT_COMMAND"
EOF

pyenv install 3.11.9
pyenv virtualenv 3.11.9 global-default
pyenv global global-default
