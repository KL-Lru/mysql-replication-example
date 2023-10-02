use kafka::consumer::Consumer;
use serde::{Deserialize, Serialize};
use sqlx::mysql::MySqlPool;

#[derive(Serialize, Deserialize, Debug)]
struct UserPayloads {
    id: i32,
    name: String,
}

#[derive(Serialize, Deserialize, Debug)]
struct UserKafkaPayloads {
    after: UserPayloads,
}

#[derive(Serialize, Deserialize, Debug)]
struct KafkaPayloads {
    payload: UserKafkaPayloads,
}

#[tokio::main]
async fn main() {
    let pool = MySqlPool::connect("mysql://slave:slave_password@localhost:23306/test")
        .await
        .unwrap();
    sqlx::query("CREATE TABLE IF NOT EXISTS users (id INT NOT NULL, name VARCHAR(255) NOT NULL, PRIMARY KEY (id))")
        .execute(&pool)
        .await
        .unwrap();

    let mut consumer = Consumer::from_hosts(vec!["localhost:9092".to_owned()])
        .with_topic("dbserver1.test.users".to_owned())
        .with_fallback_offset(kafka::consumer::FetchOffset::Earliest)
        .with_group("1".to_owned())
        .create()
        .unwrap();

    loop {
        for ms in consumer.poll().unwrap().iter() {
            for m in ms.messages() {
                let mes = String::from_utf8_lossy(m.value).to_string();
                let user: KafkaPayloads = serde_json::from_str(&mes).unwrap();
                sqlx::query(
                format!(
                    "INSERT INTO users (id, name) VALUES ('{}', '{}') ON DUPLICATE KEY UPDATE name = VALUES(name)",
                    user.payload.after.id, user.payload.after.name
                )
                .as_str(),
            )
            .execute(&pool)
            .await
            .unwrap();
                println!("{:?}", user.payload.after);
            }
            consumer.consume_messageset(ms).unwrap();
            consumer.commit_consumed().unwrap();
        }
    }
}
