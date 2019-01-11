# nvdocker-keras

## Requirements

* [Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [nvidia-docker](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-2.0)#prerequisites)
* [CUDA](https://github.com/NVIDIA/nvidia-docker/wiki/CUDA#requirements)

## Usage

```bash
$ docker build -t test/nvdocker-tf:1 .
$ docker run --runtime=nvidia -d -it --name "test" -v /etc/localtime:/etc/localtime:ro --restart=always "test/nvdocker-tf:1"
$ docker exec -it test bash
$ git clone https://github.com/fchollet/keras.git
$ cd keras/examples
$ python mnist_cnn.py
```
