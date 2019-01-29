FROM volantis/python:3.7

# Install packages specified in requirements.txt
ADD ./requirements.txt /usr/local/
RUN apt-get-install g++ && \
    pip install -q -r /usr/local/requirements.txt && \
    apt-get-remove g++

# vim:set ft=dockerfile sw=4 ts=4:
