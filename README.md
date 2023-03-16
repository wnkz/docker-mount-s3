# Docker image for mount-s3

## Quick start

⚠️ Mount propagation doesn’t work with Docker Desktop. (see [bind-mounts](https://docs.docker.com/storage/bind-mounts/))

```sh
docker run \
	--rm -it \
	-e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
	-e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
	-e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
	--cap-add SYS_ADMIN --device /dev/fuse \
	--mount type=bind,source="$(pwd)"/mnt,target=/mnt,readonly,bind-propagation=rshared \
	wnkz/mount-s3 \
	mount-s3 -f my-bucket /mnt
```
