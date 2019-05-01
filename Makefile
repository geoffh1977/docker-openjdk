# Project Makefile
include container.conf
export $(shell sed 's/=.*//' container.conf)

.PHONY: build update run all clean

all: build

build:
	docker build -t ${dockerUser}/${finalImageName}${javaMajorVersion}:${finalImageVersion} --build-arg IMAGE_USER=${dockerUser} --build-arg IMAGE_NAME="${buildImageName}" --build-arg IMAGE_VERSION=${buildImageVersion} --build-arg OPENJDK_VERSION=${finalImageVersion} .
	docker tag ${dockerUser}/${finalImageName}${javaMajorVersion}:${finalImageVersion} ${dockerUser}/${finalImageName}${javaMajorVersion}:latest

update:
	@tools/update_version.sh

run:
	$(call colors)
	@echo -e Starting Container...
	@docker run -it --rm ${dockerUser}/${finalImageName}${javaMajorVersion}:${finalImageVersion}
	@echo -e Container Stopped

clean:
	docker rmi -f ${dockerUser}/${finalImageName}${javaMajorVersion}:latest
	docker rmi -f ${dockerUser}/${finalImageName}${javaMajorVersion}:${finalImageVersion}
