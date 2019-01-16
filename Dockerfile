FROM nvidia/cuda:9.0-cudnn7-devel

LABEL maintainer "thatta"

# Set environment
ENV TERM xterm
ENV LC_ALL=C.UTF-8
ENV LANG C.UTF-8

# Install apt package.
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -y && apt-get install -y --no-install-recommends \
    apt-utils \
    less \
    wget \
    curl \
    git \
    graphviz \
    unzip \
    bzip2 \
    build-essential \
    vim \
    libncursesw5-dev \
    libgdbm-dev \
    libc6-dev \
    zlib1g-dev \
    libsqlite3-dev \
    tk-dev \
    libssl-dev \
    openssl \
    libbz2-dev \
    libreadline-dev

# Install pyenv.
RUN git clone https://github.com/pyenv/pyenv.git /opt/pyenv && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
ENV PYENV_ROOT /opt/pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN $PYENV_ROOT/plugins/python-build/install.sh

# Create python 3.6 environment and install pipenv.
RUN pyenv install 3.6.0 && \
    pyenv global 3.6.0 && \
    eval "$(pyenv init -)"

# Upgrade pip.
RUN pip install --upgrade pip

# Install python library.
RUN pip install --ignore-installed \
    keras==2.2.4 \
    h5py \
    jupyter \
    matplotlib \
    notebook \
    NumPy \
    pandas \
    pydot \
    scikit-learn \
    SciPy \
    tensorflow_gpu==1.12.0 \
    jupyter_contrib_nbextensions

# Enable nbextension. 
RUN jupyter contrib nbextension install --user

# Downgrade cuDNN library.
# TensorFlows issue: https://github.com/tensorflow/tensorflow/issues/17566#issuecomment-372490062
# RUN apt-get install -y --allow-downgrades --allow-change-held-packages libcudnn7=7.0.5.15-1+cuda9.0
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --allow-downgrades --allow-change-held-packages libcudnn7=7.1.4.18-1+cuda9.0

# Clean cache.
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

EXPOSE 8888

# Run jupyter notebook.
CMD ["jupyter", "notebook", "--allow-root", "--port=8888", "--ip=0.0.0.0"]
