FROM julia:latest

MAINTAINER Lukas Hutter <luki.hutter@gmail.com>

# Build fails in the middle due to repo-access issues thus try this (http://serverfault.com/questions/690639/api-get-error-reading-from-server-under-docker)
RUN apt-get clean && apt-get update

# Setup system
RUN apt-get install -yq --no-install-recommends \
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
  libsm6

# Setup system
RUN apt-get clean && apt-get update
RUN apt-get install -yq --no-install-recommends \
  pandoc \
  texlive-latex-base \
  texlive-latex-extra \
  texlive-fonts-extra \
  texlive-fonts-recommended \
  texlive-generic-recommended \
  sudo \
  locales \
  libxrender1 \
  fonts-dejavu

# Setup system
RUN apt-get clean && apt-get update
RUN apt-get install -yq --no-install-recommends \
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
RUN pip install jupyter
RUN pip install ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension
RUN git clone https://github.com/ipython-contrib/jupyter_contrib_nbextensions.git jupyter_contrib_nbextensions
RUN pip install -e jupyter_contrib_nbextensions

# Add user and make home folder
RUN sudo useradd -m -d /home/nbuser -s /bin/bash -c "Notebookuser" -U nbuser
RUN mkdir /home/nbuser/.jupyter
RUN chown -R nbuser:users /home/nbuser/.jupyter

# Change user
USER nbuser
RUN jupyter contrib nbextension install --user
# RUN mkdir /home/nbuser/notebooks

# Copy static files
COPY julia_packages.json /home/nbuser/julia_packages.json
COPY install_dependencies.jl /home/nbuser/install_dependencies.jl
RUN julia /home/nbuser/install_dependencies.jl
COPY juliarc.jl /home/nbuser/.juliarc.jl

RUN git clone https://github.com/novakgroupoxford/XPPjl /home/nbuser/XPPjl
RUN git clone https://github.com/el-uhu/thesis-notebooks.git /home/nbuser/thesis-notebooks
RUN git clone https://github.com/novakgroupoxford/PPSIM.git /home/nbuser/PPSIM
RUN git clone https://github.com/novakgroupoxford/2015_Mirkovic_et_al.git /home/nbuser/2015_Mirkovic_et_al
RUN git clone https://github.com/novakgroupoxford/2016_Cundell_et_al.git /home/nbuser/2016_Cundell_et_al
COPY jupyter_notebook_config.py /home/nbuser/.jupyter/jupyter_notebook_config.py
COPY start.sh /home/nbuser/start.sh
COPY precompile_key_packages.jl /home/nbuser/precompile_key_packages.jl
RUN julia /home/nbuser/precompile_key_packages.jl

COPY table.txt /home/nbuser/thesis-notebooks/Chapter5/data/bigtable/table.txt

EXPOSE 8888
WORKDIR /home/nbuser/thesis-notebooks

ENTRYPOINT ["bash", "-C", "/home/nbuser/start.sh"]
CMD ["bash"]
