USE [BTL_NHOM3_QLBanSach]

--view 
-- Câu 1: Tạo view liệt kê sách được bán nhiều nhất trong tháng 10, năm 2022
create view cau1n3 
as
select top(1) with ties tSach.MaSach,TenSach,Sum(tChiTietHoaDonBan.SoLuong) as SL
from tSach inner join tChiTietHoaDonBan on tSach.MaSach=tChiTietHoaDonBan.MaSach
join tHoaDonBan on tChiTietHoaDonBan.MaHDB=tHoaDonBan.MaHDB
where YEAR(NgayBan)=2022 and MONTH(NgayBan)=10
group by tSach.MaSach,TenSach
order by SL desc

select * from tChiTietHoaDonBan
select * from cau1n3

-- Câu 2: Tạo view danh sách nhân viên xuất sắc nhất trong tháng 5/2022,có tổng các hóa đơn bán và nhập cao nhất.
create view cau2n3 
as
SELECT top 1 with ties tNhanVien.MaNhanVien,  ISNULL(A.TongHDBan,0) + ISNULL(B.TongHDNhap,0) AS ChiTieu FROM 
( SELECT tNhanVien.MaNhanVien, count(tChiTietHoaDonBan.MaHDB) AS TongHDBan
FROM dbo.tHoaDonBan INNER JOIN dbo.tChiTietHoaDonBan ON tChiTietHoaDonBan.MaHDB = tHoaDonBan.MaHDB
join tNhanVien on tNhanVien.MaNhanVien= tHoaDonBan.MaNhanVien
WHERE YEAR(NgayBan) = 2022 AND MONTH(NgayBan) = 10 
GROUP BY tNhanVien.MaNhanVien ) AS A full outer join
(SELECT MaNhanVien,SUM(tChiTietHoaDonNhap.SoLuong) AS TongHDNhap FROM dbo.tHoaDonNhap INNER JOIN dbo.tChiTietHoaDonNhap ON tChiTietHoaDonNhap.MaHDN = tHoaDonNhap.MaHDN
WHERE YEAR(NgayNhap) = 2022 AND MONTH(NgayNhap) = 10 
GROUP BY MaNhanVien ) AS B ON B.MaNhanVien = A.MaNhanVien RIGHT JOIN dbo.tNhanVien ON tNhanVien.MaNhanVien = A.MaNhanVien
ORDER BY ChiTieu desc
drop view cau2n3
select * from tHoaDonNhap
select * from tChiTietHoaDonBan
select * from cau2n3
-- Câu 3: Tạo view danh sách top 10 khách hàng có tổng tiền các hóa đơn nhiều cao nhất trong năm 2022.
create view cau3n3
as
select top(10) with ties tKhachHang.MaKhachHang,TenKhachHang, sum(tChiTietHoaDonBan.SoLuong *tSach.DonGiaBan) as tong
from tKhachHang inner join tHoaDonBan on tKhachHang.MaKhachHang=tHoaDonBan.MaKhachHang
join tChiTietHoaDonBan on tChiTietHoaDonBan.MaHDB=tHoaDonBan.MaHDB
join tSach on tChiTietHoaDonBan.MaSach=tSach.MaSach
where YEAR(NgayBan)=2022
group by tKhachHang.MaKhachHang,TenKhachHang
order by tong
select * from cau3n3
-- Câu 4: Tạo view liệt kê các sách có giá bán từ 50.000-> 100.000đ
create view cau4n3
as 
select tSach.MaSach,TenSach, DonGiaBan
from tSach
where DonGiaBan between 50000 and 100000
select * from cau4n3
-- Câu 5: Tạo view liệt kê các sách không bán được trong tháng 10/2022
create view cau5n3
as
select tSach.MaSach,tSach.TenSach
from tSach
where not exists (select * 
							from tChiTietHoaDonBan,tHoaDonBan
							where tChiTietHoaDonBan.MaHDB=tHoaDonBan.MaHDB
							and tSach.MaSach=tChiTietHoaDonBan.MaSach
							and YEAR(NgayBan)=2022 and MONTH(NgayBan)=10)
