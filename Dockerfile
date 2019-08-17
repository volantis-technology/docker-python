# syntax = docker/dockerfile:1.1-experimental

FROM volantis/debian:stretch AS builder

ARG MINICONDA_VERSION=latest
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/lib/apt/lists \
    --mount=type=cache,target=/tmp \
    apt-get -q update && apt-get install -y --no-install-recommends bzip2 && \
    curl -kSL -C - -o /tmp/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh && \
    bash /tmp/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -b -p /usr/local/miniconda && \
    /usr/local/miniconda/bin/conda clean -q -y -a && \
    rm -rf /usr/local/miniconda/pkgs
ADD ./.condarc /usr/local/miniconda/
ADD ./pinned /usr/local/miniconda/conda-meta/
RUN --mount=type=cache,target=/usr/local/miniconda/pkgs \
    /usr/local/miniconda/bin/conda install conda==4.6.* && \
    /usr/local/miniconda/bin/conda update python pip && \
    /usr/local/miniconda/bin/conda update --all


FROM volantis/debian:stretch

# Install python
ENV MINICONDA_HOME=/usr/local/miniconda
ENV PATH=${MINICONDA_HOME}/bin:${PATH}
ENV EXTRA_CONDA_PACKAGES= EXTRA_PIP_PACKAGES=
COPY --from=builder /usr/local/miniconda ${MINICONDA_HOME}/

# Add pip config
ADD ./pip.conf /etc/

# Modify package pinning and entrypoint
ADD ./entrypoint.sh /usr/local/bin/
RUN python -c "import sys; print('python=={}.{}.{}'.format(*sys.version_info[:3]))" \
        > ${MINICONDA_HOME}/conda-meta/pinned && \
    echo "conda==4.6.*" >> ${MINICONDA_HOME}/conda-meta/pinned && \
    chmod a+x /usr/local/bin/entrypoint.sh

# vim:set ft=dockerfile sw=4 ts=4:
