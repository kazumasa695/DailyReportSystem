#!/bin/bash

# Spring Bootアプリ起動（バックグラウンド）
java -jar /var/www/java/DailyReportSystemApplication-0.0.1-SNAPSHOT.jar &

# Apache2の起動
rm -f /var/run/apache2/apache2.pid
apachectl -D FOREGROUND