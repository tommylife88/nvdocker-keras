# nvdocker-keras

## Requirements

* [Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [nvidia-docker](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-2.0)#prerequisites)
* [CUDA](https://github.com/NVIDIA/nvidia-docker/wiki/CUDA#requirements)

## Running the container

Using Makefile to simplify docker commands within make commands.

### build image

```bash
$ make build
```

### start container

```bash
$ make start
```

### attach container

```bash
$ make attach
```

### stop container

```bash
$ make stop
```

### clean container and images

```bash
$ make clean
```

## Keras example

```bash
$ make build
$ make start
$ make attach
$ git clone https://github.com/fchollet/keras.git
$ cd keras/examples
$ python mnist_cnn.py
```
