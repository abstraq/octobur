# Create a variable with a default value of  latest
ARG VARIANT=latest

# Use the official Crystal container
FROM crystallang/crystal:${VARIANT}

# Variables that will setup a non-root user.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

COPY library-scripts/common-debian.sh /tmp/library-scripts/
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && bash /tmp/library-scripts/common-debian.sh "true" "${USERNAME}" "${USER_UID}" "${USER_GID}" \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts