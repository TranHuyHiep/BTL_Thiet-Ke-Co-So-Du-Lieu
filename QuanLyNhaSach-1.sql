--CREATE DATABASE BTL_NHOM3_QLBanSach
CREATE TABLE tChucVu (
	MaChucVu NVARCHAR(15) NOT NULL
	CONSTRAINT PK_tChucVu_MaChucVu PRIMARY KEY,
	TenChucVu NVARCHAR(20)
);

CREATE TABLE tNhanVien (
	MaNhanVien NVARCHAR(15) NOT NULL
	CONSTRAINT PK_tNhanVien_MaNhanVien PRIMARY KEY,
	TenNhanVien NVARCHAR(50),
	GioiTinh BIT,
	NgaySinh DATE,
	SDT NVARCHAR(11),
	DiaChi NVARCHAR(30),
	MaChucVu NVARCHAR(15) NOT NULL
	CONSTRAINT FK_tNhanVien_MaChucVu FOREIGN KEY(MaChucVu) REFERENCES tChucVu(MaChucVu)
);

CREATE TABLE tKhachHang (
	MaKhachHang NVARCHAR(15) NOT NULL
	CONSTRAINT PK_tKhachHang_MaKhachHang PRIMARY KEY,
	TenKhachHang NVARCHAR(50),
	SDT NVARCHAR(11),
	Email NVARCHAR(30),
	DiaChi NVARCHAR(30)
);

CREATE TABLE tTheLoai (
	MaTheLoai NVARCHAR(15) NOT NULL
	CONSTRAINT PK_tTheLoai_MaTheLoai PRIMARY KEY,
	TenTheLoai NVARCHAR(50)
);

CREATE TABLE tNhaXuatBan (
	MaNXB NVARCHAR(15) NOT NULL
	CONSTRAINT PK_tNhaXuatBan_MaNXB PRIMARY KEY,
	TenNXB NVARCHAR(20),
	Email NVARCHAR(30),
	DiaChi NVARCHAR(50)
);

CREATE TABLE tSach (
	MaSach NVARCHAR(15) NOT NULL
	CONSTRAINT PK_tSach_MaSach PRIMARY KEY,
	TenSach NVARCHAR(50),
	TacGia NVARCHAR(50),
	MaNXB NVARCHAR(15) NOT NULL,
	MaTheLoai NVARCHAR(15) NOT NULL,
	TenDichGia NVARCHAR(50),
	SoTrang INT,
	KhoSach VARCHAR(20),
	NgayPhatHanh DATE,
	SoLuong INT,
	DonGiaBan MONEY,
	DonGiaNhap MONEY,
	CONSTRAINT FK_tSach_MaNXB
				FOREIGN KEY(MaNXB)
				REFERENCES tNhaXuatBan(MaNXB),
	CONSTRAINT FK_tSach_MaTheLoai
				FOREIGN KEY(MaTheLoai) 
				REFERENCES tTheLoai(MaTheLoai),
);

CREATE TABLE tHoaDonBan (
	MaHDB NVARCHAR(15) NOT NULL
	CONSTRAINT PK_HoaDonBan_MaHDB PRIMARY KEY,
	MaNhanVien NVARCHAR(15) NOT NULL,
	MaKhachHang NVARCHAR(15) NOT NULL,
	NgayBan DATE,
	TongTien MONEY,
	CONSTRAINT FK_tHoaDonBan_MaNhanVien
				FOREIGN KEY(MaNhanVien)
				REFERENCES tNhanVien(MaNhanVien),
	CONSTRAINT FK_tHoaDonBan_MaKhachHang
				FOREIGN KEY(MaKhachHang) 
				REFERENCES tKhachHang(MaKhachHang),
);

create table tNhaCungCap(
	MaNCC NVARCHAR(15) NOT NULL
	CONSTRAINT PK_NhaCungCap_MaNCC PRIMARY KEY,
	TenNCC NVARCHAR(20)
);

CREATE TABLE tChiTietHoaDonBan (
	MaHDB NVARCHAR(15) NOT NULL,
	MaSach NVARCHAR(15) NOT NULL,
	SoLuong INT,
	DonGiaBan MONEY,
	GiamGia FLOAT,
	ThanhTien MONEY,
	CONSTRAINT PK_tChiTietHoaDonBan PRIMARY KEY(MaHDB, MaSach),
	CONSTRAINT FK_tChiTietHoaDonBan_MaHoaDon
				FOREIGN KEY(MaHDB)
				REFERENCES tHoaDonBan(MaHDB),
	CONSTRAINT FK_tChiTietHoaDonBan_MaSach 
				FOREIGN KEY(MaSach) 
				REFERENCES tSach(MaSach)
);

