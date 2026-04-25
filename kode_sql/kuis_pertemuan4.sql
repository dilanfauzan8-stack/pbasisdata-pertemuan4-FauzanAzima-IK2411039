-- =========================================
-- TUGAS PERTEMUAN 4 - PERCABANGAN
-- =========================================

-- 1. DATABASE & TABEL MAHASISWA

CREATE DATABASE IF NOT EXISTS db_pertemuan4;
USE db_pertemuan4;

CREATE TABLE IF NOT EXISTS mahasiswa (
    nim VARCHAR(15) PRIMARY KEY,
    nama VARCHAR(100),
    nilai_akhir DECIMAL(5,2)
);

INSERT INTO mahasiswa (nim, nama, nilai_akhir) VALUES
('IK2411061', 'Muhammad Mahruf', 88),
('IK2411039', 'Fauzan Azima', 76),
('IK2411029', 'Gefran', 65),
('IK2411048', 'Sitti Rahma', 70),
('IK2411008', 'Aulia', 82),
('IK2411021', 'Ikrimansa', 60),
('IK2411049', 'Nadya Pratiwi Riswanto', 90);


-- 2. QUERY CASE (MENAMPILKAN GRADE & STATUS)

SELECT 
    nim,
    nama,
    nilai_akhir,
    CASE
        WHEN nilai_akhir >= 85 THEN 'A'
        WHEN nilai_akhir >= 75 THEN 'B'
        WHEN nilai_akhir >= 65 THEN 'C'
        WHEN nilai_akhir >= 50 THEN 'D'
        ELSE 'E'
    END AS grade,
    CASE
        WHEN nilai_akhir >= 65 THEN 'Lulus'
        ELSE 'Tidak Lulus'
    END AS status_kelulusan
FROM mahasiswa;


-- 3. PROCEDURE IF (CEK KELULUSAN)

DROP PROCEDURE IF EXISTS cek_kelulusan_if;
DELIMITER //

CREATE PROCEDURE cek_kelulusan_if(IN p_nim VARCHAR(15))
BEGIN
    DECLARE v_nama VARCHAR(100);
    DECLARE v_nilai DECIMAL(5,2);
    DECLARE v_grade CHAR(1);
    DECLARE v_status VARCHAR(50);

    SELECT nama, nilai_akhir
    INTO v_nama, v_nilai
    FROM mahasiswa
    WHERE nim = p_nim;

    IF v_nilai >= 85 THEN
        SET v_grade = 'A';
        SET v_status = 'Lulus Sangat Baik';
    ELSEIF v_nilai >= 75 THEN
        SET v_grade = 'B';
        SET v_status = 'Lulus Baik';
    ELSEIF v_nilai >= 65 THEN
        SET v_grade = 'C';
        SET v_status = 'Lulus Cukup';
    ELSEIF v_nilai >= 50 THEN
        SET v_grade = 'D';
        SET v_status = 'Tidak Lulus';
    ELSE
        SET v_grade = 'E';
        SET v_status = 'Tidak Lulus';
    END IF;

    SELECT p_nim AS nim, v_nama AS nama, v_nilai AS nilai,
           v_grade AS grade, v_status AS status;
END //

DELIMITER ;


-- 4. PROCEDURE CASE (CEK KELULUSAN)

DROP PROCEDURE IF EXISTS cek_kelulusan_case;
DELIMITER //

CREATE PROCEDURE cek_kelulusan_case(IN p_nim VARCHAR(15))
BEGIN
    DECLARE v_nama VARCHAR(100);
    DECLARE v_nilai DECIMAL(5,2);
    DECLARE v_grade CHAR(1);
    DECLARE v_status VARCHAR(50);

    SELECT nama, nilai_akhir
    INTO v_nama, v_nilai
    FROM mahasiswa
    WHERE nim = p_nim;

    CASE
        WHEN v_nilai >= 85 THEN
            SET v_grade = 'A';
            SET v_status = 'Lulus Sangat Baik';
        WHEN v_nilai >= 75 THEN
            SET v_grade = 'B';
            SET v_status = 'Lulus Baik';
        WHEN v_nilai >= 65 THEN
            SET v_grade = 'C';
            SET v_status = 'Lulus Cukup';
        WHEN v_nilai >= 50 THEN
            SET v_grade = 'D';
            SET v_status = 'Tidak Lulus';
        ELSE
            SET v_grade = 'E';
            SET v_status = 'Tidak Lulus';
    END CASE;

    SELECT p_nim AS nim, v_nama AS nama, v_nilai AS nilai,
           v_grade AS grade, v_status AS status;
