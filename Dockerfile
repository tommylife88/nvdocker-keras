FROM nvidia/cuda:9.0-cudnn7-runtime

LABEL maintainer "thatta"

# Set environment
ENV TERM xterm
ENV LANG C.UTF-8

# Install apt package.
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    apt-utils \
    vim \
    less \
    wget \
    curl \
    git \
    unzip \
    imagemagick \
    bzip2 \
    build-essential \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    llvm \
    tk-dev \
    xz-utils \
    zlib1g-dev \
    python-dev \
    ca-certificates

# Install pyenv.
RUN git clone https://github.com/pyenv/pyenv.git /opt/pyenv && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
ENV PYENV_ROOT /opt/pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

CMD ["$PYENV_ROOT/plugins/python-build/install.sh"]

# Create python 3.6 environment and install pipenv.
#
RUN pyenv install 3.6.0 && \
    pyenv global 3.6.0 && \
    eval "$(pyenv init -)"

# Install python library.
RUN pip install --upgrade pip && \
    pip install --ignore-installed \
    NumPy==1.15.4 \
    pandas==0.23.4 \
    SciPy==1.2.0 \
    scikit-learn==0.20.2 \
    matplotlib==3.0.2 \
    jupyter==1.0.0 \
    notebook==5.7.4 \
#    https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.12.0-cp36-cp36m-linux_x86_64.whl \
    tensorflow_gpu==1.12.0 \
    keras==2.2.4 \
    pydot==1.4.1

# Downgrade cuDNN library,
# TensorFlows issue: https://github.com/tensorflow/tensorflow/issues/17566#issuecomment-372490062
# RUN apt-get install -y --allow-downgrades --allow-change-held-packages libcudnn7=7.0.5.15-1+cuda9.0
RUN apt-get install -y --allow-downgrades --allow-change-held-packages libcudnn7=7.1.4.18-1+cuda9.0

# Clean
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Set warking directory.
WORKDIR /root

CMD /bin/bash
