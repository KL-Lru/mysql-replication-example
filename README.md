## Replication Example

MySQLにおいて, Replicationを行うパターンの練習帳です.

この資料内では次のように名称を使います

* MASTER
  * レプリケーション元となり, 同期元となるMySQLインスタンスを指します
* SLAVE
  * レプリケーション先となり, データが同期されるMySQLインスタンスを指します

- `binlog_base_replication`
  - 古来からある, binlogに基づいてReplicationを行うサンプル
- `gtid_base_replication`
  - GTID(Global Transaction ID)を用いてReplicationを行うサンプル
- `debezium_cdc_replication`
  - binlogをKafkaに流し込み, ConsumeすることができるようにするDebeziumを用いてReplicationを行うサンプル