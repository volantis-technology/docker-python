[![](https://img.shields.io/badge/GitHub-%E2%86%92-brightgreen.svg)](https://github.com/volantis-technology/docker-python) [![](https://img.shields.io/badge/Docker%20Hub-%E2%86%92-blue.svg)](https://hub.docker.com/r/volantis/python)

# docker-python

## Introduction

This repo contains necesary files to build docker image for Python + Falcon framework.

Things that will be installed:

- everything in [volantis/python:3.7](https://hub.docker.com/r/volantis/python)
- [falcon 1.4.1](https://falconframework.org)
- [ujson 1.35](https://github.com/esnme/ultrajson)
- [gunicorn 19.9.0](https://gunicorn.org)
- [gevent 1.4.0](http://www.gevent.org)
- [meinheld 0.6.1](https://github.com/mopemope/meinheld)

## How to build

- clone this repo
```bash
git clone https://github.com/volantis-technology/docker-python.git && cd docker-python && git checkout 3.7-falcon
```

- build the image
```bash
docker build . -t python:falcon
```

- check by running the image
```bash
docker run -it --rm python:falcon
```

## Maintainer

Akrom Khasani | `akrom (at) volantis (dot) io`

[![](https://img.shields.io/badge/Made%20with%20&#9829;-@VolantisIO-ff69b4.svg)](https://volantis.io)
