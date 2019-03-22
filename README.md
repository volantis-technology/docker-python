[![](https://img.shields.io/badge/Docker%20Hub-%E2%86%92-blue.svg?style=flat-square&logo=docker&logoColor=white)](https://hub.docker.com/r/volantis/python)

# Docker Python

[![](https://img.shields.io/badge/Python-3.7.x-orange.svg?style=flat-square&logo=python&logoColor=white)](https://www.python.org)

## Introduction

This repo contains necesary files to build docker image for Python.

Things that will be installed:

- everything in [volantis/debian:stretch](https://hub.docker.com/r/volantis/debian)
- everything in [Miniconda3](https://repo.continuum.io/miniconda)
- [CPython 3.7.x](https://github.com/python/cpython)

## How to build

- clone this repo

- build the image
  ```bash
  docker build . -t python
  ```

- check by running the image
  ```bash
  docker run -it --rm python
  ```

## Maintainer

Akrom Khasani | `akrom (at) volantis (dot) io`

[![](https://img.shields.io/badge/Made%20with%20&hearts;-@VolantisIO-orange.svg?style=flat-square)](https://volantis.io)
