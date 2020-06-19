FROM amazonlinux as BUILDER

RUN yum update -y && yum clean all

ENV BUILD_PACKAGES='\
    autoconf \
    automake \
    gcc \
    libpcap-devel \
    make \
    ncurses-devel \
    '

RUN yum install ${BUILD_PACKAGES} -y && yum clean all

RUN mkdir -p /opt/build && \
    mkdir -p /opt/installroot

# declaring a directory to do all my work
WORKDIR /opt/build

# Copying all of my files into tmp
COPY . ./

RUN ./bootstrap.sh
RUN ./configure --prefix /opt/installroot
RUN make
RUN make install 


# Building the smallest image
FROM amazonlinux as RUNTIME

# Dependencies for small image
ENV RUNTIME_PACKAGES='\
    libpcap\
    '

# Updating the runtime
RUN yum update -y && yum clean all

# Install dependencies for runtime
RUN yum install ${RUNTIME_PACKAGES} -y  && yum clean all

# Copy compiled versions from our builder step
COPY --chown=root:root --from=BUILDER /opt/installroot/bin/* /usr/local/bin/
COPY --chown=root:root --from=BUILDER /opt/installroot/etc/* /usr/local/etc/
COPY --chown=root:root --from=BUILDER /opt/installroot/share/* /usr/local/share/