END //

DELIMITER ;


-- 5. PROCEDURE CEK STATUS STOK

DROP PROCEDURE IF EXISTS cek_status_stok;
DELIMITER //

CREATE PROCEDURE cek_status_stok(IN p_stok INT)
BEGIN
    DECLARE v_status VARCHAR(50);

    IF p_stok = 0 THEN
        SET v_status = 'Habis';
    ELSEIF p_stok BETWEEN 1 AND 5 THEN
        SET v_status = 'Hampir Habis';
    ELSEIF p_stok BETWEEN 6 AND 20 THEN
        SET v_status = 'Tersedia';
    ELSE
        SET v_status = 'Stok Aman';
    END IF;

    SELECT CONCAT('Status: ', v_status) AS hasil;
END //

DELIMITER ;


-- 6. TABEL PRODUK + CASE

CREATE TABLE IF NOT EXISTS produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(100),
    stok INT
);

INSERT INTO produk (nama_produk, stok) VALUES
('Pensil', 3),
('Buku', 10),
('Penghapus', 0),
('Pulpen', 25),
('Spidol', 6);

SELECT 
    id_produk,
    nama_produk,
    stok,
    CASE
        WHEN stok = 0 THEN 'Habis'
        WHEN stok BETWEEN 1 AND 5 THEN 'Hampir Habis'
        WHEN stok BETWEEN 6 AND 20 THEN 'Tersedia'
        ELSE 'Stok Aman'
    END AS status_stok
FROM produk;


-- 7. PROCEDURE HITUNG DISKON

DROP PROCEDURE IF EXISTS hitung_diskon;
DELIMITER //

CREATE PROCEDURE hitung_diskon(IN p_total DECIMAL(12,2))
BEGIN
    DECLARE v_persen INT;
    DECLARE v_diskon DECIMAL(12,2);
    DECLARE v_total DECIMAL(12,2);

    IF p_total >= 1000000 THEN
        SET v_persen = 15;
    ELSEIF p_total >= 500000 THEN
        SET v_persen = 10;
    ELSEIF p_total >= 250000 THEN
        SET v_persen = 5;
    ELSE
        SET v_persen = 0;
    END IF;

    SET v_diskon = (v_persen / 100) * p_total;
    SET v_total = p_total - v_diskon;

    SELECT p_total AS total_belanja,
           v_persen AS diskon,
           v_diskon AS jumlah_diskon,
           v_total AS total_bayar;
END //

DELIMITER ;

-- =========================================
-- 8. PROCEDURE KUIS (PREDIKAT MAHASISWA)
-- =========================================
DROP PROCEDURE IF EXISTS cek_predikat_mahasiswa;
DELIMITER //

CREATE PROCEDURE cek_predikat_mahasiswa(IN p_nilai INT)
BEGIN
    DECLARE v_predikat VARCHAR(50);
    DECLARE v_status VARCHAR(20);

    IF p_nilai >= 90 THEN
        SET v_predikat = 'Sangat Memuaskan';
    ELSEIF p_nilai >= 80 THEN
        SET v_predikat = 'Memuaskan';
    ELSEIF p_nilai >= 70 THEN
        SET v_predikat = 'Baik';
    ELSEIF p_nilai >= 60 THEN
        SET v_predikat = 'Cukup';
    ELSE
        SET v_predikat = 'Kurang';
    END IF;

    IF p_nilai >= 70 THEN
        SET v_status = 'Lulus';
    ELSE
        SET v_status = 'Tidak Lulus';
    END IF;

    SELECT p_nilai AS nilai,
           v_predikat AS predikat,
           v_status AS status;
END //

DELIMITER ;

-- =========================================
-- CONTOH PEMANGGILAN
-- =========================================
CALL cek_kelulusan_if('230001');
CALL cek_kelulusan_case('230002');
CALL cek_status_stok(3);
CALL hitung_diskon(500000);
CALL cek_predikat_mahasiswa(85);
