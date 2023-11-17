# 基于Alpine的MongoDB镜像

> Alpine：3.15 

> MongoDB：3.4.4

用于铜牛内部测试部署或小型应用

## 使用方式

```shell
docker pull liuchengjun94222/mongodb-3.4.4-alpine:latest
```

或直接clone本项目后在本地构建

```shell
docker build -t mongodb-3.4.4-alpine .
```

### 创建镜像

```shell
docker run -itd \
    -p 27017:27017 \
    -e MONGODB_ADMIN_PASSWORD="admin_password" \  # 数据库用户admin的密码，可缺省，默认为admin
    -v /mongo_data:/data/db \   # 将主机/mongo_data挂载到容器的/data/db，当/mongo_data存在数据文件时将不再进行数据库初始化工作
    liuchengjun94222/mongodb-3.4.4-alpine:latest
```