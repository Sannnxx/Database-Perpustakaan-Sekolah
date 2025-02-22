-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 22, 2025 at 06:01 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpus_ikhsan`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DataBuku` ()   begin
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
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dataBukuKeseluruhan` ()   begin 
	select distinct b.id_buku, b.judul_buku,
    if(p.id_peminjaman is not null, 'Pernah Dipinjam', 'Belum Pernah Dipinjam') AS riwayat_peminjamanBuku
    from buku b
    left join peminjaman p on b.id_buku = p.id_buku;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DataPeminjaman` ()   begin
	insert into peminjaman (id_siswa, id_buku, tanggal_pinjam, tanggal_kembali, status) values 
	(15, 7, "2025-02-01", "2025-02-08", "Dipinjam"),
	(7, 1, "2025-01-29", "2025-02-05", "Dikembalikan"),
	(8, 9, "2025-02-03", "2025-02-10", "Dipinjam"),
	(13, 4, "2025-01-27", "2025-02-03", "Dikembalikan"),
	(10, 11, "2025-02-01", "2025-02-08", "Dipinjam");
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DataSiswa` ()   begin
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
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dataSiswaKeseluruhan` ()   begin 
	select distinct s.id_siswa, s.nama, s.kelas,
    if(exists (select 1 from peminjaman p where p.id_siswa = s.id_siswa), 'Pernah Meminjam', 'Belum Pernah Meminjam') as riwayat_peminjamanSiswa
    from siswa s;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dataSiswaMeminjam` ()   begin 
	select distinct s.id_siswa, s.nama, s.kelas, p.status
    from siswa s
    join peminjaman p on s.id_siswa = p.id_siswa;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DelBuku` (IN `id_bukuDel` INT)   begin 
	delete from buku where id_buku = id_bukuDel;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DelPeminjaman` (IN `id_peminjamanDel` INT)   begin 
	delete from peminjaman where id_peminjaman = id_peminjamanDel;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DelSiswa` (IN `id_siswaDel` INT)   begin 
	delete from siswa where id_siswa = id_siswaDel;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `stokBukuBerkurang` (IN `id_siswaS` INT, IN `id_bukuS` INT)   begin 
	update buku set stok = stok - 1 where id_buku = id_bukuS;
    insert into peminjaman (
	id_siswa, id_buku, tanggal_pinjam, status) values 
	(id_siswaS, id_bukuS, current_date, "Dipinjam");
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `stokBukuBertambah` (IN `id_peminjamanT` INT, IN `id_bukuT` INT)   begin 
	update buku set stok = stok + 1 where id_buku = id_bukuT;
    update peminjaman set tanggal_kembali = current_date, status = "Dikembalikan" where id_peminjaman = id_peminjamanT;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkanBuku` ()   begin
	select * from buku;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkanPeminjaman` ()   begin
	select * from peminjaman;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkanSiswa` ()   begin
	select * from siswa;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateBuku` (IN `id_bukuUp` INT, IN `judul_bukuUp` VARCHAR(50), IN `penulisUp` VARCHAR(50), IN `kategoriUp` VARCHAR(30), IN `stockUp` INT)   begin 
	update buku set judul_buku = judul_bukuUp,
    penulis = penulisUp,
    kategori = kategoriUp, 
    stock = stockUp
    where id_buku = id_bukuUp;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePeminjaman` (IN `id_peminjamanUp` INT, IN `id_siswaUp` INT, IN `id_bukuUp` INT, IN `tanggal_pinjamUp` DATE, IN `tanggal_kembaliUp` DATE, IN `statusUp` VARCHAR(20))   begin 
	update peminjaman set id_siswa = id_siswaUp,
    id_buku = id_bukuUp,
    tanggal_pinjam = tanggal_pinjamUp, 
    tanggal_kembali = tanggal_kembaliUp,
    status = statusUp
    where id_peminjaman = id_peminjamanUp;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateSiswa` (IN `id_siswaUp` INT, IN `namaUp` VARCHAR(50), IN `kelasUp` VARCHAR(10))   begin 
	update siswa set nama = namaUp,
    kelas = kelasUp
    where id_siswa = id_siswaUp;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `id_buku` int NOT NULL,
  `judul_buku` varchar(50) DEFAULT NULL,
  `penulis` varchar(50) DEFAULT NULL,
  `kategori` varchar(30) DEFAULT NULL,
  `stok` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`id_buku`, `judul_buku`, `penulis`, `kategori`, `stok`) VALUES
