--câu1 : Tạo hàm đưa ra tổng số tiền đã nhập sách trong một năm với tham số đầu vào là năm
create function tien(@nam int) returns table 
as return(
	select sum(tChiTietHoaDonNhap.SoLuong* tChiTietHoaDonNhap.DonGiaNhap) as TongTien
	from tChiTietHoaDonNhap, tHoaDonNhap
	where tChiTietHoaDonNhap.MaHDN=tHoaDonNhap.MaHDN and year(NgayNhap)=@nam
)
drop function tien
select * from dbo.tien(2022)
--caau2:  Tạo hàm đưa ra danh sách 5 đầu sách bán chạy nhất trong tháng nào đó (tháng là tham số đầu vào)
create function top5(@nam int , @thang int) returns table
as return(
	select top 5 with ties ctb.MaSach, s.TenSach, Max(ctb.SoLuong) Slb
	from tChiTietHoaDonBan ctb, tSach s, tHoaDonBan hdb
	where ctb.MaSach = s.MaSach and ctb.MaHDB = hdb.MaHDB and MONTH(NgayBan)= @thang and YEAR(NgayBan) = @nam 
	group by ctb.MaSach, s.TenSach
	order by Slb desc
)
select * from dbo.top5(2022,10)
select * from tHoaDonBan
select * from tChiTietHoaDonBan
--câu 3: Tạo hàm đưa ra danh sách n nhân viên có doanh thu cao nhất trong một năm với n và năm là tham số đầu vào
create function topNV (@top int , @year int) returns table 
as return(
	select top(@top) with ties tNhanVien.MaNhanVien, SUM(tChiTietHoaDonBan.SoLuong * tSach.DonGiaBan) as DoanhThu
	From tNhanVien, tHoaDonBan, tChiTietHoaDonBan, tSach
	Where tNhanVien.MaNhanVien = tHoaDonBan.MaNhanVien
			and tHoaDonBan.MaHDB = tChiTietHoaDonBan.MaHDB
			and tChiTietHoaDonBan.MaSach = tSach.MaSach
			and YEAR(NgayBan) = @year
	Group by tNhanVien.MaNhanVien
	Order by DoanhThu desc
)
Select * from topNV(10, 2022)
--cau4: Tạo hàm đưa ra thông tin Nhân viên sinh nhật trong ngày sinh là tham số nhập vào
create function SN (@birth date) returns table as
return(
	select * from tNhanVien
	where @birth = NgaySinh
)
select * from SN('2002-01-02')
--cau5:  Tạo hàm với đầu vào là ngày, đầu ra là thông tin các hóa đơn và trị giá của hóa đơn trong ngày đó
create function TTHD(@ngay int, @thang int, @nam int) returns table as
return(
	select tHoaDonBan.MaHDB, MaSach, NgayBan, MaKhachHang, SoLuong, sum(SoLuong*DonGiaBan) Tong from tChiTietHoaDonBan, tHoaDonBan
	where tChiTietHoaDonBan.MaHDB = tHoaDonBan.MaHDB and DAY(NgayBan) = @ngay and MONTH(NgayBan)= @thang and YEAR(NgayBan) = @nam
	group by tHoaDonBan.MaHDB, MaKhachHang, SoLuong, MaSach, NgayBan
)
drop function TTHD
select * from tHoaDonBan
select * from TTHD(30, 10, 2022)
--cau6:  Tạo hàm có đầu vào là mã loại, đầu ra là thông tin sách, số lượng sách nhập, số lượng sách bán của mỗi sách thuộc mã loại đó
create function Sl(@maSach nvarchar(20)) returns table as
return(
	select tSach.MaSach, TenSach,sum(tChiTietHoaDonBan.SoLuong) as slBan,sum(tChiTietHoaDonNhap.SoLuong) as slNhap from tSach, tChiTietHoaDonBan, tChiTietHoaDonNhap
	where tSach.MaSach=tChiTietHoaDonBan.MaSach and tSach.MaSach=tChiTietHoaDonNhap.MaSach and @maSach=tSach.MaTheLoai
	group by tSach.MaSach, TenSach
)
drop function Sl
select * from tTheLoai
select * from Sl('TL03')