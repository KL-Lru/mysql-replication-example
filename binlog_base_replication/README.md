## Usage



1. インスタンスの初期化

```bash
make init
```

このスクリプトは以下の項目を実行します

- `CREATE USER` を MASTER / SLAVE 内それぞれにて実行します
  - MASTER: デフォルトユーザ`master`と, Replication時に利用するユーザ`repl`を作成
  - SLAVE: デフォルトユーザ`slave`を作成
- 必要となる権限を付与
  - MASTER: `master`に対して全権, `repl`に対してReplicationを行うのに必要な権限を付与
  - SLAVE: `slave`に対して全権を付与

2. MASTERのbinlogの同期開始地点の探索

binlogベースの場合, MASTERのどのbinlogのどこの地点を開始位置とするかを明示する必要があります

- MASTERのSTATUS上から現在のbinlogファイルと位置を確認し, それを元にreplicate開始スクリプトを生成

```bash
make check_replication_point
```

3. レプリケーションの開始

```bash
make replicate
```

このスクリプトは以下の項目を実行します

- 既に稼働開始している場合, Replicationの停止
- SLAVEから, Replicationを実行する同期元を指定し, 前ステップで確認したbinlogから同期を開始するよう指定
- Replicationの開始

4. MASTER へのテーブル追加, データ挿入

```bash
make seed
```

このスクリプトは以下の項目を実行します

- Table `users` を作成し, そこに5人分ほどデータを流し込みます

5. 同期状況の確認

それぞれ好きに状況を確認できます.

- MASTER / SLAVEの同期状況確認
  ```bash
  make status
  ```

- MASTER / SLAVEのレコード状況確認
  ```bash
  make select_all
  ```

6. クリーンアップ

  Volumeやコンテナを破棄します

  ```bash
  make clean
  ```