#!/usr/bin/env bash

# Check if the system is macOS
if [ "$(uname)" != "Darwin" ]; then
  echo "FastProxy is only supported on macOS yet."
  exit 1
fi

# Determine which shell configuration file to update
SHELL_CONFIG_FILE=""

if which zsh >/dev/null; then
    # This is zsh shell
    SHELL_CONFIG_FILE="$HOME/.zshrc"
else
    # This is bash shell
    SHELL_CONFIG_FILE="$HOME/.bash_profile"
    [ ! -f "$SHELL_CONFIG_FILE" ] && SHELL_CONFIG_FILE="$HOME/.bashrc"
fi

# Check if FASTPROXY_HOME variable exists, if not, set it to $HOME/.fastproxy
if [ -z "${FASTPROXY_HOME}" ]; then
  export FASTPROXY_HOME="$HOME/.fastproxy"
  echo "Setting FASTPROXY_HOME to $FASTPROXY_HOME"
  
  # Update shell configuration file
  echo "Updating shell configuration file: $SHELL_CONFIG_FILE"
  echo "export FASTPROXY_HOME=\"\$HOME/.fastproxy\"" >> "$SHELL_CONFIG_FILE"
  echo "export PATH=\"\$PATH:\$FASTPROXY_HOME/bin\"" >> "$SHELL_CONFIG_FILE"
fi

# Create necessary directory
mkdir -p "${FASTPROXY_HOME}/bin"

# Determine system architecture
ARCH=""
case $(uname -m) in
    "x86_64") ARCH="amd64" ;;
    "arm64") ARCH="arm64" ;;
    *) echo "Unsupported architecture"; exit 1 ;;
esac

# Define the file to download
REPO="fastproxy/fastproxy-release"
FILE="fastproxy-darwin-${ARCH}"

# Fetch the download URL for the latest release from GitHub
DOWNLOAD_URL=$(curl -s https://api.github.com/repos/${REPO}/releases \
| grep "browser_download_url.*${FILE}" \
| cut -d '"' -f 4)

# Check if the download URL is found
if [ -z "${DOWNLOAD_URL}" ]; then
  echo "Download URL not found for the releases."
  exit 1
fi

# Download the tar package
curl -L "${DOWNLOAD_URL}" -o "${FASTPROXY_HOME}/${FILE}.tar.gz"

# Extract the tar package
tar -xzf "${FASTPROXY_HOME}/${FILE}.tar.gz" -C "${FASTPROXY_HOME}/bin"
mv "${FASTPROXY_HOME}/bin/${FILE}" "${FASTPROXY_HOME}/bin/fp"


# Remove the tar package and extracted file
rm -f "${FASTPROXY_HOME}/${FILE}.tar.gz"
rm -f "${FASTPROXY_HOME}/bin/${FILE}"

echo "fastproxy has been installed to ${FASTPROXY_HOME}/bin"

echo "Please use the 'source' command to apply the changes immediately: \033[1;32msource ${SHELL_CONFIG_FILE}\033[0m"
