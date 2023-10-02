init:
	docker compose up -d --wait
	docker compose exec master bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/setup.sh;"
	docker compose exec slave bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/setup.sh;"
	docker compose exec monitor bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/setup.sh;"

check_replication_point:
	docker compose up -d --wait
	./scripts/configure.sh

replicate:
	docker compose exec slave bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/replication.sh;";

seed:
	docker compose up -d --wait
	docker compose exec master bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/seed.sh;"

clean:
	docker compose down -v --remove-orphans
