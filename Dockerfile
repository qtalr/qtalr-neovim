# Dockerfile
# Neovim

FROM francojc/qtalr-r:latest

ENV DEFAULT_USER="ruser"

USER root

RUN apt-get update && apt-get install -y \
    imagemagick \
    kitty \
    liblua5.1-0-dev \
    libmagick++-dev \
    luajit \
    luarocks \
    software-properties-common \
    && add-apt-repository ppa:neovim-ppa/unstable \
    && apt-get update && apt-get install -y neovim \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER $DEFAULT_USER

RUN mkdir -p ~/.config/

# FIX: Problem, Neovim from apt-get is not the latest version
# installing from GitHub restricts to x86_64 architecture
RUN git clone --depth 1 https://github.com/jmbuhr/quarto-nvim-kickstarter.git ~/.config/nvim

RUN R -q -e "pak::pak(c('languageserver'))"

CMD ["bash", "-c", "source ~/.profile && exec bash"]
