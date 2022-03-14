# Hands-on lab Apache APISIX

# Contents

- [Pre-requisites](#pre-requisites)
- [Install Apache APISIX](#install-apache-apisix)
- [Create a Route](#create-a-route)
  - [How it works](#how-it-works)
  - [Route Configuration](#route-configuration)
- [Create an Upstream](#create-an-upstream)
- [Bind the Route to the Upstream](#bind-the-route-to-the-upstream)
- [Validation](#validation)
- [APISIX Dashboard](#validation)

### Pre-requisites

- Installed [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) component.

- We use the [curl](https://curl.se/docs/manpage.html) command for API testing. You can also use other tools such as Postman for testing.

### Install Apache APISIX

Download the Docker image of Apache APISIXgit clone.

    git clone https://github.com/apache/apisix-docker.git

Switch the current directory to the apisix-docker/example path.

    cd apisix-docker/example

Run the docker-compose command to install Apache APISIX.

    docker-compose -p docker-apisix up -d

Once the download is complete, execute the curl command on the host running Docker to access the Admin API, and determine if Apache APISIX was successfully started based on the returned data.

> Note: Please execute the curl command on the host where you are running Docker.    

    curl "http://127.0.0.1:9080/apisix/admin/services/" -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1'

### Create a Route

Now we have a running instance of Apache APISIX. Next, let's create a Route.

#### How it works

We can create a [Route](https://apisix.apache.org/docs/apisix/architecture-design/route/) and connect it to an [Upstream](https://apisix.apache.org/docs/apisix/architecture-design/upstream/) service(also known as the Upstream). When a Request arrives at Apache APISIX, Apache APISIX knows which Upstream the request should be forwarded to.

#### Route Configuration

The following curl command creates a sample configuration of Route:


``` 
curl "http://127.0.0.1:9080/apisix/admin/routes/1" -H "X-API-KEY: edd1c9f034335f136f87ad84b625c8f1" -X PUT -d '
{
  "methods": ["GET"],
  "host": "example.com",
  "uri": "/anything/*",
  "upstream": {
    "type": "roundrobin",
    "nodes": {
      "httpbin.org:80": 1
    }
  }
}'
```

Once this route is created, we can access the Upstream service using the address exposed by Apache APISIX.

    curl -i -X GET "http://127.0.0.1:9080/anything/foo?arg=10" -H "Host: example.com"

This will be forwarded to http://httpbin.org:80/anything/foo?arg=10 by Apache APISIX.

### Create an Upstream

An Upstream can be created by simply executing the following command:

```
curl "http://127.0.0.1:9080/apisix/admin/upstreams/1" -H "X-API-KEY: edd1c9f034335f136f87ad84b625c8f1" -X PUT -d '
{
  "type": "roundrobin",
  "nodes": {
    "httpbin.org:80": 1
  }
}'
```

> Note:
> Creating an Upstream service is not actually necessary, as we can use [Plugin](https://apisix.apache.org/docs/apisix/architecture-design/plugin/) to intercept the request and then respond directly. However, for the purposes of this guide, we assume that at least one Upstream service needs to be set up.

### Bind the Route to the Upstream

In the above step, we created an Upstream service (referencing our backend service), now let's bind a Route for it.

```
curl "http://127.0.0.1:9080/apisix/admin/routes/1" -H "X-API-KEY: edd1c9f034335f136f87ad84b625c8f1" -X PUT -d '
{
  "uri": "/get",
  "host": "httpbin.org",
  "upstream_id": "1"
}'
```

### Validation

We have created the route and the Upstream service and bound them. Now let's access Apache APISIX to test this route.

      curl -i -X GET "http://127.0.0.1:9080/get?foo1=bar1&foo2=bar2" -H "Host: httpbin.org"

It returns data from our Upstream service (actually httpbin.org) and the result is as expected.

### APISIX Dashboard

Apache APISIX provides a [Dashboard](https://github.com/apache/apisix-dashboard) to make our operation more intuitive and easier.
