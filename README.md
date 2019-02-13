[![](https://img.shields.io/badge/Docker%20Hub-%E2%86%92-blue.svg?style=flat-square&logo=docker&logoColor=white)](https://hub.docker.com/r/volantis/python)

# Docker Python

[![](https://img.shields.io/badge/Python-3.7.x-orange.svg?style=flat-square&logo=python&logoColor=white)](https://www.python.org)

## Introduction

This repo contains necesary files to build docker image for Python + Falcon framework.

Things that will be installed:

- everything in [volantis/python:3.7](https://hub.docker.com/r/volantis/python)
- [falcon 1.4.1](https://falconframework.org)
- [ujson 1.35](https://github.com/esnme/ultrajson)
- [gunicorn 19.9.0](https://gunicorn.org)
- [gevent 1.4.0](http://www.gevent.org)
- [meinheld 0.6.1](https://github.com/mopemope/meinheld)
- [WebTest==2.0.33](https://docs.pylonsproject.org/projects/webtest)

## How to build

- clone this repo

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

[![](https://img.shields.io/badge/Made%20with%20&hearts;-@VolantisIO-orange.svg?style=flat-square)](https://volantis.io)
