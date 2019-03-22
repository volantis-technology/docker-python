FROM volantis/debian:stretch AS builder

ADD ./environment.yml /usr/local/
ADD ./pip.conf /etc/

ARG MINICONDA_VERSION=latest
RUN apt-get-install bzip2 && \
    curl -skSLO https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    bash Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p /usr/local/miniconda && \
    /usr/local/miniconda/bin/conda update -y -n base python conda pip && \
    /usr/local/miniconda/bin/conda update -y -n base --all && \
    /usr/local/miniconda/bin/conda env update -v -f /usr/local/environment.yml && \
    /usr/local/miniconda/bin/conda clean -q -y -a && \
    rm -rf /usr/local/miniconda/pkgs


FROM volantis/debian:stretch

# Install python
ENV MINICONDA_HOME=/usr/local/miniconda
COPY --from=builder /usr/local/miniconda ${MINICONDA_HOME}/
ENV PATH=${MINICONDA_HOME}/bin:${PATH}

# Add pip config
ADD ./pip.conf /etc/

# vim:set ft=dockerfile sw=4 ts=4:
