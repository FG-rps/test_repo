FROM fedora:latest

# Update and install packages
RUN dnf -y update && \
    dnf -y install \
        axel \
        zsh \
        git \
        wget \
        curl \
        gradle \
        ripgrep \
        unzip \
        sudo && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# Create user 'dev' with home dir and zsh as default shell
RUN useradd -m -s /bin/zsh dev && \
    echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

## Android-ndk stuff
RUN mkdir /opt/
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

## Use custom zsh file
RUN curl "https://raw.githubusercontent.com/FG-rps/test_repo/refs/heads/main/zshrc" > /home/dev/.zshrc
