# HTTP 响应头中的意思

## X-Xsss-Protection:1;mode=block
意思浏览器会执行防止跨站攻击的脚本执行，并出现block的页面；

## Strict-Transport-Security: max-age=631138519

服务器给客户端提供的响应说明，在以后的20年中，客户端向服务器端发起的请求，都要必须使用HTTPS协议。

## X-Frame-Options:DENY

拒绝当前页面，嵌入Frame、iframe、<embed> 或者 <object> 中展现的标记。站点可以通过确保网站没有被嵌入到别人的站点里面，从而避免 clickjacking 攻击。

```html
X-Frame-Options: deny
X-Frame-Options: sameorigin
X-Frame-Options: allow-from https://example.com/
```
换一句话说，如果设置为 deny，不光在别人的网站 frame 嵌入时会无法加载，在同域名页面中同样会无法加载。另一方面，如果设置为sameorigin，那么页面就可以在同域名页面的 frame 中嵌套。

##X-Content-Type-Options:nosniff

X-Content-Type-Options 响应首部相当于一个提示标志，被服务器用来提示客户端一定要遵循在 Content-Type 首部中对  MIME 类型 的设定，而不能对其进行修改。这就禁用了客户端的 MIME 类型嗅探行为，换句话说，也就是意味着网站管理员确定自己的设置没有问题。

这个消息首部最初是由微软在 IE 8 浏览器中引入的，提供给网站管理员用作禁用内容嗅探的手段，内容嗅探技术可能会把不可执行的 MIME 类型转变为可执行的 MIME 类型。在此之后，其他浏览器也相继引入了这个首部，尽管它们的 MIME 嗅探算法没有那么有侵略性。

## Referrer-Policy:no-referrer
用来监管哪些访问来源信息——会在 Referer  中发送——应该被包含在生成的请求当中。

no-referrer:整个 Referer  首部会被移除。访问来源信息不随着请求一起发送。

参考：https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Headers/Referrer-Policy

## Content-Security-Policy:default-src 'self' https:; font-src 'self' https: data:; img-src 'self' https: data:; object-src 'none'; script-src https:; style-src 'self' https: 'unsafe-inline'

CSP 的实质就是白名单制度，开发者明确告诉客户端，哪些外部资源可以加载和执行，等同于提供白名单。它的实现和执行全部由浏览器完成，开发者只需提供配置。

CSP 大大增强了网页的安全性。攻击者即使发现了漏洞，也没法注入脚本，除非还控制了一台列入了白名单的可信主机。

两种方法可以启用 CSP。一种是通过 HTTP 头信息的Content-Security-Policy的字段。

## X-Download-Options:noopen
用于指定IE 8以上版本的用户不打开文件而直接保存文件。在下载对话框中不显示“打开”选项。


