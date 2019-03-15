FROM volantis/debian:stretch AS builder

ADD ./environment.yml /opt/
ADD ./pip.conf /etc/

ARG MINICONDA_VERSION=latest
RUN apt-get-install bzip2 && \
    curl -skSLO https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    bash Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -f -b -p /opt/miniconda && \
    /opt/miniconda/bin/conda update -y -n base python conda pip && \
    /opt/miniconda/bin/conda update -y -n base --all && \
    /opt/miniconda/bin/conda env update -v -f /opt/environment.yml && \
    /opt/miniconda/bin/conda clean -q -y -a && \
    rm -rf /opt/miniconda/pkgs


FROM volantis/debian:stretch

# Install python
ENV MINICONDA_HOME=/usr/local/miniconda
COPY --from=builder /opt/miniconda ${MINICONDA_HOME}/
ENV PATH=${MINICONDA_HOME}/bin:${PATH}

# Add pip config
ADD ./pip.conf /etc/

# vim:set ft=dockerfile sw=4 ts=4:
