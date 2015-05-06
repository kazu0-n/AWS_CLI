EC2プロンプト設定方法
======================

EC2の「nameタグ」と「Projectタグ」をOSのホストネームと同期させてプロンプトに表示します

## 事前に準備すること
* IAMで下記ポリシーのユーザを作成するか、インスタンスにロールを割り当てておきます

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    }
  ]
}
```

## 使い方
* cloud-initを使ってインスタンス起動時に実行するように、スクリプトを作成します

```
$ sudo vi /var/lib/cloud/scripts/per-boot/001_sync_hostname.sh
$ sudo chmod 755 /var/lib/cloud/scripts/per-boot/001_sync_hostname.sh
```
* AWSでインスタンスのnameタグを変更したときは、スクリプトを起動して  
再ログインするとプロンプトのホスト名が変わります
