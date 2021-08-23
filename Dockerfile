# ref: https://medium.com/@ls12styler/docker-as-an-integrated-development-environment-95bc9b01d2c1
FROM alpine:latest
		 
WORKDIR /home/me
ENV HOME /home/me

# Create a user called 'me'
RUN adduser -D me
USER me

# bash and ncurses needed for tmux plugin manager
# zsh-vcs needed for git in alpine with zsh
RUN apk add -U --no-cache \
         neovim git \
		 zsh tmux bash ncurses \
		 curl
		 
RUN apk add -U --no-cache zsh-vcs
		 
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

# Install zsh plugins
RUN git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# TODO: install exa, oh-my-zsh plugins 
ENTRYPOINT ["/bin/zsh"]
