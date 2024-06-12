-- soal no 4 --
-- Jika pengguna belum dibuat, buat pengguna baru
CREATE USER 'indah'@'localhost' IDENTIFIED BY '54321';

-- Berikan hak akses SELECT dan INSERT ke semua database dan tabel
GRANT SELECT, INSERT ON *.* TO 'indah'@'localhost';

-- Reload privileges
FLUSH PRIVILEGES;

-- soal no 5 --
-- Buat pengguna baru
CREATE USER 'soni'@'localhost' IDENTIFIED BY '123';

-- Berikan semua hak akses ke semua database dan tabel
GRANT ALL PRIVILEGES ON *.* TO 'soni'@'localhost' WITH GRANT OPTION;

-- Reload privileges
FLUSH PRIVILEGES;