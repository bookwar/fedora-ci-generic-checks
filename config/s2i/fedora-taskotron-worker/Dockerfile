FROM fedora:latest
LABEL maintainer "https://github.com/tflink/fedora-ci-generic-checks"
LABEL description="This container is meant to \
run legacy taskotron tasks."


# Set the labels that are used for OpenShift to describe the builder image.
LABEL io.k8s.description="Fedora taskotron-worker" \
    io.k8s.display-name="Fedora:latest taskotron-worker" \
    io.openshift.tags="builder,fedora-ci" \
    # this label tells s2i where to find its mandatory scripts
    # (run, assemble, save-artifacts)
    io.openshift.s2i.scripts-url="image:///usr/libexec/s2i"

# we need dnf-plugins-core to interface with copr
RUN dnf -y install dnf-plugins-core

# Install all package requirements
RUN dnf -y install ansible \
        curl \
        file \
        findutils \
        git \
        python3-libselinux \
        python3-dnf \
        python3-devel \
        python3-pyyaml \
        rpm-build \
        rsync \
        sudo \
        wget \
        libtaskotron \
        rpmdeplint \
        rpmlint \
        && dnf clean all


# create the workdir for jenkins
RUN mkdir -p /tmp/workspace/fedora-taskotron-check
#RUN chmod -R 777 /workDir

# Copy the build scripts to the container
COPY run-task.sh /tmp/

# Run the build script
# assumes that target ENVR is available as $TARGET_ENVR
ENTRYPOINT ["bash", "/tmp/run-task.sh"]
#CMD ["/usr/libexec/s2i/usage"]
