up:
	docker-compose up -d

down:
	docker-compose down

restart: down up

in:
	docker exec -it --env COLUMNS=`tput cols` --env LINES=`tput lines` --user www-data httpd bash

xdebug-on:
	docker exec php xdebug-php.sh 1

xdebug-off:
	docker exec php xdebug-php.sh 0
