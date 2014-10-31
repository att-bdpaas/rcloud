#!/bin/bash

set -ex

PORT=${1:-8080}
DIR="$( cd "$( dirname $0 )" && pwd )"
export ROOT="$(cd $DIR/.. && pwd)"
RSERVE_CONF=$ROOT/conf/rserve.conf
RCLOUD_CONF=$ROOT/conf/rcloud.conf

REDIS_HOST=`Rscript $ROOT/scripts/cfParseRedisHost.R`
REDIS_PASSWORD=`Rscript $ROOT/scripts/cfParseRedisPassword.R`

if [ "$(uname)" == "Darwin" ]
then
    sed -i '' "s|http.port [[:digit:]]*|http.port $PORT|" $RSERVE_CONF
    sed -i '' "s|rcs.redis.host: .*|rcs.redis.host: $REDIS_HOST|" $RCLOUD_CONF
    sed -i '' "s|rcs.redis.password: .*|rcs.redis.password: $REDIS_PASSWORD|" $RCLOUD_CONF
else
    sed -i "s|http.port [[:digit:]]*|http.port $PORT|" $RSERVE_CONF
    sed -i "s|rcs.redis.host: .*|rcs.redis.host: $REDIS_HOST|" $RCLOUD_CONF
    sed -i "s|rcs.redis.password: .*|rcs.redis.password: $REDIS_PASSWORD|" $RCLOUD_CONF
fi

grep -q -F 'daemon disable' $RSERVE_CONF || echo -e "\ndaemon disable" >> $RSERVE_CONF

echo "Starting RServe with the following configuration:"
cat $ROOT/conf/rcloud.conf
cat $ROOT/conf/rserve.conf

$ROOT/conf/start
