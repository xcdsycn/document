#!/bin/sh
private_key="app_$1_private_key.pem"
private_key_pkcs8="app_$1_private_key_pkcs8.pem"
public_key="app_$1_public_key.pem"

cmd="openssl genrsa -out $private_key 1024"
echo ${cmd}
eval $cmd

echo "==> Java开发者需要将私钥转换成PKCS8格式"
cmd="openssl pkcs8 -topk8 -inform PEM -in $private_key  -outform PEM -nocrypt -out $private_key_pkcs8"
echo ${cmd}
eval $cmd

echo "==>生成公钥"
cmd="openssl rsa -in $private_key -pubout -out $public_key"
echo ${cmd}
eval $cmd

echo "==> 转换成单行 privateKey"
#pKeyLine=$(sed "1d" $private_key_pkcs8 | sed "15d" | sed 'N;s/\n//g' )
pKeyLine=$(tr "\n" " "  <  $private_key_pkcs8 | sed "s/ //g"| sed "s/-----BEGINPRIVATEKEY-----//" | sed "s/-----ENDPRIVATEKEY-----//") 

echo $pKeyLine
echo $pKeyLine > pkeyLine


echo ${cmd}
eval $cmd
echo "==> 转成单行 public_key"
pubKeyLine=$(tr "\n" " " < $public_key | sed "s/ //g" | sed "s/-----BEGINPUBLICKEY-----//" | sed "s/-----ENDPUBLICKEY-----//")
echo  $pubKeyLine 
echo $pubKeyLine > pubKeyLine
echo "======== 生成 RSA key 完成"


