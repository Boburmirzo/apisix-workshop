# Hands-on lab Apache APISIX

# Contents

1. [Pre-requisites](#pre-requisites)
2. [Install Apache APISIX](#install-apache-apisix)

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
