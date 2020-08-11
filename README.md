# maven-repo

maven默认会从中央仓库拉取依赖，而中央仓库一般存放着大公司或大组织的依赖。本仓库是自己搭建的一个私人maven仓库，可以存放个人的一些代码依赖。一般需要对maven做以下配置。



## 增加GitHub私服仓库

这样maven在拉取依赖的时候就知道除了中央仓库，还可以从这个地址下载到依赖

``````xml
<profiles>  
	<profile>
      <id>github</id>
      <activation>  
        <activeByDefault>true</activeByDefault>  
      </activation> 
      <repositories>
        <repository>
          <id>github</id>
          <url>https://raw.githubusercontent.com/hch814/maven-repo/master/repository</url>
        </repository>
      </repositories>
    </profile>
</profiles> 
``````

## 增加代理

一般来说raw.githubusercontent.com由于某些因素不可访问，如果你有梯子的话可以参考下面的代理配置

```xml
<proxies>
    <proxy>
      <id>ss</id>
      <active>true</active>
      <protocol>http</protocol>
      <host>localhost</host>
      <port>1087</port>
      <nonProxyHosts>*.aliyun.com|localhost</nonProxyHosts>
    </proxy>
</proxies>
```