CREATE TABLE tHoaDonNhap (
	MaHDN NVARCHAR(15) NOT NULL 
	CONSTRAINT PK_tHoaDonNhap_MaHDN PRIMARY KEY,
	MaNhanVien NVARCHAR(15) NOT NULL,
	NgayNhap DATE,
	TongTien MONEY,
	MaNCC NVARCHAR(15),
	CONSTRAINT FK_tHoaDonNhap_MaNCC
				FOREIGN KEY(MaNCC)
				REFERENCES tNhaCungCap(MaNCC),
	CONSTRAINT FK_tHoaDonNhap_MaNhanVien
			FOREIGN KEY(MaNhanVien)
			REFERENCES tNhanVien(MaNhanVien)

);

CREATE TABLE tChiTietHoaDonNhap (
	MaHDN NVARCHAR(15) NOT NULL,
	MaSach NVARCHAR(15) NOT NULL,
	SoLuong INT,
	DonGiaNhap MONEY,
	ThanhTien MONEY,
	CONSTRAINT PK_tChiTietHoaDonNhap PRIMARY KEY(MaHDN, MaSach),
	CONSTRAINT FK_tChiTietHoaDonNhap_MaHDN
				FOREIGN KEY(MaHDN)
				REFERENCES tHoaDonNhap(MaHDN),
	CONSTRAINT FK_tChiTietHoaDonNhap_MaSach 
				FOREIGN KEY(MaSach) 
				REFERENCES tSach(MaSach)
);



select * from tTheLoai
delete from tTheLoai where MaTheLoai = 'TL02'
/*Thêm dữ liệu vào bảng thể loại */
INSERT dbo.tTheLoai
(
    MaTheLoai,
    TenTheLoai
)
VALUES
(   N'TL02', -- MaTheLoai - nvarchar(15)
    N'Truyện dài'  -- TenTheLoai - nvarchar(20)
    ),
(   N'TL01', -- MaTheLoai - nvarchar(15)
    N'Tiểu thuyết'  -- TenTheLoai - nvarchar(20)
    ),
(   N'TL03', -- MaTheLoai - nvarchar(15)
    N'Thiếu nhi'  -- TenTheLoai - nvarchar(20)
    ),
(   N'TL04', -- MaTheLoai - nvarchar(15)
    N'Lịch sử'  -- TenTheLoai - nvarchar(20)
    )

GO


/*Thêm dữ liệu vào bảng nhà xuất bản */
INSERT dbo.tNhaXuatBan
(
    MaNXB,
    TenNXB,
    Email,
    DiaChi
)
VALUES
(   N'NXB01', -- MaNXB - nvarchar(15)
    N'NXB Trẻ', -- TenNXB - nvarchar(20)
    N'tre@gmail.com', -- Email - nvarchar(15)
    N'Thành phố Hồ Chí Minh'  -- DiaChi - nvarchar(50)
    ),
(   N'NXB02', -- MaNXB - nvarchar(15)
    N'NXB Văn Học', -- TenNXB - nvarchar(20)
    N'vanhoc@gmail.com', -- Email - nvarchar(15)
    N'Hà Nội'  -- DiaChi - nvarchar(50)
    ),
(   N'NXB03', -- MaNXB - nvarchar(15)
    N'NXB Kim Đồng', -- TenNXB - nvarchar(20)
    N'kimdong@gmail.com', -- Email - nvarchar(15)
    N'Hà Nội'  -- DiaChi - nvarchar(50)
    ),
(   N'NXB04', -- MaNXB - nvarchar(15)
    N'NXB Giáo Dục', -- TenNXB - nvarchar(20)
    N'giaoduc@gmail.com', -- Email - nvarchar(15)
    N'Hà Nội'  -- DiaChi - nvarchar(50)
    )
GO

