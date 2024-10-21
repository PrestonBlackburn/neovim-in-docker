docker build . -t neodev_env:latest
$WorkDir = (Get-Item $PWD).Name
docker run -it -v ${PWD}:/$WorkDir --network host -w /$WorkDir neodev_env:latest /bin/bash

