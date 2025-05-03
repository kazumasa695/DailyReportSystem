# 0. ベースイメージの指定
FROM ubuntu:22.04

# 非対話モードで tzdata を処理するための設定
ENV DEBIAN_FRONTEND=noninteractive

# 1. 基本ツールと設定
RUN apt-get update && apt-get install -y \
    vim \
    wget \
    apt-transport-https \
    gnupg \
    sudo \
    apache2 \
    tzdata \
    language-pack-ja && \
    ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# 日本語化とタイムゾーン設定
ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo
RUN update-locale LANG=ja_JP.UTF-8
RUN echo 'Asia/Tokyo' > /etc/timezone

# 2. Apache2 のモジュール設定
RUN a2enmod rewrite ssl proxy proxy_ajp
RUN a2ensite default-ssl
RUN sed -i -e "s/^<\/VirtualHost>/RewriteEngine on/" /etc/apache2/sites-available/000-default.conf
RUN echo 'RewriteCond %{HTTPS} off' >> /etc/apache2/sites-available/000-default.conf
RUN echo 'RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L]' >> /etc/apache2/sites-available/000-default.conf
RUN echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf
RUN echo "ProxyPass / ajp://localhost:8009/" >> /etc/apache2/apache2.conf

# 3. JDK のインストール
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add -
RUN echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
RUN apt-get update && apt-get install -y temurin-17-jdk=17.0.5.0.0+8

# 4. Spring Boot JAR配置
RUN mkdir -p /var/www/java
COPY DailyReportSystemApplication-0.0.1-SNAPSHOT.jar /var/www/java/

# 5. startup.sh の配置と実行権限付与
COPY startup.sh /startup.sh
RUN chmod 744 /startup.sh

# 6. コンテナ起動時に実行するスクリプト
CMD ["/startup.sh"]

# ポート開放
EXPOSE 80
EXPOSE 443
EXPOSE 8009
