`jual``pelanggan``pelanggan`INSERT INTO jual VALUES
(1,'001','2024-03-19',500000),
(2,'002','2024-03-20',100000),
(3,'003','2024-03-21',200000),
(4,'004','2024-03-22',300000),
(5,'005','2024-03-23',400000),
(6,'006','2024-03-24',600000),
(7,'007','2024-03-25',700000),
(8,'008','2024-03-26',800000),
(9,'009','2024-03-27',900000),
(10,'010','2024-03-28',1000000);
DELETE FROM jual;
SELECT * FROM jual;
SELECT * FROM jual WHERE tgl_tx='2024-03-20';

SELECT * FROM pelanggan;

-- didapatkan hasil yg salah --
SELECT nama, MAX(gaji) FROM pelanggan;
-- solusi dibuat subquery --
SELECT * FROM pelanggan WHERE gaji=(SELECT MAX(gaji) FROM pelanggan);

-- menampilkan data pelanggan yg gajinya di atas rata-rata --
SELECT * FROM pelanggan WHERE gaji>(SELECT AVG(gaji) FROM pelanggan);

INSERT INTO pelanggan VALUES
('001','Budi',19,'Bekasi',8000000),
('002','Heru',20,'Jakarta',1000000),
('003','Abdi',19,'Demak',3000000),
('004','Adi',22,'Bogor',7000000),
('005','Andi',19,'Semarang',6000000),
('006','Fauzan',19,'Solo',5000000),
('007','Erick',22,'Depok',6000000),
('008','Luhut',25,'Tangerang',5000000),
('009','Cahyo',19,'Pekalongan',8000000),
('010','Rendi',19,'Kudus',5000000),
('011','Amir',25,'Pekalongan',8500000),
('012','Ridwan',25,'Bandung',5500000),
('013','Khofifah',25,'Cianjur',8500000);

DELETE FROM pelanggan;
SELECT * FROM pelanggan;

-- Memuat View --
`vpelanggan_jateng``pelanggan``jual`
CREATE VIEW vpelanggan_jateng AS
SELECT * FROM pelanggan WHERE kota IN ('Semarang','Solo','Demak');

-- Membaca View --
SELECT * FROM vpelanggan_jateng;
SELECT * FROM vpelanggan_jabar;

-- Latihan Membuat View vpelanggan_jabar --
CREATE VIEW vpelanggan_jabar AS
SELECT * FROM pelanggan WHERE kota IN ('Bekasi','Bogor','Depok','Tangerang');

-- Merubah View vpelanggan_jateng --
ALTER VIEW vpelanggan_jateng AS SELECT * FROM pelanggan WHERE kota IN ('Semarang','Solo','Demak','Kudus','Pekalongan');

-- Merubah View vpelanggan_jabar --
ALTER VIEW vpelanggan_jabar AS SELECT * FROM pelanggan WHERE kota IN ('Bekasi','Bogor','Depok','Tangerang');

-- membuat index --
CREATE INDEX id_idx ON pelanggan (id);
-- membuat index unik --
CREATE UNIQUE INDEX id_idx2 ON pelanggan (id);
-- menampilkan daftar index --
SHOW INDEXES FROM pelanggan;

-- Materi Fungsi --
SELECT * FROM pelanggan
-- Mencari rata-rata gaji --
SELECT FORMAT(AVG(gaji),0) AS rata_rata_gaji FROM pelanggan;
-- mencari rata2 gaji pelanggan di kota semarang --
SELECT FORMAT(AVG(gaji),0) AS rata_rata_gaji FROM pelanggan
WHERE kota IN ('Semarang');
-- mencari rata2 gaji per kota --
SELECT kota,AVG(gaji) AS rata_rata_gaji FROM pelanggan GROUP BY kota;
-- count --
-- menghitung jml record pelanggan --
SELECT COUNT(*) AS jml_pelanggan FROM pelanggan;
-- -- menghitung jml record pelanggan yg tinggal di Semarang --
SELECT COUNT(*) AS jml_pelanggan_smg FROM pelanggan
WHERE kota IN ('Semarang');
-- -- menghitung jml pelanggan di setiap kota --
SELECT kota, COUNT(*) AS jml_pelanggan FROM pelanggan
GROUP BY kota;
-- menghitung jml pelanggan per usia --
SELECT usia, COUNT(*) AS jml_pelanggan FROM pelanggan
GROUP BY usia;
-- distinct --
-- menampilkan 1 record untuk record yg kembar --
SELECT DISTINCT(kota) FROM pelanggan;
-- menampilkan jml kota yg terdapat pada tabel pelanggan --
SELECT COUNT(DISTINCT kota) AS jml FROM pelanggan;
-- MAX --
SELECT FORMAT(MAX(gaji),0) AS gaji_tertinggi FROM pelanggan;
-- menampilkan gaji tertinggi per kota --
SELECT kota, FORMAT(MAX(gaji),0) AS gaji_tertinggi FROM pelanggan
GROUP BY kota;
-- menampilkan gaji terkcil --
SELECT FORMAT(MIN(gaji),0) AS gaji_terendah FROM pelanggan;
-- menampilkan gaji terendah per kota --
SELECT kota, FORMAT(MIN(gaji),0) AS gaji_terendah FROM pelanggan
GROUP BY kota;
-- SUM --
SELECT FORMAT(SUM(gaji),0) AS jml_gaji FROM pelanggan;
-- menampilkan jumlah total gaji per kota --
SELECT kota, FORMAT(SUM(gaji),0) AS jml_gaji FROM pelanggan
GROUP BY kota;

-- membuat function --
-- FUNGSI BUATAN SENDIRI --
DELIMITER //
CREATE FUNCTION jmlPelanggan() RETURNS INT DETERMINISTIC
BEGIN
	DECLARE jml INT;
	SELECT COUNT(*) INTO jml FROM pelanggan;
	RETURN jml;
END
//
DELIMITER ;
-- memanggil fungsi --
SELECT jmlPelanggan();
-- Membuat fungsi mengembalikan gaji tertinggi --
DELIMITER //
CREATE FUNCTION gajiTertinggi() RETURNS INT DETERMINISTIC
BEGIN
	DECLARE maks INT;
	SELECT MAX(gaji) INTO maks FROM pelanggan;
	RETURN maks;
END
//
-- memanggil fungsi gajiTertinggi --
SELECT gajiTertinggi();
-- membuat fungsi pelanggan per kota --
DELIMITER//
CREATE FUNCTION jmlPelangganKota(pkota VARCHAR(20)) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE jml INT;
	SELECT COUNT(*) INTO jml FROM pelanggan WHERE kota=pkota;
	RETURN jml;
END
//
SELECT jmlPelangganKota("Semarang");
-- membuat fungsi gaji tertinggi per kota --
DELIMITER //
CREATE FUNCTION maksgaji(pkota VARCHAR(20)) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE maks INT;
	SELECT MAX(gaji) INTO maks FROM pelanggan WHERE kota=pkota;
	RETURN maks;
END
//
SELECT maksgaji ("Bekasi");