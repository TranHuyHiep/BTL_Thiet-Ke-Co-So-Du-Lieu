USE [BTL_NHOM3_QLBanSach]
go
--câu 1: Tạo trigger cập nhật dữ liệu cho trường DonGiaBan mỗi khi thêm, sửa bản ghi vào bảng chi tiết hóa đơn bán.
create trigger CapNhatDGB on tChiTietHoaDonBan 
for insert, update 
as begin
	declare @dongia money, @MaHDB nvarchar(15), @MaSach nvarchar(10)
	select @MaHDB = MaHDB, @MaSach = MaSach from inserted
	select @dongia = DonGiaBan from tSach where @MaSach = MaSach
	update tChiTietHoaDonBan set DonGiaBan=@dongia where @MaHDB = MaHDB and @MaSach = MaSach
	update tChiTietHoaDonBan set ThanhTien = SoLuong*DonGiaBan - SoLuong*DonGiaBan*GiamGia/100 where @maHdb = MaHDB and @maSach = MaSach
	--update tHoaDonBan set TongTien = sum(ThanhTien) 
end
go
--Tao trigger cập nhật dữ liệu cho trường tổng tiền mỗi khi thêm, sửa bản ghi vào bảng chi tiết HDB
create trigger TongTienBan on tChiTietHoaDonBan
for insert, update, delete as
begin
declare @mahdb nvarchar(10), @mahdb1 nvarchar(10), @mahdb2 nvarchar(10),
@tongtien1 money,@tongtien2 money
select @mahdb1=mahdb, @tongtien1=ThanhTien from inserted 
select @mahdb2=mahdb, @tongtien2=ThanhTien from deleted 
if @mahdb1 is null 
 set @mahdb=@mahdb2 
else 
 set @mahdb=@mahdb1 
update tHoaDonBan set TongTien=isnull(TongTien,0)+isnull(@tongtien1,0)-
isnull(@tongtien2,0) where mahdb = @mahdb 
end

select * from tHoaDonBan
select * from tChiTietHoaDonBan
insert into tChiTietHoaDonBan values('HDB01', 'S05',10,null,10,null)
insert into tChiTietHoaDonBan values('HDB01', 'S01',1,null,10,null)

select * from tHoaDonBan
insert into tHoaDonBan values('HDB01','NV01', 'KH01', '2022-10-10',null,0)

delete from tHoaDonBan where MaHDB = 'HDB01'

go
--test
select * from tSach 
select * from tChiTietHoaDonBan
update tChiTietHoaDonBan set SoLuong = 10 where MaHDB = 'HDB01' and MaSach = 'S03'
select * from tChiTietHoaDonBan
drop trigger CapNhatDGB

--câu 2:  Thêm trường số lượng hóa đơn vào bảng khách hàng và cập nhật tự động cho trường này mỗi khi thêm, sửa, xóa hóa đơn
alter table dbo.tKhachHang
add slhd int
go
create trigger soluongHD on tHoaDonBan
for insert, update, delete 
as begin
	declare @maHD nvarchar(20), @ins int, @del int, @MaKH nvarchar(20)
	select @ins = 1, @MaKH = MaKhachHang from inserted
	select @del = 1, @MaKH = MaKhachHang from deleted
	update tKhachHang set slhd = ISNULL(slhd,0) + ISNULL(@ins,0) where @MaKH = MaKhachHang
	update tKhachHang set slhd = ISNULL(slhd,0) - ISNULL(@del,0) where @MaKH = MaKhachHang
end
drop trigger soluongHD
select * from tHoaDonBan
select * from tKhachHang
insert into tHoaDonBan(MaHDB, MaNhanVien, MaKhachHang) values(N'HDB03','NV01','KH01')
select * from tKhachHang
delete from tHoaDonBan where MaKhachHang = N'KH01' and MaHDB = N'HDB03'

--câu 3: Thêm trường số sản phẩm vào bảng hóa đơn bán, cập nhật tự động cho trường này mỗi khi thêm, xóa chi tiết hóa đơn
alter table dbo.tHoaDonBan
add Sosp int

create trigger TinhSoSp on tChiTietHoaDonBan 
for insert, delete 
as begin
	declare @mahdb1 nvarchar(20), @mahdb2 nvarchar(20), @ins int, @del int
	select @mahdb1 = MaHDB, @ins = 1 from inserted
	select @mahdb2 = MaHDB, @del = 1 from deleted
	update tHoaDonBan set Sosp = ISNULL(Sosp,0) + ISNULL(@ins,0)
	where @mahdb1=MaHDB
	update tHoaDonBan set Sosp = ISNULL(Sosp,0) - ISNULL(@del,0)
	where @mahdb2=MaHDB
end
drop trigger TinhSoSp
select* from tHoaDonBan
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
    N'S10',  -- MaSach - nvarchar(15)
    2,    -- SoLuong - int
    null, -- DonGiaBan - money
    0.0,  -- GiamGia - float
    NULL  -- ThanhTien - money
    )
select* from tHoaDonBan
delete from tChiTietHoaDonBan where MaHDB = 'HDB02' and MaSach = 'S10'

