-- データベース作成（指定どおり）
CREATE DATABASE IF NOT EXISTS daily_report_system
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- ユーザー作成とパスワード設定
CREATE USER IF NOT EXISTS 'repuser'@'%' IDENTIFIED BY 'reppass';

-- 指定データベースへの権限付与（*.* → 必要なDBだけに変更）
GRANT ALL PRIVILEGES ON daily_report_system.* TO 'repuser'@'%';

-- 権限の再読み込み
FLUSH PRIVILEGES;
