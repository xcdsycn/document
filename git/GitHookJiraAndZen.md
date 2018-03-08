- 1.JIRA
 curl -H "Content-type:application/json;charset=UTF-8" -H "Authorization:Basic OTI4NzU6Snp5MjAxNw==" http://192.168.60.204/rest/api/2/issue/TOPT-2379
- 2.zend


git log 13c3fb4..HEAD --ancestry-path --merges --oneline --color | tail -n 1
获取分支
perl -ne 'print if ($seen{$_} .= @ARGV) =~ /10$/' <(git rev-list --ancestry-path 1d8b3b3..master) <(git rev-list --first-parent 1d8b3b3..master) | tail -n 1

 gem install git-whence
 git whence 1234567

mvn clean install -DskipTests
echo "mysql_jdbcUrl=jdbc:mysql://192.168.30.164:3306" | tee -a /etc/environment
echo "mysql_username=root" | tee -a /etc/environment
echo "mysql_password=mogojiayou" | tee -a /etc/environment  

以后做事，一定一次做完，不然总是拖
另外，这次服务化相关的事情，应该在平时思考，做小事情，上班做

测试编译
# UT sonarqube jenkins
mvn -P coverage -Dmaven.test.failure.ignore=true
mvn clean test  -Dmaven.test.failure.ignore=true -pl
mvn clean install sonar:sonar -DrunSonar

  git@git.mogo.com:liuxiaohui/core-comm.git

转眼来蘑菇有三个月了，从『拔剑四顾心茫然』，到『三军过后尽开颜』。少不了蘑菇伙伴们的关怀与照顾。
借着七夕节，祝我的架构组的伙伴们，生活美满，家庭幸福！
也感谢我的同事，工作上的支持，工作方式的引导，生活上的照顾。
希望在以后的工作生活中，伴随着蘑菇一起前行，助力蘑菇发展！

<plugin>

        <groupId>org.sonarsource.scanner.maven</groupId>

        <artifactId>sonar-maven-plugin</artifactId>

        <version>3.2</version>

      </plugin>

      <plugin>
mvn clean install & mvn sonar：sonar

安装sonarQube的插件，然后关联项目，然后配置

1. 要去parent-pom下先打包，然后再执行以下两条下命令

## 成功了
以下两条命令可以完成所有的事情：只需要一个工程就行了
# --fail-at-end 指定单元测试时如果有失败继续执行
#   -Dmaven.test.skip=false  明确指定不跳过 测试步骤
#  prepare-agent  准备jacoco agent，这样测试的时候可以生成代码覆盖率报告
MAVEN_OPTS='-Xms2048m -Xmx2048m'& mvn --fail-at-end -Dmaven.test.skip=false clean org.jacoco:jacoco-maven-plugin:0.7.7.201606060606:prepare-agent  package -Dmogoroom-version=master-SNAPSHOT -Dvic-version=master-SNAPSHOT -Dmaven.test.failure.ignore=true

#下面是进行静态代码扫描， 并将代码覆盖率报告,单元测试报告 汇总到sonar平台上。
mvn -f pom.xml -e -B sonar:sonar -Dsonar.sourceEncoding=UTF-8 -Dsonar.jdbc.url="jdbc:mysql://192.168.60.53:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance" -Dsonar.host.url=http://192.168.60.53:9000 -Dsonar.login=jenkins -Dsonar.password=jenkins -Dmogoroom-version=master-SNAPSHOT

SONAR scanner用法：
https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner
sonar-scanner -Dproject.settings=../myproject.properties

# Root project information
sonar.projectKey=org.mgzf
sonar.projectName=mgzf
sonar.projectVersion=1.0

# Some properties that will be inherited by the modules
sonar.sources=src

# List of the module identifiers
sonar.modules=mgzf-fina,mgzf-arch

# Properties can obviously be overriden for
# each module - just prefix them with the module ID
mgzf-fina.sonar.projectName=sonar-mgzf-fina
mgzf-arch.sonar.projectName=sonar-mgzf-arch

sonar-scanner
