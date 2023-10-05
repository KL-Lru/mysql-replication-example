use kafka::consumer::Consumer;
use log::info;
use serde::{Deserialize, Serialize};
use simple_logger as logger;
use tokio::{signal, sync::mpsc::channel};
use tokio_util::sync::CancellationToken;

#[derive(Serialize, Deserialize, Debug)]
struct UserPayloads {
    id: i32,
    name: String,
}

#[derive(Serialize, Deserialize, Debug)]
struct UserKafkaPayloads {
    // before: ...
    after: UserPayloads,
}

#[derive(Serialize, Deserialize, Debug)]
struct KafkaPayloads {
    // schema: ...
    payload: UserKafkaPayloads,
}

async fn kafka_consume(heartbeat: &mut tokio::sync::mpsc::Receiver<()>) {
    let mut consumer = Consumer::from_hosts(vec!["localhost:9092".to_owned()])
        .with_topic("dbserver1.test.users".to_owned())
        .with_fallback_offset(kafka::consumer::FetchOffset::Earliest)
        .with_group("1".to_owned())
        .create()
        .expect("Failed to connect to Kafka");

    while let Ok(mss) = consumer.poll() {
        for ms in mss.iter() {
            for m in ms.messages() {
                let mes = String::from_utf8_lossy(m.value).to_string();
                let user: KafkaPayloads = serde_json::from_str(&mes).unwrap();
                info!("{:?}", user.payload.after);
            }
            // mark as consumed
            consumer.consume_messageset(ms).unwrap();
            consumer.commit_consumed().unwrap();
        }
        // check heartbeat pulse
        heartbeat.recv().await;
    }
}

#[tokio::main]
async fn main() {
    logger::init().unwrap();
    info!("Start consume");

    let (pulse, mut heartbeat) = channel::<()>(1);

    let token = CancellationToken::new();
    let cancel = token.clone();

    // Ctrl-C exit
    tokio::spawn(async move {
        signal::ctrl_c().await.expect("Failed to listen for event");

        info!("Exit...");
        token.cancel();
    });

    // Heartbeat
    let beater = tokio::spawn(async move {
        loop {
            tokio::time::sleep(tokio::time::Duration::from_millis(100)).await;
            pulse.send(()).await.unwrap();
        }
    });

    // Main Kafka consuming
    let kafka_handle = tokio::spawn(async move {
        kafka_consume(&mut heartbeat).await;
    });

    tokio::spawn(async move {
        tokio::select! {
            _ = cancel.cancelled() => {
                info!("Shutdown...");
            }
            _ = kafka_handle => {}
            _ = beater => {}
        }
    })
    .await
    .expect("Something went wrong");
}
