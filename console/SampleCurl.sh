#!/bin/bash
## curl-basic-auth
## - http basic Db2 Console Authentication Example
##   curl in bash
##   use jq to parse JSON, see https://stedolan.github.io/jq/download/
## version 0.0.1
##################################################

HOST='http://localhost:11080'
USERID='db2inst1'
PASSWORD='db2inst1'
CONNECTION='SAMPLE'

TOKEN=$(curl -s -X POST $HOST/dbapi/v4/auth/tokens \
  -H 'content-type: application/json' -d '{"userid": '$USERID' ,"password":'$PASSWORD'}' | jq -r '.token')

JSON=$(curl -s -X GET \
  $HOST'/dbapi/v4/dbprofiles/'$CONNECTION \
  -H 'authorization: Bearer '$TOKEN \
  -H 'content-type: application/json')

echo $JSON | jq '.'
echo

JSON=$(curl -s -X GET \
  $HOST'/dbapi/v4/schemas' \
  -H 'authorization: Bearer '$TOKEN \
  -H 'content-type: application/json' \
  -H 'x-db-profile: '$CONNECTION)

echo $JSON | jq '.'
echo
echo 'Number of Schemas in' $CONNECTION':'
echo $JSON | jq -r '.count'


