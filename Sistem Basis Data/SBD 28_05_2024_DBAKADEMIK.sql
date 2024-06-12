-- untuk membuat database baru --
CREATE DATABASE dbakademik;
USE dbakademik;
-- untuk membuat tabel database baru --
CREATE TABLE matakuliah (
    kode_mk VARCHAR(10) PRIMARY KEY,
    nama_mk VARCHAR(100) NOT NULL,
    sks INT,
    smt INT
);

-- untuk membuat tabel database baru --
CREATE TABLE mahasiswa (
    nim VARCHAR(14) PRIMARY KEY,
    nama_mhs VARCHAR(100) NOT NULL,
    alamat VARCHAR(255),
    kota VARCHAR(100)
);

-- untuk membuat tabel database baru --
CREATE TABLE krs (
    nim VARCHAR(14),
    kode_mk VARCHAR(10),
    kelp VARCHAR(40),
    ta INT,
    smt INT,
    PRIMARY KEY (nim, kode_mk, kelp, ta, smt),
    FOREIGN KEY (nim) REFERENCES mahasiswa(nim),
    FOREIGN KEY (kode_mk) REFERENCES matakuliah(kode_mk)
);

-- untuk membuat tabel database baru --
CREATE TABLE nilai_smt( nim VARCHAR(14),
kode_mk VARCHAR(6),
kelp VARCHAR(8),
ntugas DECIMAL(4,2),
nuts DECIMAL(4,2),
nuas DECIMAL(4,2),
na_angka DECIMAL(4,2),
na_huruf VARCHAR(2),
ta INT,
smt INT
);

-- untuk membuat tabel database baru --
CREATE TABLE log_krs(
idlog INT PRIMARY KEY AUTO_INCREMENT,
tgl DATETIME,
kode_status CHAR,
keterangan VARCHAR(30),
nim VARCHAR(14),
kode_mk VARCHAR(6),
kelp VARCHAR(8),
ta INT,
smt INT
);

ALTER TABLE krs ADD CONSTRAINT fk_krs_mhs FOREIGN KEY (nim) REFERENCES mahasiswa(nim);
ALTER TABLE krs ADD CONSTRAINT fk_krs_matkul FOREIGN KEY (kode_mk) REFERENCES matakuliah(kode_mk);
ALTER TABLE nilai_smt ADD CONSTRAINT fk_nilai_mhs FOREIGN KEY (nim) REFERENCES mahasiswa(nim);
ALTER TABLE nilai_smt ADD CONSTRAINT fk_nilai_matkul FOREIGN KEY (kode_mk) REFERENCES matakuliah(kode_mk);

