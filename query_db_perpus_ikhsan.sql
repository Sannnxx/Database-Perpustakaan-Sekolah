-- 1. create database
create database db_perpus_ikhsan;
use db_perpus_ikhsan;

-- 2. create 3 table
create table buku (
	id_buku int primary key auto_increment, 
    judul_buku varchar (50), 
    penulis varchar (50), 
    kategori varchar (30), 
    stok int
);
create table siswa (
	id_siswa int primary key auto_increment,
    nama varchar (50),
    kelas varchar (10)
);
create table peminjaman (
	id_peminjaman int primary key auto_increment, 
    id_siswa int,
    id_buku int, 
    tanggal_pinjam date, 
    tanggal_kembali date,
    status varchar (20)
);
 
-- 3. input 5 record ke masing" tabel menggunakan insert 
insert into buku (judul_buku, penulis, kategori, stok) values
("Algoritma dan Pemrograman", "Andi Wijaya", "Teknologi", 5),
("Dasar-Dasar Database", "Budi Santoso", "Teknologi", 7),
("Matematika Diskrit", "Rina Sari", "Matematika", 4),
("Sejarah Dunia", "John Smith", "Sejarah", 3),
("Pemrograman Web dengan PHP", "Eko Prasetyo", "Teknologi", 8);
insert into siswa (nama, kelas) values 
("Andi Saputra", "X-RPL"),
("Budi Wijaya", "X-TKJ"),
("Citra Lestari", "XI-RPL"),
("Dewi Kurniawan", "XI-TKJ"),
("Eko Prasetyo", "XII-RPL");
insert into peminjaman (id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status) values
(11, 2, "2025-02-01", "2025-02-08", "Dipinjam"),
(2, 5, "2025-01-28", "2025-02-04", "Dikembalikan"),
(3, 8, "2025-02-02", "2025-02-09", "Dipinjam"),
(4, 2, "2025-01-30", "2025-02-06", "Dikembalikan"),
(5, 3, "2025-01-25", "2025-02-01", "Dikembalikan");
select * from buku;
select * from siswa;
select * from peminjaman;

-- 4. input 10 record di setiap tabel menggunakan stored procedure
DELIMITER $$ 
create procedure DataBuku ()
begin
	insert into buku (judul_buku, penulis, kategori, stok) values 
    ("Sistem Operasi", "Dian Kurniawan", "Teknologi", 6),
    ("Jaringan Komputer", "Ahmad Fauzi", "Teknologi", 5),
    ("Cerita Rakyat Nusantara", "Lestari Dewi", "Sastra", 9),
    ("Bahasa Inggris untuk Pemula", "Jane Doe", "Bahasa", 10),
    ("Biologi Dasar", "Budi Rahman", "Sains", 7),
    ("Kimia Organik", "Siti Aminah", "Sains", 5),
    ("Teknik Elektro", "Ridwan Hakim", "Teknik", 6),
    ("Fisika Modern", "Albert Einstein", "Sains", 4),
    ("Manajemen Waktu", "Steven Covey", "Pengembangan ", 8),
    ("Strategi Belajar Efektif", "Tony Buzan", "Pendidikan", 6);
end $$
DELIMITER ;
call DataBuku();
select * from buku;

DELIMITER $$ 
create procedure DataSiswa ()
begin
	insert into siswa (nama, kelas) values 
	("Farhan Maulana", "XII-TKJ"),
    ("Gita Permata", "X-RPL"),
    ("Hadi Sucipto", "X-TKJ"),
    ("Intan Permadi", "XI-RPL"),
    ("Joko Santoso", "XI-TKJ"),
    ("Kartika Sari", "XII-RPL"),
    ("Lintang Putri", "XII-TKJ"),
    ("Muhammad Rizky", "X-RPL"),
    ("Novi Andriana", "X-TKJ"),
    ("Olivia Hernanda", "XI-RPL");
end $$
DELIMITER ;
call DataSiswa();
select * from siswa;

DELIMITER $$ 
create procedure DataPeminjaman ()
begin
	insert into peminjaman (id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status) values 
	(15, 7, "2025-02-01", "2025-02-08", "Dipinjam"),
	(7, 1, "2025-01-29", "2025-02-05", "Dikembalikan"),
	(8, 9, "2025-02-03", "2025-02-10", "Dipinjam"),
	(13, 4, "2025-01-27", "2025-02-03", "Dikembalikan"),
	(10, 11, "2025-02-01", "2025-02-08", "Dipinjam");
end $$
DELIMITER ;
call DataPeminjaman();
select * from peminjaman;

-- 5. Buat stored procedure update & delete tiap tabel
DELIMITER $$ 
create procedure UpdateBuku (
	in id_bukuUp int,
    in judul_bukuUp varchar (50),
    in penulisUp varchar (50), 
    in kategoriUp varchar (30), 
    in stockUp int
)
begin 
	update buku set judul_buku = judul_bukuUp,
    penulis = penulisUp,
    kategori = kategoriUp, 
    stock = stockUp
    where id_buku = id_bukuUp;
