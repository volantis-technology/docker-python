# docker-python

[![](https://img.shields.io/badge/GitHub-%E2%86%92-brightgreen.svg)](https://github.com/volantis-technology/docker-python) [![](https://img.shields.io/badge/Docker%20Hub-%E2%86%92-blue.svg)](https://hub.docker.com/r/volantis/python)

## Introduction

This repo contains necesary files to build docker image for Python.

Things that will be installed:

- everything in [volantis/debian:stretch](https://hub.docker.com/r/volantis/debian)
- everything in [Miniconda3](https://repo.continuum.io/miniconda)
- [CPython 3.7.x](https://github.com/python/cpython)
- [ipython](https://ipython.org/)
- [ptpython](https://github.com/prompt-toolkit/ptpython)

## How to build

- clone this repo
```bash
git clone https://github.com/volantis-technology/docker-python.git && cd docker-python
```

- build the image
```bash
docker build . -t python
```

- check by running the image
```bash
docker run -it --rm python
```

## Maintainer

Akrom Khasani
> akrom (at) volantis (dot) io