(1, 'Algoritma dan Pemrograman', 'Andi Wijaya', 'Teknologi', 5),
(2, 'Dasar-Dasar Database', 'Budi Santoso', 'Teknologi', 7),
(3, 'Matematika Diskrit', 'Rina Sari', 'Matematika', 4),
(4, 'Sejarah Dunia', 'John Smith', 'Sejarah', 3),
(5, 'Pemrograman Web dengan PHP', 'Eko Prasetyo', 'Teknologi', 8),
(6, 'Sistem Operasi', 'Dian Kurniawan', 'Teknologi', 6),
(7, 'Jaringan Komputer', 'Ahmad Fauzi', 'Teknologi', 5),
(8, 'Cerita Rakyat Nusantara', 'Lestari Dewi', 'Sastra', 9),
(9, 'Bahasa Inggris untuk Pemula', 'Jane Doe', 'Bahasa', 10),
(10, 'Biologi Dasar', 'Budi Rahman', 'Sains', 7),
(11, 'Kimia Organik', 'Siti Aminah', 'Sains', 5),
(12, 'Teknik Elektro', 'Ridwan Hakim', 'Teknik', 6),
(13, 'Fisika Modern', 'Albert Einstein', 'Sains', 4),
(14, 'Manajemen Waktu', 'Steven Covey', 'Pengembangan ', 8),
(15, 'Strategi Belajar Efektif', 'Tony Buzan', 'Pendidikan', 6);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` int NOT NULL,
  `id_siswa` int DEFAULT NULL,
  `id_buku` int DEFAULT NULL,
  `tanggal_pinjam` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id_peminjaman`, `id_siswa`, `id_buku`, `tanggal_pinjam`, `tanggal_kembali`, `status`) VALUES
(1, 11, 2, '2025-02-01', '2025-02-08', 'Dipinjam'),
(2, 2, 5, '2025-01-28', '2025-02-04', 'Dikembalikan'),
(3, 3, 8, '2025-02-02', '2025-02-09', 'Dipinjam'),
(4, 4, 2, '2025-01-30', '2025-02-06', 'Dikembalikan'),
(5, 5, 3, '2025-01-25', '2025-02-01', 'Dikembalikan'),
(6, 15, 7, '2025-02-01', '2025-02-08', 'Dipinjam'),
(7, 7, 1, '2025-01-29', '2025-02-05', 'Dikembalikan'),
(8, 8, 9, '2025-02-03', '2025-02-10', 'Dipinjam'),
(9, 13, 4, '2025-01-27', '2025-02-03', 'Dikembalikan'),
(10, 10, 11, '2025-02-01', '2025-02-08', 'Dipinjam');

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `id_siswa` int NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `kelas` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `nama`, `kelas`) VALUES
(1, 'Andi Saputra', 'X-RPL'),
(2, 'Budi Wijaya', 'X-TKJ'),
(3, 'Citra Lestari', 'XI-RPL'),
(4, 'Dewi Kurniawan', 'XI-TKJ'),
(5, 'Eko Prasetyo', 'XII-RPL'),
(6, 'Farhan Maulana', 'XII-TKJ'),
(7, 'Gita Permata', 'X-RPL'),
(8, 'Hadi Sucipto', 'X-TKJ'),
(9, 'Intan Permadi', 'XI-RPL'),
(10, 'Joko Santoso', 'XI-TKJ'),
(11, 'Kartika Sari', 'XII-RPL'),
(12, 'Lintang Putri', 'XII-TKJ'),
(13, 'Muhammad Rizky', 'X-RPL'),
(14, 'Novi Andriana', 'X-TKJ'),
(15, 'Olivia Hernanda', 'XI-RPL');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buku`
--
ALTER TABLE `buku`
  MODIFY `id_buku` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
