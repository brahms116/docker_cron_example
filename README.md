# Example of running a docker cron service

This is a simple proof of concept and demo where a docker container can be used as a cron service to start other container tasks.

There are 2 docker images in this example:

-   demo-service: a simple container that echos a message to the console and sleeps for 1 minute
-   cron-service: a container which when started inserts a cron job via `crontab` to start the `demo-service` image every minute.
    The demo-service is started with the environmennt variable `CONTENT` specified when starting the cron-service container. 
    The `CONTENT` environment variable is passed to the demo-service container and is echoed to the console, this is also logged to a log file
    in the cron-service container at `/app/cron.log`.

To see this in action, build the 2 images.

```bash
docker build -t demo-service -f DemoService.Dockerfile .
docker build -t cron-service -f CronService.Dockerfile .
```

Then run the cron-service container with the following command:

```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock -e CONTENT="hello-3" -d cron-service
```
By binding the docker socket to the container, we do the docker in docker thing. This allows the cron-service container to start other containers.
Note also that we are passing an environment variable to the cron-service container to control the message that is echoed by the demo-service container.

After a while, when you run `docker ps`, you should see the container specified from the cron job running, look for the container with the image name `demo-service`.

If you do a `docker log` for the running `demo-service` container, you should see the message specified in the `CONTENT` environment variable, in this case `hello-3`.

## Complete Commands

```bash
docker build -t demo-service -f DemoService.Dockerfile .
docker build -t cron-service -f CronService.Dockerfile .

docker run -v /var/run/docker.sock:/var/run/docker.sock -e CONTENT="hello-3" -d cron-service
```
