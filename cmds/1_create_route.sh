curl "http://127.0.0.1:9080/apisix/admin/routes/1" -H "X-API-KEY: edd1c9f034335f136f87ad84b625c8f1" -X PUT -d '  <1><2><3>
{
  "methods": ["GET"],                     <4>
  "host": "example.com",                  <5>
  "uri": "/anything/*",                   <6>
  "upstream": {                           <7>
    "type": "roundrobin",
    "nodes": {
      "httpbin.org:80": 1
    }
  }
}'
