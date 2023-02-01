--- Tạo tablespace--(Cấp quyền system chạy trên Sql command line)
CREATE TABLESPACE teamspace1  
DATAFILE 'D:\query_sql\Tablespace01.dbf' SIZE 
100M autoextend on next 100m maxsize 1024m  extent management local; 

CREATE TABLESPACE teamspace3  
DATAFILE 'D:\query_sql\Tablespace03.dbf' SIZE 
100M autoextend on next 100m maxsize 1024m  extent management local;

CREATE TABLESPACE teamspace2 
DATAFILE 'D:\query_sql\Tablespace02.dbf' SIZE 
200M  autoextend on next 200m maxsize 2048m extent management local; 

--- Phân vùng dữ liệu ( Sql command line)
alter table Nentang move tablespace teamspace1;
alter table Hoptac move tablespace teamspace1;
alter table Nhaphathanhgame move tablespace teamspace1;
alter table Game move tablespace teamspace1;
alter table Streamer move tablespace teamspace1;
alter table Congdonate move tablespace teamspace1; 
alter table Sudung move tablespace teamspace2;
alter table Choi move tablespace teamspace2;
alter table Donate move tablespace teamspace2;
alter table Donater move tablespace teamspace2;  




-----------------10 câu sql----
--1.Đưa ra top streamer có số lượt đăng ký cao nhất ( LƯơng)
select maten from (select maten,sum(luotdangky) from sudung group by maten
order by sum(luotdangky) desc )
where rownum <= 3;

--2 Tổng tiền từng streamer nhận được qua các cổng donate ( MInh)
select a.maten, a.bietdanh, b.webcong, sum(sotien) as "Tong tien"
from streamer a, donate b where a.maten = b.maten
group by a.maten, a.bietdanh, b.webcong
order by b.webcong desc

--3. Thông tin của nhà phát hành game chưa từng hợp tác với nền tảng (LƯơng)
select manhaphathanh, tennhaphathanh from nhaphathanhgame
where not exists
(select manhaphathanh from hoptac where hoptac.manhaphathanh=nhaphathanhgame.manhaphathanh);

--3 Truy vấn tổng thời gian chơi của các game trên mỗi nền tảng 
select s.magame, a.tengame, g.website, round(sum(thoigianketthuc - thoigianbatdau),2) as "Tong thoi gian"
from choi s, game a, nhaphathanhgame n, hoptac c, nentang g where s.magame = a.magame
and n.manhaphathanh = a.manhaphathanh
and n.manhaphathanh = c.manhaphathanh
and c.website = g.website group by s.magame, a.tengame, g.website;

--4 Cho biet streamer nào chơi game pubg ( Nam)
select * from streamer str where str.maten 
in (select choi.maten from choi join game on choi.magame=game.magame where game.tengame='PUBG');

--5 Thống kê số nền tảng mà các streamer sử dụng và tổng số lượt đăng ký (Nam)
select sudung.website,count(sudung.website) as "so lan su dung" , sum(sudung.luotdangky) as "tong so luot dang ky"
from sudung group by sudung.website;

---6 Cho biết mỗi game có bao nhiêu streamer chơi ( Kiệt)
select choi.magame,count(choi.maten) as "so streamer choi"  from choi group by choi.magame;

--7 thong ke nha phat hanh phat hanh bao nhieu game cho biet tong so luot tai cua nha phat hanh do ( MInh)
SELECT game.manhaphathanh, nhaphathanhgame.tennhaphathanh,nhaphathanhgame.diachiweb, count(game.manhaphathanh)as "so game",
sum(game.soluottai)as "tong luot tai" 
from game join nhaphathanhgame on game.manhaphathanh=nhaphathanhgame.manhaphathanh 
group by game.manhaphathanh ,nhaphathanhgame.tennhaphathanh, nhaphathanhgame.diachiweb 
order by game.manhaphathanh ,nhaphathanhgame.tennhaphathanh, nhaphathanhgame.diachiweb desc;