--câu 4: Thêm trường, dongia, tổng tiền cho hóa đơn nhập, cập nhật tự động cho trường này mỗi khi thêm chi tiết hóa đơn
create trigger CapNhatDGN on tChiTietHoaDonNhap
for insert, update 
as begin
	declare @dongia money, @MaHDN nvarchar(15), @MaSach nvarchar(10)
	select @MaHDN = MaHDN, @MaSach = MaSach from inserted
	select @dongia = DonGiaNhap from tSach where @MaSach = MaSach
	update tChiTietHoaDonNhap set DonGiaNhap=@dongia where @MaHDN = MaHDN and @MaSach = MaSach
	update tChiTietHoaDonNhap set ThanhTien = SoLuong*DonGiaNhap where @MaHDN = MaHDN and @MaSach = MaSach
end
go
drop trigger CapNhatDGN
select * from tNhaCungCap
insert into tNhaCungCap values('NCC01',N'Bình An', null,0)
select * from tHoaDonNhap
insert into tHoaDonNhap values('HDN01', 'NV01', '2022-10-09',null,null,'NCC01')
insert into tChiTietHoaDonNhap values('HDN01','S01','20',null,10,null)
select * from tChiTietHoaDonNhap
--câu 5: Thêm trường Số lượng sách và Thành tiền vào bảng nhà cung cấp, cập nhật dữ liệu cho trường này mỗi khi nhập sách.
alter table tNhaCungCap
add thanhtien money

alter table tNhaCungCap
add SLsach int

select * from tChiTietHoaDonNhap

create trigger cau5 on tChiTietHoaDonNhap
for insert 
as begin
	declare @mahdn nvarchar(20), @ins int, @mancc nvarchar(20), @tien money
	select  @mahdn = tHoaDonNhap.MaHDN, @mancc = MaNCC, @ins = 1, @tien = inserted.SoLuong * tSach.DonGiaNhap
	from inserted, tHoaDonNhap, tSach
	where inserted.MaHDN = tHoaDonNhap.MaHDN and tSach.MaSach = inserted.MaSach
	update tNhaCungCap set SLsach = ISNULL(SLsach, 0) + ISNULL(@ins,0)
	where @mancc=MaNCC 
	update tNhaCungCap set thanhtien = ISNULL(@tien,0) + ISNULL(thanhtien, 0)
	where @mancc=MaNCC 
end

drop trigger cau5
select * from tSach
select * from tHoaDonNhap
select * from tChiTietHoaDonNhap
select * from tNhaCungCap
insert tChiTietHoaDonNhap(MaHDN, MaSach, SoLuong) values(N'HDN01', N'S05', 10) 
select * from tNhaCungCap
delete from tChiTietHoaDonNhap where MaSach = 'S05' and MaHDN = 'HDN01'

--câu 6: Tạo trigger trên bảng thoadonban thực hiện xóa các chi tiết hóa đơn mỗi khi xóa hóa đơn
create trigger xoaHDB on tHoaDonBan instead of delete 
as begin
	declare @mahdb nvarchar(10)
	select @mahdb = MaHDB from deleted
	delete from tChiTietHoaDonBan where MaHDB = @mahdb
	delete from tHoaDonBan where MaHDB = @mahdb
end
select * from tHoaDonBan
select * from tChiTietHoaDonBan
delete from tHoaDonBan where MaHDB='HDB02'
select * from tChiTietHoaDonBan
drop trigger xoaHDB


select type, name
from sys.objects
where type in (
  'tr', -- triggers
  'p', -- procedures
  'if','fn','tf' -- functions
  --,'fs','ft' -- CLR functions
  )
  and is_ms_shipped = 0 -- user-defined

-- Câu 2: Tạo view danh sách nhân viên xuất sắc nhất trong tháng 5/2022,có tổng các hóa đơn bán và nhập cao nhất.
create view cau2n3 
as
SELECT top 1 with ties tNhanVien.MaNhanVien,  ISNULL(A.TongHDBan,0) + ISNULL(B.TongHDNhap,0) AS ChiTieu FROM 
( SELECT tNhanVien.MaNhanVien, count(tChiTietHoaDonBan.MaHDB) AS TongHDBan
FROM dbo.tHoaDonBan INNER JOIN dbo.tChiTietHoaDonBan ON tChiTietHoaDonBan.MaHDB = tHoaDonBan.MaHDB
join tNhanVien on tNhanVien.MaNhanVien= tHoaDonBan.MaNhanVien
WHERE YEAR(NgayBan) = 2022 AND MONTH(NgayBan) = 5 
GROUP BY tNhanVien.MaNhanVien ) AS A full outer join
(SELECT MaNhanVien,SUM(tChiTietHoaDonNhap.SoLuong) AS TongHDNhap FROM dbo.tHoaDonNhap INNER JOIN dbo.tChiTietHoaDonNhap ON tChiTietHoaDonNhap.MaHDN = tHoaDonNhap.MaHDN
WHERE YEAR(NgayNhap) = 2022 AND MONTH(NgayNhap) = 5 
GROUP BY MaNhanVien ) AS B ON B.MaNhanVien = A.MaNhanVien RIGHT JOIN dbo.tNhanVien ON tNhanVien.MaNhanVien = A.MaNhanVien
ORDER BY ChiTieu desc