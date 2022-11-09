--CREATE DATABASE BTL_NHOM3_QLTHUVIEN
--GO

CREATE TABLE tRole
(
  ID BIT NOT NULL,
  Ten NVARCHAR(20) NOT NULL,
  PRIMARY KEY (ID)
);
GO

CREATE TABLE tSinhVien
(
  MSV NVARCHAR(20) NOT NULL,
  HoTen NVARCHAR(50) NOT NULL,
  Lop NVARCHAR(20),
  Khoa NVARCHAR(20),
  SDT NVARCHAR(15),
  Email NVARCHAR(30),
  PRIMARY KEY (MSV)
);
GO

CREATE TABLE tThuThu
(
  MaThuThu NVARCHAR(20) NOT NULL,
  HoTen NVARCHAR(50) NOT NULL,
  SDT NVARCHAR(15),
  Email NVARCHAR(30),
  PRIMARY KEY (MaThuThu)
);
GO

CREATE TABLE tNhaXuatBan
(
  MaNXB NVARCHAR(20) NOT NULL,
  TenNXB NVARCHAR(20) NOT NULL,
  PRIMARY KEY (MaNXB)
);
GO

CREATE TABLE tTheLoai
(
  MaTheLoai NVARCHAR(20) NOT NULL,
  TenTheLoai NVARCHAR(30) NOT NULL,
  PRIMARY KEY (MaTheLoai)
);
GO

CREATE TABLE tPhieuMuon
(
  MaPhieuMuon NVARCHAR(20) NOT NULL,
  NgayMuon DATE,
  MSV NVARCHAR(20) NOT NULL,
  MaThuThu NVARCHAR(20) NOT NULL,
  PRIMARY KEY (MaPhieuMuon),
  FOREIGN KEY (MSV) REFERENCES dbo.tSinhVien(MSV),
  FOREIGN KEY (MaThuThu) REFERENCES dbo.tThuThu(MaThuThu)
);
GO

CREATE TABLE tPhieuTra
(
  MaPhieuTra NVARCHAR(20) NOT NULL,
  NgayTra DATE,
  MSV NVARCHAR(20) NOT NULL,
  MaThuThu NVARCHAR(20) NOT NULL,
  PRIMARY KEY (MaPhieuTra),
  FOREIGN KEY (MSV) REFERENCES dbo.tSinhVien(MSV),
  FOREIGN KEY (MaThuThu) REFERENCES dbo.tThuThu(MaThuThu)
);
GO

CREATE TABLE tViPham
(
  MaViPham NVARCHAR(20) NOT NULL,
  TenViPham NVARCHAR(50) NOT NULL,
  NoiDungViPham NVARCHAR(100) NOT NULL,
  MaPhieuTra NVARCHAR(20) NOT NULL,
  PRIMARY KEY (MaViPham),
  FOREIGN KEY (MaPhieuTra) REFERENCES dbo.tPhieuTra(MaPhieuTra)
);
GO

CREATE TABLE tAccount
(
  Username NVARCHAR(20) NOT NULL,
  Password NVARCHAR(20) NOT NULL,
  Email NVARCHAR(30) NOT NULL,
  ID BIT NOT NULL,
  MSV NVARCHAR(20),
  MaThuThu NVARCHAR(20),
  PRIMARY KEY (Username),
  FOREIGN KEY (ID) REFERENCES dbo.tRole(ID),
  FOREIGN KEY (MSV) REFERENCES dbo.tSinhVien(MSV),
  FOREIGN KEY (MaThuThu) REFERENCES dbo.tThuThu(MaThuThu)
);
GO

CREATE TABLE tTaiLieu
(
  MaTaiLieu NVARCHAR(20) NOT NULL,
  TenTaiLieu NVARCHAR(30),
  TenTacGia NVARCHAR(50),
  NamXB INT,
  GiaBia MONEY,
  SoLuong INT,
  SoTrang INT,
  MaTheLoai NVARCHAR(20) NOT NULL,
  MaNXB NVARCHAR(20) NOT NULL,
  PRIMARY KEY (MaTaiLieu),
  FOREIGN KEY (MaTheLoai) REFERENCES dbo.tTheLoai(MaTheLoai),
  FOREIGN KEY (MaNXB) REFERENCES dbo.tNhaXuatBan(MaNXB)
);
GO