--8 Tìm donater có số dư trên 10000000 là vip, còn lại là thường (Kiên)
select tentaikhoan,sodutaikhoan, case
when sodutaikhoan>10000000 then 'Vip'
else 'Thường'
end as "Khách"
from  donater;

--9 Tính tổng số tiền donate qua mỗi cổng trong năm 2022 từ nhỏ đến lớn ( Kiệt)
select webcong,sum(sotien) as "Tổng tiền" from donate 
where extract(year from(thoidiemdonate))= 2022 
group by webcong order by sum(sotien) ;


--10 Đưa ra tên streamer lớn tuổi nhất ( Kiên)
select maten,bietdanh from Streamer  
where extract(year from ngaysinh)= 
   (select min(extract( year from ngaysinh)) from streamer); 

---
---PL/SQL: 

--1. Function tạo mã giao dịch ngẫu nhiên khi insert dữ liệu cho donater ( Lương viết)
create or replace function random_str(v_length number) return varchar2 is
    my_str varchar2(4000);
begin
    for i in 1..v_length loop
        my_str := my_str || dbms_random.string(
            case when dbms_random.value(0, 1) < 0.5 then 'l' else 'x' end, 1);
    end loop;
    return my_str;
end;

set serveroutput on
declare
    ran  nvarchar2(50);

begin
    select random_str(5) into ran from dual ;
    dbms_output.put_line('Thông tin mã giao dịch: '||ran);
    Insert into Donater (madonater, webcong,tentaikhoan, sodutaikhoan, lichsugiaodich)
    values ('DN17', 'Streamlabs.com', 'TheCode', 7000000,'Mã giao dịch: '||ran||' ,Nội dung: Chuc');
end;

--2.Cho biết biệt danh người có số tiền được donate nhiều nhất, số tiền là bao nhiêu, 
--donater là ai, lịch sử giao dịch là gì ( Lương viết)
set serveroutput on
declare
bd streamer.bietdanh%type;
x nvarchar2(50);
ls nvarchar2(500);
tendonater donater.tentaikhoan%type;
tien donate.sotien%type;
begin
    select bietdanh, sotien into bd, tien from streamer join donate  
    on streamer.maten = donate.maten where sotien>= all(select sotien from donate);
    select loinhan into x from donate where sotien>= all(select sotien from donate);
    select lichsugiaodich,tentaikhoan into ls, tendonater from donater 
    where lichsugiaodich like'%'||x||'%';
    dbms_output.put_line('Biet danh nguoi co tien donate nhieu nhat: '||bd);
    dbms_output.put_line('So tien la: '||tien);
    dbms_output.put_line('Ten donater '||tendonater);
    dbms_output.put_line('Lich su giao dich:  '||ls);
end;

--3 Nhập vào mã game, cho biết tên game và số lượng streamer chơi MInh
set serveroutput on
declare
    a game.magame%type;
    b game.tengame%type;
    c number;
begin
    a:='&a';
    select distinct tengame, count(maten)
    into b, c
    from choi, game
    where choi.magame = game.magame
    and choi.magame = a
    group by choi.magame, tengame;
    dbms_output.put_line('Ma game: '||a||' ,Ten game: '||b||' ,Tong streamer: '||c);
end;

--4 Nhập vào mã nhà phát hành, xuất ra các game NPH đang phát hành 
set serveroutput on;
create or replace procedure
proc_nph(nph nhaphathanhgame.manhaphathanh%type)
is
begin
    for t in (select * from game a join nhaphathanhgame b on a.manhaphathanh = b.manhaphathanh and a.manhaphathanh = nph)
    loop
        dbms_output.put_line('Nha phat hanh: '||t.tennhaphathanh||chr(10)||'Ten game: '||t.tengame||
        chr(10)||'The loai: '||t.theloai||chr(10)||'So luot tai: '||t.soluottai);
    end loop;
