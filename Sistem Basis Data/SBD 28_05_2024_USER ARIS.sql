-- soal no 1 dan 2 --
GRANT ALL PRIVILEGES ON *.* TO 'aris'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- soal no 3 --
-- Buat pengguna baru
CREATE USER 'indah'@'localhost' IDENTIFIED BY '54321';

-- Berikan hak akses penuh ke semua database dan tabel
GRANT ALL PRIVILEGES ON *.* TO 'indah'@'localhost' WITH GRANT OPTION;

-- Reload privileges
FLUSH PRIVILEGES;

-- soal no 4 --
-- Jika pengguna belum dibuat, buat pengguna baru
CREATE USER 'indah'@'localhost' IDENTIFIED BY '54321';

-- Berikan hak akses SELECT dan INSERT ke semua database dan tabel
GRANT SELECT, INSERT ON *.* TO 'indah'@'localhost';

-- Reload privileges
FLUSH PRIVILEGES;