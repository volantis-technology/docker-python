FROM volantis/debian:stretch

# Add additional configuration files
ADD ./environment.yml /usr/local/
ADD ./pip.conf /etc/

# Install python
ARG MINICONDA_VERSION=latest
ENV MINICONDA_HOME=/usr/local/miniconda
ENV PATH=${MINICONDA_HOME}/bin:${PATH}
RUN apt-get-install bzip2 && \
    curl -skSLO https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    /bin/bash Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p ${MINICONDA_HOME} && \
    rm -f Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    apt-get-remove bzip2 && \
    conda update -y -q -n base python conda pip && \
    conda update -y -q -n base --all && \
    conda env update -q -f /usr/local/environment.yml && \
    conda clean -y -q -a && \
    rm -rf ${MINICONDA_HOME}/pkgs/

# Execute command
CMD [ "noroot", "python" ]

# vim:set ft=dockerfile sw=4 ts=4:
