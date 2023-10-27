
echo "Setting index pattern..."
status=$(curl -s -o /dev/null -w "%{http_code}" -XPOST -H "kbn-xsrf: true" -H "Content-Type: application/json" \
  http://localhost:5601/api/saved_objects/index-pattern/my-index-pattern \
  -d '{
    "attributes": {
      "title": "logstash*",
      "timeFieldName": "@timestamp"
    }
  }')
while [ "$status" != "200" ] && [ "$status" != "409" ]; do
  sleep 3

  status=$(curl -s -o /dev/null -w "%{http_code}" -XPOST -H "kbn-xsrf: true" -H "Content-Type: application/json" \
    http://localhost:5601/api/saved_objects/index-pattern/my-index-pattern \
    -d '{
      "attributes": {
        "title": "logstash*",
        "timeFieldName": "@timestamp"
      }
    }')
      
done
echo "Index pattern create success"

if [ "$status" = "409" ]; then
  echo "Index pattern already exists."
fi