select * from cau5n3
-- Câu 6: Tạo view liệt kê các sách có thể loại gì đó bán nhiều nhiều nhất.
create view cau6n3
as
select tSach.MaSach,TenSach,tSach.MaTheLoai
from tSach
where tSach.MaTheLoai in (select top(1) with ties tTheLoai.MaTheLoai
from tSach inner join tChiTietHoaDonBan on tSach.MaSach=tChiTietHoaDonBan.MaSach
join tHoaDonBan on tChiTietHoaDonBan.MaHDB=tHoaDonBan.MaHDB
join tTheLoai on tSach.MaTheLoai=tTheLoai.MaTheLoai
group by tTheLoai.MaTheLoai
order by Sum(tChiTietHoaDonBan.SoLuong) desc)

select * from cau6n3
--7. cho biết tổng số lượng sản phẩm đã nhập của mỗi nhà cung cấp trong quý nhập vào trong quý 4 nam 2022
create view Cau7n3
as
select tNhaCungCap.MaNCC, TenNCC, sum(tChiTietHoaDonNhap.SoLuong) as SLNhap
from tNhaCungCap inner join tHoaDonNhap on tNhaCungCap.MaNCC = tHoaDonNhap.MaNCC
inner join tChiTietHoaDonNhap on tChiTietHoaDonNhap.MaHDN = tHoaDonNhap.MaHDN
where MONTH(NgayNhap) >=10 and MONTH(NgayNhap) <=12 and YEAR(NgayNhap) = 2022
group by tNhaCungCap.MaNCC, TenNCC
select * from Cau7n3
--8. Tạo view tính tổng doanh thu trong tháng 10
create view Cau8n3 
as
select 'Doanh thu tháng 10' = sum(tChiTietHoaDonBan.SoLuong*tSach.DonGiaBan)
from tHoaDonBan inner join tChiTietHoaDonBan on tHoaDonBan.MaHDB = tChiTietHoaDonBan.MaHDB
inner join tSach on tSach.MaSach = tChiTietHoaDonBan.MaSach
where MONTH(NgayBan) = 10 and YEAR(NgayBan) = 2022
go
select * from Cau8n3
--proc
--1. Tạo hàm thủ tục có đầu vào là số mã sach đầu ra là số lượng hóa đơn bán sách đó
create proc cau1_p @masach nvarchar(20), @solg int output
as
begin
select @solg = count(tChiTietHoaDonBan.MaHDB)
from tChiTietHoaDonBan
where MaSach=@masach
end

declare @solg int
exec cau1_p N'S01', @solg output
print @solg

--2. Tạo hàm thủ tục có đầu vào là tên nhân viên đầu ra tổng tiền và số hóa đơn bán của nhân vien này.
create proc cau2_p @manv nvarchar(20), @tongtien money output, @tongsohd int output
as begin
select @tongtien = sum(tSach.DonGiaBan *tChiTietHoaDonBan.SoLuong)
from tSach inner join tChiTietHoaDonBan on tSach.MaSach = tChiTietHoaDonBan.MaSach
join tHoaDonBan on tChiTietHoaDonBan.MaHDB= tHoaDonBan.MaHDB
where MaNhanVien = @manv
select @tongsohd = count(tChiTietHoaDonBan.MaHDB)
from tChiTietHoaDonBan inner join tHoaDonBan on tChiTietHoaDonBan.MaHDB=tHoaDonBan.MaHDB
where MaNhanVien = @manv
end
declare @tongsotien money, @tongsohd int
exec cau2_p N'NV01', @tongsotien output, @tongsohd output
select @tongsotien, @tongsohd

print @tongsotien
print @tongsohd