CREATE TABLE tChiTietPhieuMuon
(
  SoLuongTaiLieu INT NOT NULL,
  MaPhieuMuon NVARCHAR(20) NOT NULL,
  MaTaiLieu NVARCHAR(20) NOT NULL,
  PRIMARY KEY (MaPhieuMuon, MaTaiLieu),
  FOREIGN KEY (MaPhieuMuon) REFERENCES dbo.tPhieuMuon(MaPhieuMuon),
  FOREIGN KEY (MaTaiLieu) REFERENCES dbo.tTaiLieu(MaTaiLieu)
);
GO

CREATE TABLE tChiTietPhieuTra
(
  SoLuongTaiLieu INT NOT NULL,
  MaPhieuTra NVARCHAR(20) NOT NULL,
  MaTaiLieu NVARCHAR(20) NOT NULL,
  PRIMARY KEY (MaPhieuTra, MaTaiLieu),
  FOREIGN KEY (MaPhieuTra) REFERENCES dbo.tPhieuTra(MaPhieuTra),
  FOREIGN KEY (MaTaiLieu) REFERENCES dbo.tTaiLieu(MaTaiLieu)
);
GO
-------------------------------- THÊM DỮ LIỆU VÀO CÁC BẢNG --------------------------------
-------------- Thêm 2 vào bảng tRole --------------
INSERT INTO dbo.tRole
(
    ID,
    Ten
)
VALUES
(   0, -- ID - bit
    N'ADMIN'   -- Ten - nvarchar(20)
    ),
(   1, -- ID - bit
    N'USER'   -- Ten - nvarchar(20)
    )
GO
-------------- Thêm 1 vào bảng tSinhVien --------------
INSERT INTO dbo.tSinhVien
(
    MSV,
    HoTen,
    Lop,
    Khoa,
    SDT,
    Email
)
VALUES
(   N'SV01', -- MSV - nvarchar(20)
    N'Trần Huy Hiệp', -- HoTen - nvarchar(50)
    N'CNTT1', -- Lop - nvarchar(20)
    N'K61', -- Khoa - nvarchar(20)
    N'0912421075', -- SDT - nvarchar(15)
    N'hieptran@gmail.com'  -- Email - nvarchar(30)
    )
GO
-------------- Thêm 1 vào bảng tThuThu --------------
INSERT INTO dbo.tThuThu
(
    MaThuThu,
    HoTen,
    SDT,
    Email
)
VALUES
(   N'TT01', -- MaThuThu - nvarchar(20)
    N'Đại học Giao Thông Vận Tải', -- HoTen - nvarchar(50)
    N'099999999', -- SDT - nvarchar(15)
    N'utc@edu.vn'  -- Email - nvarchar(30)
    )
GO
-------------- Thêm 2 vào bảng tAccount --------------
INSERT INTO dbo.tAccount
(
    Username,
    Password,
    Email,
    ID,
    MSV,
    MaThuThu
)
VALUES
(   N'hieptran',  -- Username - nvarchar(20)
    N'123123',  -- Password - nvarchar(20)
    N'hiep@gmail.com',  -- Email - nvarchar(30)
    1, -- ID - bit
    N'SV01',  -- MSV - nvarchar(20)
    NULL   -- MaThuThu - nvarchar(20)
    ),
(   N'utc',  -- Username - nvarchar(20)
    N'123123',  -- Password - nvarchar(20)
    N'utc@edu.vn',  -- Email - nvarchar(30)
    0, -- ID - bit
    NULL,  -- MSV - nvarchar(20)
    N'TT01'   -- MaThuThu - nvarchar(20)
    )
GO
-------------- Thêm 3 vào bảng tNhaXuatBan --------------
INSERT INTO dbo.tNhaXuatBan
(
    MaNXB,
    TenNXB
)
VALUES
(   N'NXB01', -- MaNXB - nvarchar(20)
    N'NXB Nhi Đồng'  -- TenNXB - nvarchar(20)
    ),
(   N'NXB02', -- MaNXB - nvarchar(20)
    N'NXB Giáo Dục'  -- TenNXB - nvarchar(20)
    ),
(   N'NXB03', -- MaNXB - nvarchar(20)
    N'NXB Trẻ'  -- TenNXB - nvarchar(20)
    )
GO
-------------- Thêm 3 vào bảng tTheLoai --------------
INSERT INTO dbo.tTheLoai
(
    MaTheLoai,
    TenTheLoai
)
VALUES
(   N'TL01', -- MaTheLoai - nvarchar(20)
    N'Tài liệu tham khảo'  -- TenTheLoai - nvarchar(30)
    ),
