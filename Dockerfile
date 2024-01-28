FROM eclipse-temurin:8-jre-jammy

RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list &&\
    sed -i 's@//.*security.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list &&\
    apt update &&\
    apt install -y --no-install-recommends libreoffice unzip &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /var/cache/apt/* &&\
    rm -rf /tmp/*

ADD server/target/kkFileView-4.4.0-SNAPSHOT.jar /kkFileView-4.4.0.jar

ENV OFFICE_HOME=/usr/share/libreoffice
ENV OFFICE_PLUGIN_SERVER_PORTS="2001,2002"
ENV BASE_URL=""
ENV FILE_DIR="/files"
ENV CACHE_TYPE="jdk"
ENV SERVER_PORT=8080
ENV SERVER_SERVLET_CONTEXT_PATH="/"
ENV SPRING_OUTPUT_ANSI_ENABLED=always
ENV SPRING_REDISSON_ADDRESS="127.0.0.1:6379"
ENV SPRING_REDISSON_PASSWORD="123456"

EXPOSE 80-32767
VOLUME ["$FILE_DIR"]

CMD ["java", "-Xmx512m", "-Xms512m", "-Dfile.encoding=UTF-8", "-jar", "/kkFileView-4.4.0.jar"]

# uhub.service.ucloud.cn/whtjkj/jnpfsoft/file-preview-api:4.4.0
