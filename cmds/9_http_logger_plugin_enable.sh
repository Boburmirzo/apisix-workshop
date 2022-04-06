curl http://127.0.0.1:9080/apisix/admin/routes/1 -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -d '
{
      "plugins": {
            "http-logger": {
                "uri": "http://mockbin.org/bin/5451b7cd-af27-41b8-8df1-282ffea13a61"
            }
       },
      "upstream_id": "1",
      "uri": "/get"
}'