/*Thêm dữ liệu vào bảng sách */
INSERT dbo.tSach
(
    MaSach,
    TenSach,
    TacGia,
    MaNXB,
    MaTheLoai,
    TenDichGia,
    SoTrang,
    KhoSach,
    NgayPhatHanh,
    SoLuong,
    DonGiaBan,
    DonGiaNhap
)
VALUES
(   N'S01',       -- MaSach - nvarchar(15)
	N'Cha giàu cha nghèo', 
    N'Robert T.Kiyosaki',       -- TacGia - nvarchar(20)
    N'NXB01',       -- MaNXB - nvarchar(15)
    N'TL01',       -- MaTheLoai - nvarchar(15)
    N'Tạ Nguyễn Tấn Trương',       -- TenDichGia - nvarchar(20)
    414,         -- SoTrang - int
    '14x20cm',        -- KhoSach - varchar(20)
    '2010-09-12', -- NgayPhatHanh - date
    100,         -- SoLuong - int
    145000,      -- DonGiaBan - money
    120000       -- DonGiaNhap - money
    ),
(   N'S02',       -- MaSach - nvarchar(15)
	N'Gáy người thì lạnh', 
    N'Nguyễn Ngọc Tư',       -- TacGia - nvarchar(20)
    N'NXB01',       -- MaNXB - nvarchar(15)
    N'TL02',       -- MaTheLoai - nvarchar(15)
    null,       -- TenDichGia - nvarchar(20)
    152,         -- SoTrang - int
    '13x20cm',        -- KhoSach - varchar(20)
    '2021-04-05', -- NgayPhatHanh - date
    80,         -- SoLuong - int
    80000,      -- DonGiaBan - money
    60000       -- DonGiaNhap - money
    ),
(   N'S03',       -- MaSach - nvarchar(15)
	N'Thung lũng Đồng Vang', 
    N'Trung Sỹ',       -- TacGia - nvarchar(20)
    N'NXB01',       -- MaNXB - nvarchar(15)
    N'TL02',       -- MaTheLoai - nvarchar(15)
    null,       -- TenDichGia - nvarchar(20)
    236,         -- SoTrang - int
    '13x20cm',        -- KhoSach - varchar(20)
    '2021-03-06', -- NgayPhatHanh - date
    100,         -- SoLuong - int
    110000,      -- DonGiaBan - money
    80000       -- DonGiaNhap - money
    ),
(   N'S04',       -- MaSach - nvarchar(15)
	N'Còn chút gì để nhớ', 
    N'Nguyễn Nhật Ánh',       -- TacGia - nvarchar(20)
    N'NXB01',       -- MaNXB - nvarchar(15)
    N'TL02',       -- MaTheLoai - nvarchar(15)
    Null,       -- TenDichGia - nvarchar(20)
    250,         -- SoTrang - int
    '19x24cm',        -- KhoSach - varchar(20)
    '2022-04-05', -- NgayPhatHanh - date
    50,         -- SoLuong - int
    110000,      -- DonGiaBan - money
    60000       -- DonGiaNhap - money
    ),
(   N'S05',       -- MaSach - nvarchar(15)
	N'Tôi thấy hoa vàng trên cỏ xanh', 
    N'Nguyễn Nhật Ánh',       -- TacGia - nvarchar(20)
    N'NXB01',       -- MaNXB - nvarchar(15)
    N'TL02',       -- MaTheLoai - nvarchar(15)
    null,       -- TenDichGia - nvarchar(20)
    378,         -- SoTrang - int
    '13x20cm',        -- KhoSach - varchar(20)
    '2010-09-22', -- NgayPhatHanh - date
    50,         -- SoLuong - int
    82000,      -- DonGiaBan - money
    60000       -- DonGiaNhap - money
    ),
(   N'S06',       -- MaSach - nvarchar(15)
	N'Mắt biếc', 
    N'Nguyễn Nhật Ánh',       -- TacGia - nvarchar(20)
    N'NXB01',       -- MaNXB - nvarchar(15)
    N'TL02',       -- MaTheLoai - nvarchar(15)
    null,       -- TenDichGia - nvarchar(20)
    298,         -- SoTrang - int
    '13x20cm',        -- KhoSach - varchar(20)
    '2013-09-01', -- NgayPhatHanh - date
    100,         -- SoLuong - int
    110000,      -- DonGiaBan - money
    90000       -- DonGiaNhap - money
    ),
(   N'S07',       -- MaSach - nvarchar(15)
	N'Những bức di thư thành cổ', 
    N'Lê Bá Dương',       -- TacGia - nvarchar(20)
    N'NXB01',       -- MaNXB - nvarchar(15)
    N'TL04',       -- MaTheLoai - nvarchar(15)
    null,       -- TenDichGia - nvarchar(20)
    118,         -- SoTrang - int
    '15.5x20cm',        -- KhoSach - varchar(20)
    '2022-02-01', -- NgayPhatHanh - date
    100,         -- SoLuong - int
    130000,      -- DonGiaBan - money
    80000       -- DonGiaNhap - money
    ),
