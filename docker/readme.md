#Build the docker image from project root
docker build -f ./docker/Dockerfile.python.github -t gh-shr-python:1 .

#Locally run docker setting the environment variables:

1. create a `scripts/aca_job_create/docker.env` file as a duplicate of the `scripts/aca_job_create/.env.tpl` file
1. set the variables in the new docker.env file (respect the `\n` foreach lines of the .pem file).
1. run the following
   ```bash
   docker run --env-file scripts/aca_job_create/docker.env gh-shr-python:1
   ```
