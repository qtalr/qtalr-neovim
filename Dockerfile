# Dockerfile
# Image: qtalr-neovim

FROM francojc/qtalr-r:latest

ENV DEFAULT_USER="ruser"

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    imagemagick \
    kitty \
    liblua5.1-0-dev \
    libmagick++-dev \
    luajit \
    luarocks \
    ripgrep \
    software-properties-common \
    tree-sitter-cli \
    xclip \
    && add-apt-repository -y ppa:neovim-ppa/unstable \
    && apt-get install -y neovim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER $DEFAULT_USER

RUN mkdir -p ~/.config/ && \
    git clone --depth 1 https://github.com/qtalr/r-quarto-nvim.git ~/.config/nvim

RUN R -q -e "pak::pak(c('languageserver'))"

CMD ["bash", "-c", "exec bash"]
