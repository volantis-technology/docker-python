FROM volantis/debian:stretch

# Install necessary packages
RUN apt-get-install bzip2

# Add additional configuration files
ADD ./environment.yml /usr/local/
ADD ./pip.conf /etc/

# Install python
ARG MINICONDA_VERSION=latest
ENV MINICONDA_HOME=/usr/local/miniconda
ENV PATH=${MINICONDA_HOME}/bin:${PATH}
RUN curl -skSL -O https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    /bin/bash Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p ${MINICONDA_HOME} && \
    rm -f Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    conda update -y -q -n base conda pip && \
    conda env update -q -f /usr/local/environment.yml && \
    conda clean -y -q -a && \
    rm -rf ${MINICONDA_HOME}/pkgs/ && \
    chown -R ${DEFAULT_USER}:${DEFAULT_USER} ${MINICONDA_HOME} && \
    \
    ln -sf ${MINICONDA_HOME}/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". ${MINICONDA_HOME}/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    echo ". ${MINICONDA_HOME}/etc/profile.d/conda.sh" >> /home/${DEFAULT_USER}/.bashrc && \
    echo "conda activate base" >> /home/${DEFAULT_USER}/.bashrc

# Execute command
CMD [ "ptipython" ]

# vim:set ft=dockerfile sw=4 ts=4:
