-- soal no 6 --
-- Buat pengguna baru jika belum dibuat
CREATE USER 'soni'@'localhost' IDENTIFIED BY '123';

-- Berikan hak akses SELECT dan INSERT ke tabel products di database classicmodels
GRANT SELECT, INSERT ON classicmodels.products TO 'soni'@'localhost';

-- Reload privileges
FLUSH PRIVILEGES;

-- soal no 7 --
-- Buat pengguna baru jika belum dibuat
CREATE USER 'soni'@'localhost' IDENTIFIED BY '123';

-- Berikan hak akses SELECT dan UPDATE pada kolom tertentu di tabel customers
GRANT SELECT, UPDATE (customerNumber, customerName, phone) ON classicmodels.customers TO 'soni'@'localhost';

-- Reload privileges
FLUSH PRIVILEGES;
