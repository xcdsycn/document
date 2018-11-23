# Mock单元测试
## pom
```xml
<!-- 需要注意，只有1.6.2版本以上才能和1.10.19 以上的Mockito一起用 ,powermock的版本要保持一致 -->
<dependency>
    <groupId>org.mockito</groupId>
    <artifactId>mockito-all</artifactId>
    <version>1.10.19</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.powermock</groupId>
    <artifactId>powermock-api-mockito</artifactId>
    <version>1.6.6</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.powermock</groupId>
    <artifactId>powermock-module-junit4</artifactId>
    <version>1.6.6</version>
    <exclusions>
        <exclusion>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
        </exclusion>
        <exclusion>
            <groupId>org.powermock</groupId>
            <artifactId>powermock-core</artifactId>
        </exclusion>
        <exclusion>
            <groupId>org.powermock</groupId>
            <artifactId>powermock-reflect</artifactId>
        </exclusion>
    </exclusions>
    <scope>test</scope>
</dependency>
 ```
 ## 被测试类及方法
 ```java
/**
 * Created by lxh on 2018/5/3.
 */
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author lxh
 * @Date 2018/5/3
 */
public class SenderUtil {
    private static final Logger logger = LoggerFactory.getLogger(SenderUtil.class);
    public static final String UTF_8 = "UTF-8";

    private SenderUtil() {
        throw new IllegalStateException("init class is forbidden");
    }
   

    /**
     *
     * @param url
     * @param content
     * @return
     */
    public static String sendCode(String url, String content) {
        //这里mock点，需要返回
        CloseableHttpClient client = null;
        //这是需要mock的点
        HttpPost post;
        String responseStr;
        post = new HttpPost(url);
        List<NameValuePair> formparams = new ArrayList<>();
        formparams.add(new BasicNameValuePair("message", content));
        try {
            // 这里需要Mock静态类
            client =  HttpClients.createDefault();
            UrlEncodedFormEntity urlEntity = new UrlEncodedFormEntity(formparams, UTF_8);
            post.setEntity(urlEntity);
            // 这里需要指定mock行为
            CloseableHttpResponse response = client.execute(post);
            //这里需要mock静态工具类EntityUtils
            responseStr = EntityUtils.toString(response.getEntity(), UTF_8);
        } catch (Exception e) {
            return null;
        } finally {
            if (null != client) {
                try {
                    client.close();
                } catch (IOException e) {
                }
            }
        }

        return responseStr;
    }

}
```

## 测试代码
```java

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.powermock.api.mockito.PowerMockito;
import org.powermock.core.classloader.annotations.PrepareForTest;
import org.powermock.modules.junit4.PowerMockRunner;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * 注解是一定要加的
 * prepare注解中的class要包括你要测试的class,本例中为SenderUtil，另外需要mock的静态类，final类也需要放到里面
 * 对于静态类中的final方法，不需要特别的处理，只需要mock静态类就行了
 * Created by lxh on 2018/5/3.
 */
@RunWith(PowerMockRunner.class)
@PrepareForTest({HttpClients.class,SenderUtil.class,EntityUtils.class})
public class SenderUtilTest {
    private static final Logger logger = LoggerFactory.getLogger(SenderUtilTest.class);

    public static final String URL = "http://www.baidu.com";

    /**
     * 这里一定要有test开头，不然会报错
     */
    @Test
    public void testSendCode() throws Exception {

        HttpPost post = Mockito.mock(HttpPost.class);
        
        PowerMockito.mockStatic(HttpClients.class);
        PowerMockito.mockStatic(EntityUtils.class);
        
        CloseableHttpResponse closeableHttpResponse = Mockito.mock(CloseableHttpResponse.class);
        CloseableHttpClient closeableHttpClient = Mockito.mock(CloseableHttpClient.class);
        
        Mockito.when(HttpClients.createDefault()).thenReturn(closeableHttpClient);
        Mockito.when(closeableHttpClient.execute(post)).thenReturn(closeableHttpResponse);
        Mockito.when(EntityUtils.toString(closeableHttpResponse.getEntity())).thenReturn("");

        String result = SenderUtil.sendCode(URL, content);
        logger.info("<== 返回结果：{}", result);
    }
}
```
