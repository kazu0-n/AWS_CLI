#!/bin/sh

### リージョン名を取得
REGION=`/usr/bin/curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone/ | sed
's/.$//'`

### インスタンス自身のインスタンスIDを取得
INSTANCE_ID=`/usr/bin/curl -s http://169.254.169.254/latest/meta-data/instance-id`

### Nameタグを取得
NAME_TAG=`/usr/bin/aws ec2 describe-instances --region ${REGION} \
--instance-ids ${INSTANCE_ID=} \
--query 'Reservations[].Instances[].Tags[?Key==\`Name\`].Value' \
--output text`

### Projectタグを取得
PROJ_TAG=`/usr/bin/aws ec2 describe-instances --region ${REGION} \
--instance-ids ${INSTANCE_ID=} \
--query 'Reservations[].Instances[].Tags[?Key==\`Project\`].Value' \
--output text`

### ホスト名を変更する
#echo $NAME_TAG
#echo $PROJ_TAG

INSTANCE_NAME="${NAME_TAG}_${PROJ_TAG}"
#
hostname ${INSTANCE_NAME}
sed -i -e "s/^HOSTNAME=.*\$/HOSTNAME=${INSTANCE_NAME}/g" /etc/sysconfig/network
