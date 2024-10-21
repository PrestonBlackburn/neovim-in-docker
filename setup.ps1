docker build . -t neodev_container:latest
$WorkDir = (Get-Item $PWD).Name
docker run -it -v ${PWD}:/$WorkDir --network host -w /$WorkDir neodev_container:latest /bin/bash

