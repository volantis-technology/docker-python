#!/bin/bash
set -e

if [[ -n ${CONDA_INSTALL_PACKAGES} ]]; then
    conda install -S -y ${CONDA_INSTALL_PACKAGES}
    conda clean -q -y -a
fi

if [[ -n ${PIP_INSTALL_PACKAGES} ]]; then
    pip install ${PIP_INSTALL_PACKAGES}
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
