FROM ubuntu:22.04

# RUN apt-get update
RUN apt-get update 
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:neovim-ppa/unstable -y

RUN apt-get update \
   && DEBIAN_FRONTEND=noninteractive TZ=$DEFAULT_TZ apt-get install -y \
   tzdata \
   neovim \
   # nvim reqs
   git \
   make \
   unzip \
   ripgrep \
   xclip \
   fontconfig \
   # c reqs
   build-essential \
   # go
   golang-go \
   # python
   python3-pip \
   python3-setuptools \
   python3-dev \
   # other
   sudo \
   curl \
   wget && \
   rm -rf /var/lib/apt/lists/*

# optional - get a font + neovim plugins
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/3270.zip \
   && mkdir 3270 \
   && bash -c "pushd 3270 && unzip ../3270.zip && popd" \
   && mkdir -p ~/.fonts \
   && mv 3270 ~/.fonts/ \
   && fc-cache -fv \
   && rm -f 3270.zip

RUN git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

COPY init.lua "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim/init.lua

RUN nvim --headless +PackerInstall +qall
RUN nvim --headless -c 'TSInstall python' -c 'q'
