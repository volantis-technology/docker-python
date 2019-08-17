#!/bin/bash
set -e

if [[ -n ${EXTRA_CONDA_PACKAGES} ]]; then
    conda install -S ${EXTRA_CONDA_PACKAGES}
    conda clean -q -a
    rm -rf /usr/local/miniconda/pkgs
fi

if [[ -n ${EXTRA_PIP_PACKAGES} ]]; then
    pip install --no-cache-dir ${EXTRA_PIP_PACKAGES}
fi

case $1 in
noroot)
    shift
    echo "==> executing as non-root user: $@"
    exec gosu ${DEFAULT_USER} $@
  ;;
*)
    echo "==> executing as root user: $@"
    cmdline="$@"
    exec ${cmdline:-"bash"}
  ;;
esac

# vim:set ft=sh ff=unix:
