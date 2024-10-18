docker build . -t cdev_container:latest
docker run -it -v ${PWD}/example:/example --network host -w /example cdev_container:latest /bin/bash