(   N'S08',       -- MaSach - nvarchar(15)
	N'Hành trình theo chân Bác', 
    N'Trần Đức Tuấn',       -- TacGia - nvarchar(20)
    N'NXB01',       -- MaNXB - nvarchar(15)
    N'TL04',       -- MaTheLoai - nvarchar(15)
    null,       -- TenDichGia - nvarchar(20)
    352,         -- SoTrang - int
    '14x20cm',        -- KhoSach - varchar(20)
    '2021-05-01', -- NgayPhatHanh - date
    20,         -- SoLuong - int
    125000,      -- DonGiaBan - money
    70000       -- DonGiaNhap - money
    ),
(   N'S09',       -- MaSach - nvarchar(15)
	N'Từ những hạt mầm-Gà choai trồng bắp', 
    N'Nguyễn Trần Thiên Lộc - Tố Ny',       -- TacGia - nvarchar(20)
    N'NXB03',       -- MaNXB - nvarchar(15)
    N'TL03',       -- MaTheLoai - nvarchar(15)
    null,       -- TenDichGia - nvarchar(20)
    24,         -- SoTrang - int
    '13x20cm',        -- KhoSach - varchar(20)
    '2022-02-01', -- NgayPhatHanh - date
    20,         -- SoLuong - int
    13000,      -- DonGiaBan - money
    5000       -- DonGiaNhap - money
    ),
(   N'S10',       -- MaSach - nvarchar(15)
	N'Cửa hàng thế giới tuổi thơ', 
    N'Sergey Sedov',       -- TacGia - nvarchar(20)
    N'NXB03',       -- MaNXB - nvarchar(15)
    N'TL03',       -- MaTheLoai - nvarchar(15)
    N'Quang Trung - Thụy Anh',       -- TenDichGia - nvarchar(20)
    84,         -- SoTrang - int
    '16.5x20cm',        -- KhoSach - varchar(20)
    '2022-04-02', -- NgayPhatHanh - date
    30,         -- SoLuong - int
    80000,      -- DonGiaBan - money
    40000       -- DonGiaNhap - money
    )
GO

/*Thêm dữ liệu vào nhân viên*/
INSERT INTO dbo.tChucVu
(
    MaChucVu,
    TenChucVu
)
VALUES
(   N'CV01', -- MaChucVu - nvarchar(15)
    N'Nhân viên'  -- TenChucVu - nvarchar(20)
    ),
(   N'CV02', -- MaChucVu - nvarchar(15)
    N'Quản lý'  -- TenChucVu - nvarchar(20)
    )
	 
/*Thêm dữ liệu vào nhân viên*/
INSERT INTO dbo.tNhanVien
(
    MaNhanVien,
    TenNhanVien,
    GioiTinh,
    NgaySinh,
    SDT,
    DiaChi,
    MaChucVu
)
VALUES
(   N'NV01',       -- MaNhanVien - nvarchar(15)
    N'Nguyễn Việt Anh',       -- TenNhanVien - nvarchar(20)
    1,      -- GioiTinh - bit
    '2002-01-01', -- NgaySinh - date
    N'0987654321',       -- SDT - nvarchar(11)
    N'Hà Nội',       -- DiaChi - nvarchar(30)
    N'CV02'        -- MaChucVu - nvarchar(15)
    ),
(   N'NV02',       -- MaNhanVien - nvarchar(15)
    N'Phan Văn Thường',       -- TenNhanVien - nvarchar(20)
    0,      -- GioiTinh - bit
    '2002-01-02', -- NgaySinh - date
    N'099999999',       -- SDT - nvarchar(11)
    N'Hà Nội',       -- DiaChi - nvarchar(30)
    N'CV01'        -- MaChucVu - nvarchar(15)
    )
GO

/*Thêm dữ liệu vào bảng khách hàng*/
INSERT INTO dbo.tKhachHang
(
    MaKhachHang,
    TenKhachHang,
    SDT,
    Email,
    DiaChi
)
VALUES
(   N'KH01', -- MaKhachHang - nvarchar(15)
    N'Trần Huy Hiệp', -- TenKhachHang - nvarchar(20)
    N'0912421088', -- SDT - nvarchar(11)
    N'hi@gmail.com', -- Email - nvarchar(15)
    N'Hà Giang'  -- DiaChi - nvarchar(30)
    ),
(   N'KH02', -- MaKhachHang - nvarchar(15)
    N'Vũ Huy Đức', -- TenKhachHang - nvarchar(20)
    N'091478132', -- SDT - nvarchar(11)
    N'duc@gmail.com', -- Email - nvarchar(15)
    N'Hà Nội'  -- DiaChi - nvarchar(30)
    ),
(   N'KH03', -- MaKhachHang - nvarchar(15)
    N'Nguyễn Đức Lộc', -- TenKhachHang - nvarchar(20)
    N'090966277', -- SDT - nvarchar(11)
    N'loc@gmail.com', -- Email - nvarchar(15)
    N'Hà Nội'  -- DiaChi - nvarchar(30)
    ),
(   N'KH04', -- MaKhachHang - nvarchar(15)
    N'Nguyễn Thế Hào', -- TenKhachHang - nvarchar(20)
    N'0998645333', -- SDT - nvarchar(11)
    N'hao@gmail.com', -- Email - nvarchar(15)
    N'Hà Nội'  -- DiaChi - nvarchar(30)
    )
GO

/*Thêm dữ liệu vào hóa đơn bán*/
INSERT INTO dbo.tHoaDonBan
(
    MaHDB,
    MaNhanVien,
    MaKhachHang,
    NgayBan,
    TongTien
)
VALUES
(   N'HDB01',       -- MaHDB - nvarchar(15)
    N'NV01',       -- MaNhanVien - nvarchar(15)
    N'KH01',       -- MaKhachHang - nvarchar(15)
    '2022-10-30', -- NgayBan - date
    NULL       -- TongTien - money
    ),
(   N'HDB02',       -- MaHDB - nvarchar(15)
    N'NV02',       -- MaNhanVien - nvarchar(15)
    N'KH02',       -- MaKhachHang - nvarchar(15)
    '2022-10-29', -- NgayBan - date
    NULL       -- TongTien - money
    ),
(   N'HDB03',       -- MaHDB - nvarchar(15)
    N'NV01',       -- MaNhanVien - nvarchar(15)
    N'KH01',       -- MaKhachHang - nvarchar(15)
    '2022-11-29', -- NgayBan - date
    NULL       -- TongTien - money
    ),
(   N'HDB04',       -- MaHDB - nvarchar(15)
    N'NV01',       -- MaNhanVien - nvarchar(15)
    N'KH03',       -- MaKhachHang - nvarchar(15)
    '2022-08-12', -- NgayBan - date
    NULL       -- TongTien - money
    ),
(   N'HDB05',       -- MaHDB - nvarchar(15)
    N'NV02',       -- MaNhanVien - nvarchar(15)
    N'KH04',       -- MaKhachHang - nvarchar(15)
    '2022-10-07', -- NgayBan - date
    NULL       -- TongTien - money
    )