(   N'TL02', -- MaTheLoai - nvarchar(20)
    N'Sách nghiên cứu'  -- TenTheLoai - nvarchar(30)
    ),
(   N'TL03', -- MaTheLoai - nvarchar(20)
    N'Giáo trình'  -- TenTheLoai - nvarchar(30)
    )
GO
-------------- Thêm 5 vào bảng tTaiLieu --------------
INSERT INTO dbo.tTaiLieu
(
    MaTaiLieu,
    TenTaiLieu,
    TenTacGia,
    NamXB,
    GiaBia,
    SoLuong,
    SoTrang,
    MaTheLoai,
    MaNXB
)
VALUES
(   N'S01',  -- MaTaiLieu - nvarchar(20)
    N'Hoàng tử bé',  -- TenTaiLieu - nvarchar(30)
    N'Nguyễn Nhật Ánh',  -- TenTacGia - nvarchar(50)
    2014,    -- NamXB - int
    100000, -- GiaBia - money
    50,    -- SoLuong - int
    300,    -- SoTrang - int
    N'TL01',  -- MaTheLoai - nvarchar(20)
    N'NXB01'   -- MaNXB - nvarchar(20)
    ),
(   N'S02',  -- MaTaiLieu - nvarchar(20)
    N'Giải tích',  -- TenTaiLieu - nvarchar(30)
    N'Nguyễn Thành Long',  -- TenTacGia - nvarchar(50)
    2011,    -- NamXB - int
    75000, -- GiaBia - money
    100,    -- SoLuong - int
    500,    -- SoTrang - int
    N'TL03',  -- MaTheLoai - nvarchar(20)
    N'NXB02'   -- MaNXB - nvarchar(20)
    ),
(   N'S03',  -- MaTaiLieu - nvarchar(20)
    N'Lập Trình Trực Quan',  -- TenTaiLieu - nvarchar(30)
    N'Nguyễn Thu Hường',  -- TenTacGia - nvarchar(50)
    2022,    -- NamXB - int
    200000, -- GiaBia - money
    2000,    -- SoLuong - int
    425,    -- SoTrang - int
    N'TL03',  -- MaTheLoai - nvarchar(20)
    N'NXB03'   -- MaNXB - nvarchar(20)
    ),
(   N'S04',  -- MaTaiLieu - nvarchar(20)
    N'AI Trí tuệ nhân tạo',  -- TenTaiLieu - nvarchar(30)
    N'Rouhiainen',  -- TenTacGia - nvarchar(50)
    2016,    -- NamXB - int
    200000, -- GiaBia - money
    100,    -- SoLuong - int
    546,    -- SoTrang - int
    N'TL01',  -- MaTheLoai - nvarchar(20)
    N'NXB01'   -- MaNXB - nvarchar(20)
    ),
(   N'S05',  -- MaTaiLieu - nvarchar(20)
    N'BlockChain',  -- TenTaiLieu - nvarchar(30)
    N'Robert AnhXtanh',  -- TenTacGia - nvarchar(50)
    2002,    -- NamXB - int
    45000, -- GiaBia - money
    30,    -- SoLuong - int
    1320,    -- SoTrang - int
    N'TL01',  -- MaTheLoai - nvarchar(20)
    N'NXB03'   -- MaNXB - nvarchar(20)
    )
GO
-------------- Thêm 2 vào bảng tPhieuMuon --------------
INSERT INTO dbo.tPhieuMuon
(
    MaPhieuMuon,
    NgayMuon,
    MSV,
    MaThuThu
)
VALUES
(   N'PM01',       -- MaPhieuMuon - nvarchar(20)
    '2021-10-03', -- NgayMuon - date
    N'SV01',       -- MSV - nvarchar(20)
    N'TT01'        -- MaThuThu - nvarchar(20)
    ),
(   N'PM02',       -- MaPhieuMuon - nvarchar(20)
    '2020-01-01', -- NgayMuon - date
    N'SV01',       -- MSV - nvarchar(20)
    N'TT01'        -- MaThuThu - nvarchar(20)
    )
