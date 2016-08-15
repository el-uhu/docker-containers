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
RUN mkdir /home/nbuser/.jupyter
RUN chown -R nbuser:users /home/nbuser/.jupyter

USER nbuser
# RUN mkdir /home/nbuser/notebooks

COPY julia_packages.json /home/nbuser/julia_packages.json
COPY install_dependencies.jl /home/nbuser/install_dependencies.jl
RUN julia /home/nbuser/install_dependencies.jl
COPY juliarc.jl /home/nbuser/.juliarc.jl
COPY XPPjl /home/nbuser/XPPjl
COPY jupyter_notebook_config.py /home/nbuser/.jupyter/jupyter_notebook_config.py

RUN git clone https://github.com/el-uhu/thesis-notebooks.git /home/nbuser/thesis-notebooks

EXPOSE 8888
WORKDIR /home/nbuser/thesis-notebooks

CMD ["julia"]
