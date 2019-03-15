FROM volantis/debian:stretch AS builder

ADD ./environment.yml /usr/local/
ADD ./pip.conf /etc/

ARG MINICONDA_VERSION=latest
ARG MINICONDA_HOME=/usr/local/miniconda
RUN apt-get-install bzip2 && \
    curl -skSLO https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    bash Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p ${MINICONDA_HOME} && \
    rm -f Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    apt-get-remove bzip2 && \
    ${MINICONDA_HOME}/bin/conda update -y -n base python conda pip && \
    ${MINICONDA_HOME}/bin/conda update -y -n base --all && \
    ${MINICONDA_HOME}/bin/conda env update -f /usr/local/environment.yml && \
    ${MINICONDA_HOME}/bin/conda clean -y -q -a && \
    rm -rf ${MINICONDA_HOME}/pkgs/


FROM volantis/debian:stretch

# Install python
ENV MINICONDA_HOME=/usr/local/miniconda
COPY --from=builder ${MINICONDA_HOME} ${MINICONDA_HOME}/
ENV PATH=${MINICONDA_HOME}/bin:${PATH}

# Add pip config
ADD ./pip.conf /etc/

CMD [ "noroot", "python" ]

# vim:set ft=dockerfile sw=4 ts=4:
