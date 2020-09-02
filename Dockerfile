FROM aergus/latex

COPY auto-install.xml /verapdf/auto-install.xml
COPY KEY /verapdf/KEY

RUN apt-get update && apt-get install -y gpg && \
    # Download veraPDF
    cd verapdf && \
    wget https://downloads.verapdf.org/rel/verapdf-installer.zip && \
    wget https://downloads.verapdf.org/rel/verapdf-installer.zip.asc && \
    # Add veraPDFs public GPG key
    gpg --import KEY && \
    # Verify signature
    gpg --verify verapdf-installer.zip.asc && \
    # Install veraPDF
    unzip verapdf-installer.zip && \
    cd verapdf-greenfield-* && \
    ./verapdf-install ../auto-install.xml && \
    ln -s /usr/share/verapdf/verapdf /usr/bin/verapdf && \
    # Test success
    verapdf --version && \
    # Cleanup
    rm -r /verapdf && \
    # Remove more unnecessary stuff
    apt-get clean -y