--3. Tạo hàm thủ tục có đầu vào là tháng, năm đầu ra là số lượng hóa đơn và tổng tiền trong tháng năm đó
create proc cau3_p @thang int, @nam int, @sohd int output, @tongtien money output
as begin
select @tongtien = sum(tSach.DonGiaBan *tChiTietHoaDonBan.SoLuong)
from tSach inner join tChiTietHoaDonBan on tSach.MaSach = tChiTietHoaDonBan.MaSach
join tHoaDonBan on tChiTietHoaDonBan.MaHDB= tHoaDonBan.MaHDB
where MONTH(NgayBan)=@thang and YEAR(NgayBan)=@nam
select @sohd= count(tChiTietHoaDonBan.MaHDB)
from tSach inner join tChiTietHoaDonBan on tSach.MaSach = tChiTietHoaDonBan.MaSach
join tHoaDonBan on tChiTietHoaDonBan.MaHDB= tHoaDonBan.MaHDB
where MONTH(NgayBan)=@thang and YEAR(NgayBan)=@nam
end
declare @tongtien money, @sohd int
exec cau3_p 10,2022, @sohd output,@tongtien output
select @sohd as SoHD, @tongtien as TongTien
print @sohd
print @tongtien
--4. Tạo hàm thủ tục có đầu vào Tên tác giả , năm đầu ra số lượng sách của tác giả đã bán được trong năm đó
create proc cau4_p @tentg nvarchar(20), @nam int, @solg int output
as begin
select @solg = sum(tChiTietHoaDonBan.SoLuong)
from tSach inner join tChiTietHoaDonBan on tSach.MaSach = tChiTietHoaDonBan.MaSach
join tHoaDonBan on tChiTietHoaDonBan.MaHDB= tHoaDonBan.MaHDB
where YEAR(NgayBan) = @nam and TacGia=@tentg
end
declare @solg int
exec cau4_p N'Nguyễn Ngọc Tư',2022, @solg output
select @solg as test
select * from tSach
--5. Tạo hàm thủ tục có đầu vào là thể loại đầu ra là số lượng sách có thể loại đó.
create proc cau5_p @theloai nvarchar(20), @solg int output
as begin
select @solg= count(tSach.MaSach)
from tSach inner join tTheLoai on tSach.MaTheLoai=tTheLoai.MaTheLoai
where TenTheLoai = @theloai
end

declare @solg int
exec cau5_p N'Tiểu thuyết', @solg output
select @solg as test
print @solg
select * from tTheLoai
--6. Tạo hàm thủ tục có đầu vào là  Nhà cung cấp đầu ra là sốluong hóa đơn và tổng tiền của hóa đơn
create proc cau6_p @ncc nvarchar(20), @sohd int output, @tongtien money output
as begin
select @sohd= count(tHoaDonNhap.MaHDN)
from tSach inner join tChiTietHoaDonNhap on tSach.MaSach=tChiTietHoaDonNhap.MaSach
join tHoaDonNhap on tChiTietHoaDonNhap.MaHDN= tHoaDonNhap.MaHDN
JOIN tNhaCungCap on tHoaDonNhap.MaNCC = tNhaCungCap.MaNCC
where TenNCC= @ncc 
select @tongtien = sum(tChiTietHoaDonNhap.SoLuong * tSach.DonGiaNhap)
from tSach inner join tChiTietHoaDonNhap on tSach.MaSach=tChiTietHoaDonNhap.MaSach
join tHoaDonNhap on tChiTietHoaDonNhap.MaHDN= tHoaDonNhap.MaHDN
JOIN tNhaCungCap on tHoaDonNhap.MaNCC = tNhaCungCap.MaNCC
where TenNCC= @ncc 
end
declare @solg int, @tongtien money 
exec cau6_p N'Việt Long',@solg output,@tongtien output
print @solg
print @tongtien

select * from tNhaCungCap