GO
/*Thêm dữ liệu vào bảng chi tiết hóa đơn bán*/
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES
(   N'HDB01',  -- MaHDB - nvarchar(15)
    N'S04',  -- MaSach - nvarchar(15)
    2,    -- SoLuong - int
    null, -- DonGiaBan - money
    0.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES(   
	N'HDB02',  -- MaHDB - nvarchar(15)
    N'S10',  -- MaSach - nvarchar(15)
    1,    -- SoLuong - int
    null, -- DonGiaBan - money
    10.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB03',  -- MaHDB - nvarchar(15)
    N'S05',  -- MaSach - nvarchar(15)
    5,    -- SoLuong - int
    null, -- DonGiaBan - money
    10.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB04',  -- MaHDB - nvarchar(15)
    N'S02',  -- MaSach - nvarchar(15)
    5,    -- SoLuong - int
    null, -- DonGiaBan - money
    5.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB05',  -- MaHDB - nvarchar(15)
    N'S01',  -- MaSach - nvarchar(15)
    10,    -- SoLuong - int
    null, -- DonGiaBan - money
    10.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB02',  -- MaHDB - nvarchar(15)
    N'S02',  -- MaSach - nvarchar(15)
    7,    -- SoLuong - int
    null, -- DonGiaBan - money
    15.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB05',  -- MaHDB - nvarchar(15)
    N'S03',  -- MaSach - nvarchar(15)
    1,    -- SoLuong - int
    null, -- DonGiaBan - money
    0.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB01',  -- MaHDB - nvarchar(15)
    N'S03',  -- MaSach - nvarchar(15)
    3,    -- SoLuong - int
    null, -- DonGiaBan - money
    5.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB02',  -- MaHDB - nvarchar(15)
    N'S01',  -- MaSach - nvarchar(15)
    10,    -- SoLuong - int
    null, -- DonGiaBan - money
    10.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB03',  -- MaHDB - nvarchar(15)
    N'S04',  -- MaSach - nvarchar(15)
    5,    -- SoLuong - int
    null, -- DonGiaBan - money
    20.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB03',  -- MaHDB - nvarchar(15)
    N'S06',  -- MaSach - nvarchar(15)
    4,    -- SoLuong - int
    null, -- DonGiaBan - money
    0.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB03',  -- MaHDB - nvarchar(15)
    N'S07',  -- MaSach - nvarchar(15)
    2,    -- SoLuong - int
    null, -- DonGiaBan - money
    0.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB04',  -- MaHDB - nvarchar(15)
    N'S01',  -- MaSach - nvarchar(15)
    1,    -- SoLuong - int
    null, -- DonGiaBan - money
    0.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB04',  -- MaHDB - nvarchar(15)
    N'S04',  -- MaSach - nvarchar(15)
    2,    -- SoLuong - int
    null, -- DonGiaBan - money
    0.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB04',  -- MaHDB - nvarchar(15)
    N'S10',  -- MaSach - nvarchar(15)
    3,    -- SoLuong - int
    null, -- DonGiaBan - money
    10.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
INSERT INTO dbo.tChiTietHoaDonBan
(
    MaHDB,
    MaSach,
    SoLuong,
    DonGiaBan,
    GiamGia,
    ThanhTien
)
VALUES( 
	N'HDB05',  -- MaHDB - nvarchar(15)
    N'S02',  -- MaSach - nvarchar(15)
    2,    -- SoLuong - int
    null, -- DonGiaBan - money
    20.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
GO
insert into dbo.tNhaCungCap
(
	MaNCC,
	TenNCC
)
Values
(
	N'NCC01',
	N'Giáo dục'
),
(
	N'NCC02',
	N'Việt Long'
),
(
	N'NCC03',
	N'Đăng Nguyên'
)

insert into dbo.tHoaDonNhap 
(
	MaHDN,
	MaNhanVien,
	NgayNhap,
	TongTien,
	MaNCC
)
values
(
	N'HDN01',
	N'NV01',
	'2022-11-1',
	null,
	N'NCC02'

),
(
	N'HDN02',
	N'NV02',
	'2022-11-14',
	null,
	N'NCC03'
),
(
	N'HDN03',
	N'NV02',
	'2022-10-14',
	null,
	N'NCC03'
),
(
	N'HDN04',
	N'NV01',
	'2022-11-10',
	null,
	N'NCC01'
),
(
	N'HDN05',
	N'NV02',
	'2022-11-21',
	null,
	N'NCC02'
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN01',
	N'S04',
	13,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN01',
	N'S02',
	9,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN01',
	N'S03',
	15,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN02',
	N'S10',
	11,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN02',
	N'S05',
	13,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN02',
	N'S03',
	5,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN02',
	N'S04',
	2,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN03',
	N'S04',
	100,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN03',
	N'S07',
	50,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN03',
	N'S09',
	125,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN04',
	N'S04',
	50,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN04',
	N'S06',
	90,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN04',
	N'S08',
	100,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN05',
	N'S10',
	50,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN05',
	N'S03',
	50,
	null,
	null
)
GO
insert into dbo.tChiTietHoaDonNhap
(
	MaHDN,
	MaSach,
	SoLuong,
	DonGiaNhap,
	ThanhTien
)
values
(
	N'HDN05',
	N'S05',
	85,
	null,
	null
)
GO
SELECT * FROM dbo.tChiTietHoaDonBan
SELECT * FROM dbo.tHoaDonBan
select * from dbo.tHoaDonNhap
select * from dbo.tChiTietHoaDonNhap
select * from dbo.tChucVu
select * from dbo.tKhachHang
select * from dbo.tNhaCungCap
select * from dbo.tNhanVien
select * from dbo.tNhaXuatBan
select * from dbo.tTheLoai
SELECT * FROM dbo.tSach
