init:
	docker compose up -d --wait
	docker compose exec master bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/setup.sh;"
	docker compose exec slave bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/setup.sh;"
	./connector/deploy.sh

consume:
	docker compose exec kafka bin/kafka-console-consumer.sh --bootstrap-server kafka:9092 --topic dbserver1.test.users

replicate:
	docker compose exec slave bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/replication.sh;";

seed:
	docker compose up -d --wait
	docker compose exec master bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/seed.sh;"

clean:
	docker compose down -v --remove-orphans
