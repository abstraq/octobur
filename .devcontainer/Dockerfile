ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

RUN curl -fsSL https://crystal-lang.org/install.sh | sudo bash

# Install Crystal
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -yq crystal


# Install Crystalline Language Server
USER vscode
WORKDIR /home/vscode 
RUN mkdir .crystalline && cd .crystalline
RUN wget https://github.com/elbywan/crystalline/releases/latest/download/crystalline_x86_64-unknown-linux-gnu.gz -O crystalline.gz &&\
    gzip -d crystalline.gz &&\
    chmod u+x crystalline