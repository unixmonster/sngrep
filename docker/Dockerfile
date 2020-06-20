FROM amazonlinux as BUILDER

RUN yum update -y && yum clean all

ENV BUILD_PACKAGES='\
    autoconf \
    automake \
    gcc \
    gnutls-devel \
    libgcrypt-devel \
    libpcap-devel \
    make \
    ncurses-devel \
    pcre-devel \
    '

RUN yum install ${BUILD_PACKAGES} -y && yum clean all

RUN mkdir -p /opt/build && \
    mkdir -p /opt/installroot

# declaring a directory to do all my work
WORKDIR /opt/build

# Copying all of my files into tmp
COPY . ./

RUN ./bootstrap.sh
RUN ./configure --prefix /opt/installroot \
    --with-gnutls \
    --with-pcre \
    --enable-unicode \
    --enable-ipv6 \
    --enable-eep
RUN make
RUN make install 


# Building the smallest image
FROM amazonlinux as RUNTIME

# Dependencies for small image
ENV RUNTIME_PACKAGES='\
    gnutls \
    libpcap \
    '

# Updating the runtime
RUN yum update -y && yum clean all

# Install dependencies for runtime
RUN yum install ${RUNTIME_PACKAGES} -y  && yum clean all

COPY --chown=root:root docker/vars.sh docker/sngrep-launch.sh /usr/local/sbin/
COPY --chown=root:root docker/sngrep-launcher-install.sh /usr/local/sbin/install 

# Copy compiled versions from our builder step
COPY --chown=root:root --from=BUILDER /opt/installroot/bin /usr/local/bin/
COPY --chown=root:root --from=BUILDER /opt/installroot/bin /opt/sngrep/bin/
COPY --chown=root:root --from=BUILDER /opt/installroot/etc /usr/local/etc/
COPY --chown=root:root --from=BUILDER /opt/installroot/etc /opt/sngrep/etc/
COPY --chown=root:root --from=BUILDER /opt/installroot/share /usr/local/share/
COPY --chown=root:root --from=BUILDER /opt/installroot/share /opt/sngrep/share/
