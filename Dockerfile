FROM volantis/debian:stretch AS builder

ARG MINICONDA_VERSION=latest
RUN apt-get-install bzip2 && \
    curl -skSLO https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    bash Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -b -p /usr/local/miniconda && \
    /usr/local/miniconda/bin/conda clean -q -y -a && \
    rm -rf /usr/local/miniconda/pkgs
ADD ./pinned /usr/local/miniconda/conda-meta/
RUN /usr/local/miniconda/bin/conda update -y -n base python conda pip && \
    /usr/local/miniconda/bin/conda update -y -n base --all && \
    /usr/local/miniconda/bin/conda clean -q -y -a && \
    rm -rf /usr/local/miniconda/pkgs


FROM volantis/debian:stretch

# Install python
ENV MINICONDA_HOME=/usr/local/miniconda
COPY --from=builder /usr/local/miniconda ${MINICONDA_HOME}/
ENV PATH=${MINICONDA_HOME}/bin:${PATH}
ENV CONDA_INSTALL_PACKAGES= PIP_INSTALL_PACKAGES=

# Add conda config
ADD ./condarc ${MINICONDA_HOME}/

# Add pip config
ADD ./pip.conf /etc/

# Modify entrypoint
ADD ./entrypoint.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/entrypoint.sh

# vim:set ft=dockerfile sw=4 ts=4:
