# 生成 RSA 的方法

```shell
# openssl
#OpenSSL> genrsa -out app_broker_private_key.pem   1024  #生成私钥
#OpenSSL> pkcs8 -topk8 -inform PEM -in app_broker_private_key.pem -outform PEM -nocrypt -out app_private_key_pkcs8.pem #Java开发者需要将私钥转换成PKCS8格式
#OpenSSL> rsa -in app_broker_private_key.pem -pubout -out app_broker_public_key.pem #生成公钥
#OpenSSL> exit #退出OpenSSL程序
```

生成的密钥在当前运行 openssl 目录下
