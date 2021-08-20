# ref: https://medium.com/@ls12styler/docker-as-an-integrated-development-environment-95bc9b01d2c1
FROM alpine:latest
		 
WORKDIR /home/me
ENV HOME /home/me

# Create a user called 'me'
RUN adduser -D me
USER me

# bash and ncurses needed for tmux plugin manager
RUN apk add -U --no-cache \
         neovim git \
		 zsh tmux bash ncurses \
		 curl
		 
RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

COPY zshrc .zshrc
COPY init.vim .config/nvim/init.vim
COPY tmux.conf .tmux.conf
COPY gitconfig .gitconfig
COPY aliases .oh-my-zsh/custom/aliases.zsh

# install Go
COPY --from=golang:1.13-alpine /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

# Install Vim Plug for plugin management
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins
# TODO: figure out error here
# RUN nvim +PlugInstall +qall >> /dev/null

# Install Tmux Plugin Manager
RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
# Install plugins
# TODO: figure out error here
#RUN .tmux/plugins/tpm/bin/install_plugins

# TODO: install exa, oh-my-zsh plugins 
CMD ["/bin/zsh"]
