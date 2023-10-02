init:
	docker compose up -d --wait
	docker compose exec master bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/setup.sh;"
	docker compose exec slave bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/setup.sh;"
	./connector/deploy.sh

consume:
	docker compose --profile consumer run --rm -it consumer

seed:
	docker compose up -d --wait
	docker compose exec master bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/seed.sh;"

status:
	docker compose exec master bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/status.sh;"
	docker compose exec slave bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/status.sh;"

select_all:
	docker compose exec master bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/select.sh;"
	docker compose exec slave bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/select.sh;"

clean:
	docker compose down -v --remove-orphans
