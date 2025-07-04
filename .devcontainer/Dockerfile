FROM fedora:latest

# Update and install packages
RUN dnf -y makecache && \
    dnf -y install \
        axel \
        zsh \
        git \
        wget \
        ripgrep \
        unzip \
        openssh-server \
        neovim \
        sudo && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# Create user 'dev' with home dir and zsh as default shell
RUN useradd -m -s /bin/zsh dev && \
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## Android-ndk stuff
RUN mkdir -p /opt/
RUN wget -P /opt/ "https://dl.google.com/android/repository/android-ndk-r27c-linux.zip"
RUN unzip /opt/android-ndk-r27c-linux.zip -d /opt/
RUN rm -rf /opt/android-ndk-r27c-linux.zip

# Switch to the new user
USER dev
WORKDIR /home/dev

# Install Rust non-interactively
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Add Cargo bin to PATH (for future RUN instructions)
ENV PATH="/home/dev/.cargo/bin:${PATH}"

# Set default shell
SHELL ["/bin/zsh", "-c"]

## Add ohmyzsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

## omz extensions, 1) fzf-tab
RUN git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

## Use custom zsh file
RUN curl "https://raw.githubusercontent.com/FG-rps/test_repo/refs/heads/main/zshrc" > /home/dev/.zshrc

## setup android cross-compilation
RUN rustup target add aarch64-linux-android

## Nvim stuff
RUN mkdir -p ~/.local/share
RUN mkdir -p ~/.local/share/fonts

RUN curl "https://raw.githubusercontent.com/FG-rps/test_repo/refs/heads/main/CaskaydiaCoveNerdFont-Regular.ttf" > ~/.local/share/fonts/CaskaydiaCoveNerdFont-Regular.ttf
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim
RUN rm ~/.config/nvim/init.lua
RUN curl "https://raw.githubusercontent.com/FG-rps/test_repo/refs/heads/main/init.lua" > ~/.config/nvim/init.lua

