PWD:=$(shell pwd)
CONTAINER:=$(shell docker ps -a | grep "tgiw-store:latest" | cut -f 1 -d " ")

# build docker for dev env
dev-build:
	docker build -t tgiw-store .

# provision docker container
dev-provision:
	docker run -v $(PWD):/tgiw-store -it tgiw-store:latest ./provision.sh

# save docker container
dev-save:
	docker commit $(CONTAINER) tgiw-store
	docker rm $(CONTAINER)

# create a new docker container
dev-new:
	docker run --name tgiw-store -v $(PWD):/tgiw-store -p 3000:3000 -p 8306:3306 -it tgiw-store:latest /bin/bash

# start existing docker container
dev-run:
	docker start -i $(CONTAINER)

# for production provisioning
provision:
	./provision.sh

# for deploying to production
deploy:
	docker exec $(CONTAINER) ./deploy.sh

.PHONY: no_targets__ list
no_targets__:
list:
	sh -c "$(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | sort"
