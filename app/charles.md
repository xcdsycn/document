# charles抓包
## 设置代理
1. charles 与手机在同一个 wifi
2. 在 charles 的 help 的 localIpAddress 找到计算机的 IP
3. 在手机的 wifi，与你的电脑的 wifi 同名的详细信息中设置代理

## 安装证书
1. 在手机浏览器访问 chls.pro/ssl
2. 安装证书，一路 next 下去
3. 在通用-关于本机-证书信息设置中，信任你按装的证书

## 设置 SSL
1. 在 charles 的 proxy-ssl proxy settings 
2. 增加，例如 `*.sina.com.cn`

这样就可以抓取到内容了。

在android里不需要设置证书的，或者选择安装根证书以后不管有没有反应，先试一下吧。
