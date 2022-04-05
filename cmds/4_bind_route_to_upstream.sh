curl "http://127.0.0.1:9080/apisix/admin/routes/1" -H "X-API-KEY: edd1c9f034335f136f87ad84b625c8f1" -X PUT -d '
{
  "uri": "/get", <1>
  "host": "httpbin.org", <2>
  "upstream_id": "1" <3>
}'