GO
-------------- Thêm 2 vào bảng tPhieuTra --------------
INSERT INTO dbo.tPhieuTra
(
    MaPhieuTra,
    NgayTra,
    MSV,
    MaThuThu
)
VALUES
(   N'PT01',       -- MaPhieuTra - nvarchar(20)
    '2022-11-03', -- NgayTra - date
    N'SV01',       -- MSV - nvarchar(20)
    N'TT01'        -- MaThuThu - nvarchar(20)
    ),
(   N'PT02',       -- MaPhieuTra - nvarchar(20)
    '2022-10-07', -- NgayTra - date
    N'SV01',       -- MSV - nvarchar(20)
    N'TT01'        -- MaThuThu - nvarchar(20)
    )
GO
-------------- Thêm 5 vào bảng tChiTietPhieuMuon --------------
INSERT INTO dbo.tChiTietPhieuMuon
(
    SoLuongTaiLieu,
    MaPhieuMuon,
    MaTaiLieu
)
VALUES
(   2,   -- SoLuongTaiLieu - int
    N'PM01', -- MaPhieuMuon - nvarchar(20)
    N'S01'  -- MaTaiLieu - nvarchar(20)
    ),
(   1,   -- SoLuongTaiLieu - int
    N'PM01', -- MaPhieuMuon - nvarchar(20)
    N'S02'  -- MaTaiLieu - nvarchar(20)
    ),
(   2,   -- SoLuongTaiLieu - int
    N'PM01', -- MaPhieuMuon - nvarchar(20)
    N'S05'  -- MaTaiLieu - nvarchar(20)
    ),
(   4,   -- SoLuongTaiLieu - int
    N'PM02', -- MaPhieuMuon - nvarchar(20)
    N'S03'  -- MaTaiLieu - nvarchar(20)
    ),
(   5,   -- SoLuongTaiLieu - int
    N'PM02', -- MaPhieuMuon - nvarchar(20)
    N'S04'  -- MaTaiLieu - nvarchar(20)
    )
GO
-------------- Thêm 5 vào bảng tChiTietPhieuTra --------------
INSERT INTO dbo.tChiTietPhieuTra
(
    SoLuongTaiLieu,
    MaPhieuTra,
    MaTaiLieu
)
VALUES
(   2,   -- SoLuongTaiLieu - int
    N'PT01', -- MaPhieuTra - nvarchar(20)
    N'S01'  -- MaTaiLieu - nvarchar(20)
    ),
(   1,   -- SoLuongTaiLieu - int
    N'PT01', -- MaPhieuTra - nvarchar(20)
    N'S02'  -- MaTaiLieu - nvarchar(20)
    ),
(   2,   -- SoLuongTaiLieu - int
    N'PT01', -- MaPhieuTra - nvarchar(20)
    N'S05'  -- MaTaiLieu - nvarchar(20)
    ),
(   4,   -- SoLuongTaiLieu - int
    N'PT02', -- MaPhieuTra - nvarchar(20)
    N'S03'  -- MaTaiLieu - nvarchar(20)
    ),
(   4,   -- SoLuongTaiLieu - int
    N'PT02', -- MaPhieuTra - nvarchar(20)
    N'S02'  -- MaTaiLieu - nvarchar(20)
    )
GO
-------------- Thêm 1 vào bảng tViPham --------------
INSERT INTO dbo.tViPham
(
    MaViPham,
    TenViPham,
    NoiDungViPham,
    MaPhieuTra
)
VALUES
(   N'VP01', -- MaViPham - nvarchar(20)
    N'Sai sách, thiếu số lượng', -- TenViPham - nvarchar(50)
    N'Sai sách và thiếu số lượng ở PT02 tài liệu S02', -- NoiDungViPham - nvarchar(100)
    N'PT02'  -- MaPhieuTra - nvarchar(20)
    )
GO
-------------------------- THỬ TRUY VẤN KIỂM TRA KẾT QUẢ --------------------------
SELECT * FROM dbo.tRole
SELECT * FROM dbo.tAccount
SELECT * FROM dbo.tSinhVien
SELECT * FROM dbo.tThuThu
SELECT * FROM dbo.tNhaXuatBan
SELECT * FROM dbo.tTheLoai
SELECT * FROM dbo.tTaiLieu
SELECT * FROM dbo.tPhieuTra
SELECT * FROM dbo.tPhieuMuon
SELECT * FROM dbo.tChiTietPhieuTra
SELECT * FROM dbo.tChiTietPhieuMuon
SELECT * FROM dbo.tViPham