PWD:=$(shell pwd)
CONTAINER:=$(shell docker ps -a | grep "tgiw-store:latest" | cut -f 1 -d " ")

default:
	docker build -t tgiw-store .

app:
	docker run -v $(PWD):/tgiw-store -it tgiw-store:latest ./provision.sh

save:
	docker commit $(CONTAINER) tgiw-store
	docker rm $(CONTAINER)

new:
	docker run --name tgiw-store -v $(PWD):/tgiw-store -p 3000:3000 -p 3306:3306 -it tgiw-store:latest

run:
	docker start -i $(CONTAINER)

