all: re

re:
	docker compose -f ./srcs/docker-compose.yml up -d --build


start:
	docker compose -f ./srcs/docker-compose.yml start

stop:
	docker compose  -f ./srcs/docker-compose.yml stop


clean : 
	docker compose -f ./srcs/docker-compose.yml down
	docker rmi -f $$(docker images -qa)


i:
	docker images

s:
	docker ps

sa:
	dcoker ps -a



.PHONY: start clean stop i s sa
