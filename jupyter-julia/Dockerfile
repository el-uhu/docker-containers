FROM julia:latest

MAINTAINER Lukas Hutter <luki.hutter@gmail.com>

# Setup system
RUN apt-get update && apt-get install -yq --no-install-recommends \
  git \
  nano \
  jed \
  wget \
  build-essential \
  python-dev \
  python-pip \
  ca-certificates \
  bzip2 \
  unzip \
  libsm6 \
  pandoc \
  texlive-latex-base \
  texlive-latex-extra \
  texlive-fonts-extra \
  texlive-fonts-recommended \
  texlive-generic-recommended \
  sudo \
  locales \
  libxrender1 \
  fonts-dejavu \
  gfortran \
  gcc \
  libnettle4 \
  python-scipy \
  python-numpy \
  python-matplotlib \
  && apt-get clean

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Install python requirements
RUN pip install jupyter \
  ipywidgets

RUN sudo useradd -m -d /home/nbuser -s /bin/bash -c "Notebookuser" -U nbuser

USER nbuser

COPY julia_packages.json /home/nbuser/julia_packages.json
COPY install_dependencies.jl /home/nbuser/install_dependencies.jl
COPY juliarc.jl /home/nbuser/.juliarc.jl
COPY XPPjl /home/nbuser/XPPjl

RUN julia /home/nbuser/install_dependencies.jl

EXPOSE 8888

CMD ["julia"]
