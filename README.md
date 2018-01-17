
```shell
docker run -it -p 8888:8888 --rm --name mynote -v `pwd`:/notebooks -e "PASSWORD=ANewPassword" craneleeon/pynotebook
```
