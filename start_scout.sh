# Start the docker file
docker stop scout
docker container prune
docker run -d --restart=always --env-file ./.env -p 3001:3001 --name scout johnsonchasm/chasm-scout
