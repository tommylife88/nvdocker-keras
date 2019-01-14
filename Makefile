IMAGE=nvdocker-keras
VERSION=1.0.0
CONTAINER=nvdocker-keras

build:
	docker build -t $(IMAGE):$(VERSION) .

restart: stop start

start:
	docker run \
		--runtime=nvidia \
		-itd \
		-p 8888:8888 \
		-v $(HOME):$(HOME) \
		-v /etc/localtime:/etc/localtime:ro \
		--name $(CONTAINER) \
		--workdir=`pwd` \
		$(IMAGE):$(VERSION)

contener=`docker ps -a | grep $(CONTAINER) | awk '{print $$1}'`
image=`docker images | grep $(IMAGE) | grep $(VERSION) | awk '{ print $$3 }'`

clean: rm
	@if [ "$(image)" != "" ] ; then \
		docker rmi $(image); \
	fi

rm:
	@if [ "$(contener)" != "" ] ; then \
		docker rm -f $(contener); \
	fi

stop:
	@if [ "$(contener)" != "" ] ; then \
		docker rm -f $(contener); \
	fi

attach:
	docker exec -it $(CONTAINER) bash

logs:
	docker logs $(CONTAINER)
