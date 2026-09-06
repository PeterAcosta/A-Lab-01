# Proporciona ayuda
.PHONY: help
help: ## Comando de ayuda
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'



bake: ##        Usa docker compose BAKE para construir y levantar los contenedores
	COMPOSE_BAKE=true docker compose up -d



show_me_all: ## me muestra las imagenes y los contenedores:
	clear
	@echo "=============================================================================================================================="
	docker stats --no-stream
	@echo "\n=============================================================================================================================="
	docker images
	@echo "\n==============================================================================================================================\nContenedores activos:"
#   @echo "\n-------------------------------------------------------------------------------------\nContenedores activos:"
	docker ps --filter status=running
#   @echo "\n- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\nContenedores inactivos:"
#	@echo "\n.................................................................................................................\nContenedores inactivos:"
	@echo "\n------------------------------------------------------------------------------------------------------------------------------\nContenedores inactivos:"
	docker ps --filter status=exited
	@echo "\n=============================================================================================================================="
	docker volume ls
	@echo "\n=============================================================================================================================="
	docker network ls
	@echo "\n=============================================================================================================================="


delete_all: ##  Borra contenedores e imágenes previa confirmación
	@clear
	@echo "------------------------------------------------------------------------------------------------------------------------------"
	@echo "Borro contenedores e imagenes:"
	@echo "⚠️  ¿Está seguro que queres \n    detener los contenedores \n    borrar los contenedores  \n    borrar las imágenes? : \n"
	@read -p "    [s/N]: " confirm; \
	if [ "$$confirm" = "s" ] || [ "$$confirm" = "S" ]; then \
		echo "------------------------------------------------------------------------------------------------------------------------------"; \
		echo "Deteniendo contenedores..."; \
		docker stop $$(docker ps -q) 2>&1 || true; \
		echo "------------------------------------------------------------------------------------------------------------------------------"; \
		echo "Borrando contenedores..."; \
		docker rm -f $$(docker ps -a -q) 2>&1 || true; \
		echo "------------------------------------------------------------------------------------------------------------------------------"; \
		echo "Borrando imágenes..."; \
		docker rmi -f $$(docker images -q) 2>&1 || true; \
		echo ""; \
	else \
		echo "Operación cancelada."; \
	fi