VOL_M = mariadb
VOL_W = wordpress


all: 	vol
	sudo docker compose -f ./srcs/docker-compose.yml up -d --build


vol:
	mkdir -p $(VOL_M)
	mkdir -p $(VOL_W)
	#sudo chown -R $(USER):$(USER) $(VOL_M)
	#sudo chown -R $(USER):$(USER) $(VOL_W)

rmvol:
	sudo docker volume rm mariadb_vol wordpress_vol	
	sudo rm -rf $(VOL_M) $(VOL_W)


start:
	sudo docker compose -f ./srcs/docker-compose.yml start

stop:
	sudo docker compose  -f ./srcs/docker-compose.yml stop



clean : 
	sudo docker compose -f ./srcs/docker-compose.yml down
	sudo docker rmi -f $$(docker images -qa)

fclean: clean rmvol
	sudo docker system prune -af --volumes



restart:
	systemctl restart docker

reset:
	sudo docker stop $$(docker ps -qa); \
	sudo docker rm $$(docker ps -qa); \
	sudo docker rmi -f $$(docker images -qa); \
	sudo docker volume rm $$(docker volume ls -q); \
	sudo docker network rm $$(docker network ls -q) 2>/dev/null


logs:
	sudo docker compose -f ./srcs/docker-compose.yml logs

i:
	docker images

s:
	docker ps

sa:
	docker ps -a



.PHONY: start clean stop i s sa
