# Dockerfile
# Neovim

FROM francojc/qtalr-r:latest

ENV DEFAULT_USER="ruser"

USER root

RUN apt-get update && apt-get install -y \
    neovim \
    git \
    imagemagick \
    libmagick++-dev \
    liblua5.1-0-dev \
    luajit

USER $DEFAULT_USER

RUN mkdir -p ~/.config/

RUN git clone https://github.com/jmbuhr/quarto-nvim-kickstarter.git ~/.config/nvim

RUN R -q -e "pak::pak(c('languageserver'))"

CMD ["bash"]