end;


exec proc_nph('GRN');


--5.Đưa ra danh sách streamer sử dụng nền tảng, biết website nền tảng ( Kiên)
set serveroutput on
declare
    web sudung.website% TYPE;
    ten_tk sudung.tentaikhoan% type;
    dem number; 
    cursor cs_get is select tentaikhoan from sudung where website = web; 
begin
    web := '&web'; 
    select count(website) into dem from nentang where website = web;
    if(dem = 0) then 
    dbms_output.put_line('Website không tồn tại');
    else 
    dbms_output.put_line('Danh sách cac streamer live stream trên  '||web||':');
    open cs_get ;
    loop
    fetch cs_get into ten_tk;
    exit when cs_get%notfound;
    dbms_output.put_line(ten_tk); 
    end loop;
    end if;
    close cs_get;
end; 

--6. Nhập vào n top game được streamer chơi nhiều nhất ( Lương)
set serveroutput on
declare
    n int;
    tontai int;
begin
    select count(magame) into tontai from game;
    n:=&n;
    if (n > tontai) then
    dbms_output.put_line('Bạn nhập vào quá với số lượng game có trong cơ sở dữ liệu để có thể thống kê!');
    else
    dbms_output.put_line('Top '||n||' game duoc nhieu nguoi choi la: '); 
    for ds in (select magame from (select magame, count(maten) from game join choi using(magame) group by magame  
                 order by count(maten) desc) where rownum <= n) 
    loop 
    dbms_output.put_line(ds.magame||' ');
    end loop;
    end if;
end; 

-- 7 Tạo trigger không cho phép thay đổi mã streamer trong bảng streamer ( Nam)
create or replace trigger trig_not_change_st
before update of maten on streamer for each row
begin
    raise_application_error(-20000,'Không được phép!');
end;

update streamer set maten='ST_des' where maten='ST01';

----8.nhap vao 1 tháng va xem co streamer nao bat dau choi game trong thang do (Kiệt)
 set serveroutput on
 declare
 thang int;
 begin
 thang:=&thang;
 for numtb in(select maten  from choi where extract(month from(choi.thoigianbatdau))=thang)
 loop
 dbms_output.put_line(numtb.maten);
 end loop;
 end;
--

--9 Nhập vào 1 cổng donate và số tiền donate. Giả sử tính theo tỷ lệ chiết khấu của mỗi cổng cho donater,
--streamer nhận được bao nhiêu ( Kiệt)
set serveroutput on
declare
tenweb congdonate.webcong%type;
chietkhau congdonate.tilechietkhau%type;
sotien number;
tiennhandc number;
begin
  tenweb:='&tenweb';
  sotien:=&sotien;
  select tilechietkhau into chietkhau from congdonate where webcong=tenweb;
  tiennhandc:=sotien-(sotien*chietkhau*0.01) ;
  dbms_output.put_line('Neu donate: '||sotien||' Streamer se nhan duoc: '||' '||tiennhandc);
end;

--10 nhap vao ten game cho biet the loai va cho biet tong luot tai cua nha phat hang game do (Kiệt)
set serveroutput on
declare 
tenga game.tengame%type;
tl game.theloai%type;
manph game.manhaphathanh%type;
manph1 game.manhaphathanh%type;
maga game.magame%type;
tong number;
begin
   tenga:='&tenga';
   select theloai,magame,manhaphathanh into tl,maga,manph from game where tengame=tenga;
   select manhaphathanh,sum(soluottai)into manph1,tong  from game where game.manhaphathanh=manph group by game.manhaphathanh;
    dbms_output.put_line('Ma game: '||' '||maga);
    dbms_output.put_line('Ma nph: '||' '||manph);
    dbms_output.put_line('Tong luot tai cua nha phat hanh: '||' '||tong);
 end;



--