-- isikan data pada tabel mahasiswa --
INSERT INTO mahasiswa (nim,nama_mhs,alamat,kota) VALUES ('A11.2022.01111','Anggi','Jl Nakula','Semarang');
INSERT INTO mahasiswa (nim,nama_mhs,alamat,kota) VALUES ('A11.2022.01112','Slamet','Jl
Sadewa','Semarang');
INSERT INTO mahasiswa (nim,nama_mhs,alamat,kota) VALUES ('A11.2022.01113','Dina','Jl Bulu
Lor','Semarang');
INSERT INTO mahasiswa (nim,nama_mhs,alamat,kota) VALUES ('A11.2022.01114','Vina','Jl Sumber','Cirebon');
INSERT INTO mahasiswa (nim,nama_mhs,alamat,kota) VALUES ('A11.2022.01115','Putri','Jl Siliwangi','Bandung');

-- isikan data pada tabel matakuliah --
INSERT INTO matakuliah(kode_mk,nama_mk,sks,smt) VALUES ('1001','Kalkulus',3,2);
INSERT INTO matakuliah(kode_mk,nama_mk,sks,smt) VALUES ('1002','Bhs Inggris',2,1);
INSERT INTO matakuliah(kode_mk,nama_mk,sks,smt) VALUES ('1003','Matematika Diskrit',3,2);
INSERT INTO matakuliah(kode_mk,nama_mk,sks,smt) VALUES ('1004','Dasar Pemrograman',4,1);
INSERT INTO matakuliah(kode_mk,nama_mk,sks,smt) VALUES ('1005','Alpro',4,2);
INSERT INTO matakuliah(kode_mk,nama_mk,sks,smt) VALUES ('1006','PBO',4,4);

-- isikan data pada tabel krs --
INSERT INTO krs (nim,kode_mk,kelp,ta,smt) VALUES ('A11.2022.01111','1002','101',2024,2) ;
INSERT INTO krs (nim,kode_mk,kelp,ta,smt) VALUES ('A11.2022.01111','1004','101',2024,2) ;
INSERT INTO krs (nim,kode_mk,kelp,ta,smt) VALUES ('A11.2022.01112','1001','101',2024,2) ;
INSERT INTO krs (nim,kode_mk,kelp,ta,smt) VALUES ('A11.2022.01112','1002','101',2024,2) ;
INSERT INTO krs (nim,kode_mk,kelp,ta,smt) VALUES ('A11.2022.01112','1003','101',2024,2) ;

-- isikan data pada tabel nilai_smt --
INSERT INTO nilai_smt (nim,kode_mk,kelp,ntugas,nuts,nuas,ta,smt) VALUES
('A11.2022.01111','1002','101',90,80,80,2024,2) ;
INSERT INTO nilai_smt (nim,kode_mk,kelp,ntugas,nuts,nuas,ta,smt) VALUES
('A11.2022.01111','1004','101',90,80,80,2024,2) ;
INSERT INTO nilai_smt (nim,kode_mk,kelp,ntugas,nuts,nuas,ta,smt) VALUES
('A11.2022.01112','1001','101',70,70,80,2024,2) ;
INSERT INTO nilai_smt (nim,kode_mk,kelp,ntugas,nuts,nuas,ta,smt) VALUES
('A11.2022.01112','1002','101',60,80,90,2024,2) ;
INSERT INTO nilai_smt (nim,kode_mk,kelp,ntugas,nuts,nuas,ta,smt) VALUES
('A11.2022.01112','1003','101',90,90,80,2024,2) ;

-- PENGGUNAAN IF dan case DALAM QUERY SELECT
SELECT nim,nuas FROM nilai_smt;
SELECT nim,nuas,IF(nuas>80,'ISTIMEWA','BAIK') AS keterangan FROM nilai_smt;
SELECT nim,nuas,IF(nuas>80,'ISTIMEWA',IF(nuas>70,'BAIK','CUKUP')) AS keterangan FROM nilai_smt;
SELECT nim,nuas,CASE WHEN nuas>80 THEN 'ISTIMEWA' WHEN nuas>70 THEN 'BAIK' ELSE 'kurang' END AS keterangan
FROM nilai_smt;

-- buat query utk menampilkan data dari tabel krs,matakuliah,mahasiswa
SELECT k.nim,mh.nama_mhs,k.kode_mk,mk.nama_mk,mk.sks FROM krs k,matakuliah mk,mahasiswa mh
WHERE k.nim=mh.nim AND k.kode_mk=mk.kode_mk;

-- buat query utk menampilkan data dari tabel nilai_smt,matakuliah,mahasiswa
SELECT n.nim,mh.nama_mhs,n.kode_mk,mk.nama_mk,mk.sks,n.ntugas,n.nuts,n.nuas FROM nilai_smt
n,matakuliah mk,mahasiswa mh WHERE n.nim=mh.nim AND n.kode_mk=mk.kode_mk;

-- buat view vkrs_mhs
CREATE VIEW vkrs AS
SELECT k.nim,mh.nama_mhs,k.kode_mk,mk.nama_mk,mk.sks FROM krs k,matakuliah mk,mahasiswa mh
WHERE k.nim=mh.nim AND k.kode_mk=mk.kode_mk;

-- buat view vnilai_mhs
CREATE VIEW vnilai_smt AS
SELECT n.nim,mh.nama_mhs,n.kode_mk,mk.nama_mk,mk.sks,n.ntugas,n.nuts,n.nuas FROM nilai_smt
n,matakuliah mk,mahasiswa mh
WHERE n.nim=mh.nim AND n.kode_mk=mk.kode_mk;

-- buat fungsi untuk menghitung NA ; (na=0.3*ntugas)+(0.3*nuts)+(0.4*nuas)
DELIMITER //
CREATE FUNCTION hitung_na(ntugas DECIMAL(4,2),nuts DECIMAL(4,2),nuas DECIMAL(4,2))
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
RETURN (0.3*ntugas)+(0.3*nuts)+(0.4*nuas) ;
END
//
SELECT hitung_na(90,90,70);

-- buat fungsi untuk mendapatkan nilai huruf menggunakan IF dan Case dalam stored Procedure
DELIMITER //
CREATE FUNCTION get_nilai_huruf(na DECIMAL(4,2))
RETURNS VARCHAR(2)
DETERMINISTIC
BEGIN
DECLARE huruf VARCHAR(2);
IF na < 50 THEN
SET huruf='E';
ELSEIF na < 60 THEN
SET huruf='D';
ELSEIF na < 65 THEN
SET huruf='C';
ELSEIF na < 70 THEN
SET huruf='BC';
ELSEIF na < 80 THEN
SET huruf='B';
ELSEIF na < 85 THEN
SET huruf='AB';
ELSE
SET huruf='A';
END IF ;
RETURN huruf;
END
//
DELIMITER ;
SELECT get_nilai_huruf(85);
-- ========================================================================== --
DELIMITER //
CREATE FUNCTION get_nilai_huruf2(na DECIMAL(4,2))
RETURNS VARCHAR(2)
DETERMINISTIC
BEGIN
DECLARE huruf VARCHAR(2);
CASE
WHEN na < 50 THEN
SET huruf='E';
WHEN na < 60 THEN
SET huruf='D';
WHEN na < 65 THEN
SET huruf='C';
WHEN na < 70 THEN
SET huruf='BC';
WHEN na < 80 THEN
SET huruf='B';
WHEN na < 85 THEN
SET huruf='AB';
ELSE
SET huruf='A';
END CASE;
RETURN huruf;
END
//
DELIMITER ;
SELECT get_nilai_huruf2(35);

-- buat store procedure untuk meng-update nilai angka
DELIMITER //
CREATE PROCEDURE updateNA()
BEGIN
UPDATE nilai_smt SET na_angka=hitung_na(ntugas,nuts,nuas);
SELECT * FROM nilai_smt;
END
//
DELIMITER ;
SELECT * FROM nilai_smt;
CALL updateNA();

-- buat store procedure untuk meng-update nilai huruf
DELIMITER //
CREATE PROCEDURE updateNH()
BEGIN
UPDATE nilai_smt SET na_huruf=get_nilai_huruf(na_angka);
SELECT * FROM nilai_smt;
END
//
DELIMITER ;
SELECT * FROM nilai_smt;
CALL updateNH();

-- buat trigger tinsert_krs jika ada insert data pada tabel krs , dengan menambahkan data yg di insert ke tabel log_krs
DELIMITER //
CREATE TRIGGER tinsert_krs
AFTER INSERT ON krs
FOR EACH ROW
INSERT INTO log_krs (tgl,kode_status,keterangan,nim,kode_mk,kelp,ta,smt)
VALUES (NOW(),'i','tambah data krs',New.nim,New.kode_mk,New.kelp,New.ta,New.smt);
//
DELIMITER ; -- test
INSERT INTO krs (nim,kode_mk,kelp,ta,smt) VALUES ('A11.2022.01112','1004','101',2024,2) ; -- cek
SELECT * FROM krs;
SELECT * FROM log_krs;

-- buat trigger tupdate_krs jika ada update data pada tabel krs, dengan menambahkan data yg di update ke tabel log_krs
DELIMITER //
CREATE TRIGGER tupdate_krs
AFTER UPDATE ON krs
FOR EACH ROW
INSERT INTO log_krs (tgl,kode_status,keterangan,nim,kode_mk,kelp,ta,smt)
VALUES (NOW(),'u','update data krs',New.nim,New.kode_mk,New.kelp,New.ta,New.smt);
//
DELIMITER ; -- test
UPDATE krs SET kelp='103' WHERE nim='A11.2022.01112' AND kode_mk='1004'; -- cek
SELECT * FROM krs;
SELECT * FROM log_krs;

-- Buat trigger tdelete_krs jika ada update data pada tabel krs, dengan menambahkan data yg di delete ke tabel log_krs
DELIMITER //
CREATE TRIGGER tdelete_krs
AFTER DELETE ON krs
FOR EACH ROW
INSERT INTO log_krs (tgl,kode_status,keterangan,nim,kode_mk,kelp,ta,smt)
VALUES (NOW(),'d','delete data krs',Old.nim,Old.kode_mk,Old.kelp,Old.ta,Old.smt);
//
DELIMITER ; -- test
DELETE FROM krs WHERE nim='A11.2022.01112' AND kode_mk='1004'; -- cek
SELECT * FROM krs;
SELECT * FROM log_krs;

-- LATIHAN 1 --
DELIMITER //

CREATE FUNCTION hitung_ipk(nim_param VARCHAR(20)) RETURNS FLOAT
BEGIN
    DECLARE total_bobot DECIMAL(10, 2) DEFAULT 0;
    DECLARE total_sks INT DEFAULT 0;

    -- Hitung total bobot nilai
    SELECT SUM(
        CASE 
            WHEN na_huruf = 'A' THEN 4 * na_angka
            WHEN na_huruf = 'AB' THEN 3.5 * na_angka
            WHEN na_huruf = 'B' THEN 3 * na_angka
            WHEN na_huruf = 'BC' THEN 2.5 * na_angka
            WHEN na_huruf = 'C' THEN 2 * na_angka
            WHEN na_huruf = 'D' THEN 1 * na_angka
            WHEN na_huruf = 'E' THEN 0 * na_angka
            ELSE 0
        END
    ) INTO total_bobot
    FROM nilai_smt
    WHERE nim = nim_param;
    
    SELECT SUM(na_angka) INTO total_sks
    FROM nilai_smt
    WHERE nim = nim_param;

    -- Hitung IPK
    IF total_sks > 3 THEN
        RETURN total_bobot / total_sks;
    ELSE
        RETURN 0;
    END IF;
END//

DELIMITER ;

SELECT hitung_ipk('a11.2022.01111');
SELECT hitung_ipk('a11.2022.00111') AS IPK;


-- Latihan No. 2 --
-- Membuat user vina dengan password password123
CREATE USER 'vina'@'localhost' IDENTIFIED BY '1234';

-- Memberikan hak akses ALL pada tabel nilai_smt
GRANT ALL PRIVILEGES ON dbakademik.nilai_smt TO 'vina'@'localhost';

-- Memberikan hak akses ALL pada tabel matakuliah
GRANT ALL PRIVILEGES ON dbakademik.matakuliah TO 'vina'@'localhost';

-- Memberikan hak akses ALL pada tabel mahasiswa
GRANT ALL PRIVILEGES ON dbakademik.mahasiswa TO 'vina'@'localhost';

-- Menyegarkan hak akses
FLUSH PRIVILEGES;

-- Latihan No 3 --
DELIMITER //

CREATE PROCEDURE insert_krs(
    IN p_nim VARCHAR(20),
    IN p_kode_mk VARCHAR(10),
    IN p_semester INT,
    IN p_tahun_akademik VARCHAR(10)
)
BEGIN
    INSERT INTO krs (nim, kode_mk, semester, tahun_akademik)
    VALUES (p_nim, p_kode_mk, p_semester, p_tahun_akademik);

    INSERT INTO log_krs (nim, kode_mk, semester, tahun_akademik, ACTION)
    VALUES (p_nim, p_kode_mk, p_semester, p_tahun_akademik, 'INSERT');
END//

CREATE PROCEDURE update_krs(
    IN p_nim VARCHAR(20),
    IN p_kode_mk VARCHAR(10),
    IN p_semester INT,
    IN p_tahun_akademik VARCHAR(10),
    IN p_new_kode_mk VARCHAR(10)
)
BEGIN
    UPDATE krs
    SET kode_mk = p_new_kode_mk
    WHERE nim = p_nim AND kode_mk = p_kode_mk AND semester = p_semester AND tahun_akademik = p_tahun_akademik;

    INSERT INTO log_krs (nim, kode_mk, semester, tahun_akademik, ACTION)
    VALUES (p_nim, p_new_kode_mk, p_semester, p_tahun_akademik, 'UPDATE');
END//

DELIMITER ;