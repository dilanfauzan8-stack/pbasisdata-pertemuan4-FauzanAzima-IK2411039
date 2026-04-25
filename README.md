# Tugas Pertemuan 4 - Struktur Kontrol Percabangan

**Nama:** Fauzan Azima
**NIM:** IK2411039
**Kelas:** Informatika

---

##  Deskripsi

Tugas ini membahas penggunaan struktur kontrol percabangan dalam MySQL, yaitu **IF-THEN-ELSE** dan **CASE**.
Percabangan digunakan untuk menentukan keputusan secara otomatis berdasarkan kondisi tertentu, seperti:

* penentuan grade mahasiswa
* status kelulusan
* kondisi stok barang
* perhitungan diskon

---

##  Struktur Repository

```
pbasisdata-pertemuan4-FauzanAzima-IK2411039
│
├── README.md
├── kode_sql/
│   └── kuis_pertemuan4.sql
└── laporan/
    └── laporan_analisis_pertemuan4_IK2411039.pdf
```

---

##  Fitur yang Dibuat

* Query menggunakan **CASE** untuk menentukan grade dan status
* Procedure:

  * `cek_kelulusan_if`
  * `cek_kelulusan_case`
  * `cek_status_stok`
  * `hitung_diskon`
  * `cek_predikat_mahasiswa`

---

##  Cara Menjalankan

1. Buka phpMyAdmin
2. Import file:

   ```
   kuis_pertemuan4.sql
   ```
3. Jalankan query atau procedure, contoh:

   ```
   CALL cek_kelulusan_if('IK2411039');
   CALL hitung_diskon(500000);
   ```

---

##  Catatan

* Data mahasiswa yang digunakan sudah disesuaikan untuk kebutuhan pengujian
* Semua query dan procedure telah diuji dan berjalan dengan baik

---

##  Link Repository

https://github.com/dilanfauzan8-stack/pbasisdata-pertemuan4-FauzanAzima-IK2411039

---

##  Dosen Pengajar

ABDUL MALIK, S.Kom., M.Cs.

---

##  Kesimpulan Singkat

Percabangan IF dan CASE sangat membantu dalam pengolahan data karena dapat membuat sistem mengambil keputusan secara otomatis berdasarkan kondisi tertentu.