end $$
DELIMITER ;

DELIMITER $$ 
create procedure DelBuku (
	in id_bukuDel int
)
begin 
	delete from buku where id_buku = id_bukuDel;
end $$
DELIMITER ;

DELIMITER $$ 
create procedure UpdateSiswa (
	in id_siswaUp int,
    in namaUp varchar (50),
    in kelasUp varchar (10)
)
begin 
	update siswa set nama = namaUp,
    kelas = kelasUp
    where id_siswa = id_siswaUp;
end $$
DELIMITER ;

DELIMITER $$ 
create procedure DelSiswa (
	in id_siswaDel int
)
begin 
	delete from siswa where id_siswa = id_siswaDel;
end $$
DELIMITER ;

DELIMITER $$ 
create procedure UpdatePeminjaman (
	in id_peminjamanUp int,
	in id_siswaUp int,
	in id_bukuUp int, 
	in tanggal_pinjamUp date, 
	in tanggal_kembaliUp date, 
	in statusUp varchar (20)
)
begin 
	update peminjaman set id_siswa = id_siswaUp,
    id_buku = id_bukuUp,
    tanggal_pinjam = tanggal_pinjamUp, 
    tanggal_kembali = tanggal_kembaliUp,
    status = statusUp
    where id_peminjaman = id_peminjamanUp;
end $$
DELIMITER ;
DELIMITER $$ 
create procedure DelPeminjaman (
	in id_peminjamanDel int
)
begin 
	delete from peminjaman where id_peminjaman = id_peminjamanDel;
end $$
DELIMITER ;

-- 6. Buat stored procedure untuk menampilkan seluruh record tiap tabel
DELIMITER $$ 
create procedure tampilkanBuku ()
begin
	select * from buku;
end $$
DELIMITER ;

DELIMITER $$ 
create procedure tampilkanSiswa ()
begin
	select * from siswa;
end $$
DELIMITER ;

DELIMITER $$ 
create procedure tampilkanPeminjaman ()
begin
	select * from peminjaman;
end $$
DELIMITER ;

-- 7. Stok buku berkurang saat dipinjam
DELIMITER $$ 
create procedure stokBukuBerkurang (
	in id_siswaS int,
    in id_bukuS int
)
begin 
	update buku set stok = stok - 1 where id_buku = id_bukuS;
    insert into peminjaman (
	id_siswa, id_buku, tanggal_pinjam, status) values 
	(id_siswaS, id_bukuS, current_date, "Dipinjam");
end $$ 
DELIMITER ;

-- 8-9. Stok buku bertambah saat dikembalikan dann tanggal pengembalian sesuai dengan tanggal saat dikembalikan
DELIMITER $$ 
create procedure stokBukuBertambah (
	in id_peminjamanT int, 
    in id_bukuT int
)
begin 
	update buku set stok = stok + 1 where id_buku = id_bukuT;
    update peminjaman set tanggal_kembali = current_date, status = "Dikembalikan" where id_peminjaman = id_peminjamanT;
end $$
DELIMITER ;

-- 10. Stored Procedure untuk menampilkan siswa yang pernah meminjam buku
DELIMITER $$ 
create procedure dataSiswaMeminjam ()
begin 
	select distinct s.id_siswa, s.nama, s.kelas, p.status
    from siswa s
    join peminjaman p on s.id_siswa = p.id_siswa;
end $$
DELIMITER ;
call dataSiswaMeminjam();

-- 11. Stored Procedure untuk menampilkan seluruh siswa yang pernah maupun yang tidak pernah meminjam buku
DELIMITER $$
create procedure dataSiswaKeseluruhan()
begin
	select distinct s.id_siswa, s.nama, s.kelas,
	if(p.id_peminjaman is not null, 'Pernah meminjam','Tidak pernah meminjam') as riwayat_peminjamanSiswa
	from siswa s
	left join peminjaman p on s.id_siswa = p.id_siswa;
end $$
DELIMITER ;
call dataSiswaKeseluruhan();
drop procedure dataSiswaKeseluruhan;

-- 12. Stored Procedure untuk menampilkan seluruh buku yang pernah maupun yang tidak pernah dipinjam
DELIMITER $$
create procedure dataBukuKeseluruhan ()
begin 
	select distinct b.id_buku, b.judul_buku,
    if(p.id_peminjaman is not null, 'Pernah Dipinjam', 'Belum Pernah Dipinjam') AS riwayat_peminjamanBuku
    from buku b
    left join peminjaman p on b.id_buku = p.id_buku;
end $$
DELIMITER ;
call dataBukuKeseluruhan();
