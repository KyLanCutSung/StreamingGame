-- Tạo bảng
CREATE TABLE Streamer  
( 
  MATEN NVARCHAR2(50)PRIMARY KEY NOT NULL,
  BIETDANH NVARCHAR2(50), 
  GIOITINH NVARCHAR2(50), 
  DIACHI NVARCHAR2(50),
  NGAYSINH DATE,
  SODIENTHOAI NVARCHAR2(12) CHECK      
 (REGEXP_LIKE(SODIENTHOAI, '^0\d{9}$')) ); 
  

CREATE TABLE NenTang  
( 
  WEBSITE NVARCHAR2(50) PRIMARY KEY NOT NULL, 
  TENNENTANG NVARCHAR2(50), 
  APPDT NVARCHAR2(50)); 
 

CREATE TABLE NhaPhatHanhGame  
( 
  MANHAPHATHANH NVARCHAR2(50)PRIMARY KEY NOT NULL, 
  TENNHAPHATHANH NVARCHAR2(50), 
  DIACHIWEB NVARCHAR2(50)); 


CREATE TABLE HOPTAC  
( 
  WEBSITE NVARCHAR2(50) NOT NULL, 
  MANHAPHATHANH NVARCHAR2(50) NOT NULL, 
  HOPDONG NVARCHAR2(200), 
  UUDAI NVARCHAR2(200),
  THOIHAN NUMBER,
  Constraint pk_web_maNPH primary key (website,manhaphathanh),   Constraint fk_web_maNPH foreign key (website) references 
Nentang, 
  Constraint fk_maNPH_web foreign key (manhaphathanh) references Nhaphathanhgame 
); 
 
CREATE TABLE Game  
( 
  MAGAME NVARCHAR2(50) PRIMARY KEY NOT NULL,           
  MANHAPHATHANH NVARCHAR2(50) NOT NULL, 
  TENGAME NVARCHAR2(50) NOT NULL, 
  THELOAI NVARCHAR2(50) NOT NULL, 
  SOLUOTTAI NUMBER, 
  Constraint fk_manhaphathanh foreign key (manhaphathanh) references Nhaphathanhgame 
); 
 
CREATE TABLE CHOI  
( 
  MATEN NVARCHAR2(50) NOT NULL, 
  MAGAME NVARCHAR2(50) NOT NULL, 
  THOIGIANBATDAU DATE,
  THOIGIANKETTHUC DATE, 
  check (THOIGIANBATDAU < THOIGIANKETTHUC), 
  Constraint pk_S_G primary key (MATEN, MAGAME,THOIGIANBATDAU), 
  Constraint fk_ten_game foreign key ( MATEN)   references STREAMER, 
  Constraint fk_game_ten foreign key (MAGAME) references GAME
); 
drop table choi cascade constraints;

CREATE TABLE CongDonate  
( 
  WEBCONG NVARCHAR2(50) primary key NOT NULL, 
  TENCONG NVARCHAR2(50),
  TILECHIETKHAU FLOAT, 
     check(tilechietkhau >=0)); 
 
CREATE TABLE Donater  
( 
  MADONATER NVARCHAR2(50) PRIMARY KEY NOT NULL,
  WEBCONG NVARCHAR2 (50), 
  TENTAIKHOAN NVARCHAR2(50), 
  SODUTAIKHOAN number, 
  LICHSUGIAODICH NVARCHAR2(200),
  Constraint fk_webcong foreign key (webcong) references 
Congdonate 
); 


CREATE TABLE Donate  
( 
  MATEN NVARCHAR2(50) NOT NULL, 
  WEBCONG NVARCHAR2(50) NOT NULL, 
  SOTIEN number, 
  THOIDIEMDONATE DATE, 
  LOINHAN NVARCHAR2(200), 
  Constraint pk_maten_WebCong primary key 
(maten,webcong,thoidiemdonate), 
  Constraint fk_webcong_maten foreign key (webcong) references Congdonate, 
  Constraint fk_maten_webcong foreign key (maten) references Streamer 
); 


CREATE TABLE SuDung  
( 
  WEBSITE NVARCHAR2(50) NOT NULL, 
  MATEN NVARCHAR2(50) NOT NULL, 
  TENTAIKHOAN NVARCHAR2(50) NOT NULL,
  LUOTDANGKY number, 
  Constraint pk_maten_website primary key (maten, website), 
  Constraint fk_maten_website foreign key (maten) references Streamer, 
  Constraint fk_webite_maten foreign key (website) references Nentang 
); 

--Tạo định dạng 
    	
ALTER TABLE STREAMER

ADD CONSTRAINT CHK_MATEN CHECK (REGEXP_LIKE(MATEN,'^ST(*)'));

ALTER TABLE GAME

ADD CONSTRAINT CHK_MAGAME CHECK (REGEXP_LIKE(MAGAME,'^GA(*)'));

ALTER TABLE DONATER

ADD CONSTRAINT CHK_MADN CHECK (REGEXP_LIKE(MADONATER,'^DN(*)'));



-- Nhập dữ liệu:     
--Streamer--
Insert into Streamer (maten, bietdanh, gioitinh, diachi, ngaysinh, sodienthoai) 
values ('ST02', 'Pew Pew', 'Nam', 'Hai Phong', to_date('23/06/1991','dd/mm/yyyy'), '0965230167'); 
Insert into Streamer (maten, bietdanh, gioitinh, diachi, ngaysinh, sodienthoai) 
values ('ST01', 'Misthy', 'Nu', 'Da Lat', to_date('12/11/1995','dd/mm/yyyy'), '0349230897'); 
Insert into Streamer (maten, bietdanh, gioitinh, diachi, ngaysinh, sodienthoai) 
values ('ST03', 'Linh Ngoc Dam', 'Nu', 'Ha Noi', to_date('15/07/1996','dd/mm/yyyy'), '0379260190'); 
Insert into Streamer (maten, bietdanh, gioitinh, diachi, ngaysinh, sodienthoai) 
values ('ST04', 'Do Mixi', 'Nam', 'Cao Bang', to_date('22/09/1989','dd/mm/yyyy'), '0341239437'); 
Insert into Streamer (maten, bietdanh, gioitinh, diachi, ngaysinh, sodienthoai) 
values ('ST05', 'Cris Phan', 'Nam', 'Ho Chi Minh', to_date('04/06/1995','dd/mm/yyyy'), '0859230809'); 
Insert into Streamer (maten, bietdanh, gioitinh, diachi, ngaysinh, sodienthoai) 
values ('ST06', 'ViruSs', 'Nam', 'Ha Noi', to_date('09/05/1988','dd/mm/yyyy'), '0386496902');
Insert into Streamer (maten, bietdanh, gioitinh, diachi, ngaysinh, sodienthoai) 
values ('ST07', 'Dũng CT', 'Nam', 'Da Lat', to_date('15/03/1986','dd/mm/yyyy'), '0374726286');
Insert into Streamer (maten, bietdanh, gioitinh, diachi, ngaysinh, sodienthoai) 
values ('ST08', 'QTV', 'Nam', 'Thai Nguyen', to_date('07/03/1988','dd/mm/yyyy'), '0965197320');
Insert into Streamer (maten, bietdanh, gioitinh, diachi, ngaysinh, sodienthoai) 
values ('ST09', 'Xemesis', 'Nam', 'Ho Chi Minh', to_date('07/11/1989','dd/mm/yyyy'), '0869125909');
Insert into Streamer (maten, bietdanh, gioitinh, diachi, ngaysinh, sodienthoai) 
values ('ST10', 'Uyên Pu', 'Nu', 'Dong Thap', to_date('29/10/1996','dd/mm/yyyy'), '0869125238');

--NenTang--
Insert into Nentang (website, tennentang, appdt) values ('Nimo.tv', 'Nimo', 'Nimo TV app'); 
Insert into Nentang (website, tennentang, appdt) values ('Youtube.com', 'YouTube', 'YouTube');
Insert into Nentang (website, tennentang, appdt) values ('Twitch.tv', 'Twitch', 'Twitch app'); 
Insert into Nentang (website, tennentang, appdt) values ('FacebookGaming.com', 'FacebookGaming', 'Fb Gaming app'); 


--Nhaphathanhgame--
Insert into Nhaphathanhgame (manhaphathanh, tennhaphathanh, diachiweb) 
values ('VNG', 'Vinagame', 'Vinagame.com'); 
Insert into Nhaphathanhgame (manhaphathanh, tennhaphathanh, diachiweb) 
values ('Soha', 'Soha game', 'soha.com'); 
Insert into Nhaphathanhgame (manhaphathanh, tennhaphathanh, diachiweb) 
values ('GRN', 'Garena Vietnam', 'Garena.com'); 
Insert into Nhaphathanhgame (manhaphathanh, tennhaphathanh, diachiweb) 
values ('VTCG', 'VTC game', 'vtcgame.com');

--HOPTAC --
Insert into Hoptac (website, manhaphathanh,hopdong,uudai,thoihan) values ('nimo.tv', 'VNG','Rang buoc phap ly theo dieu kien', 'Ti le hoa hong toi da 20%', 
3); 
Insert into Hoptac (website, manhaphathanh,hopdong,uudai,thoihan) values ('FacebookGaming.com', 'VNG','Ben thu 3 lam chung, khong gia mao','So luong nguoi dung tang 10% moi thang', 4 );
Insert into Hoptac (website, manhaphathanh,hopdong,uudai,thoihan) values ('Twitch.tv', 'GRN','Rang buoc phap ly theo dieu kien','Chia co phan', 3 );
Insert into Hoptac (website, manhaphathanh,hopdong,uudai,thoihan) values ('Youtube.com', 'VTCG','Rang buoc phap ly theo dieu kien','Giam gia 20% khi co tai khoan lien ket vơi nen tang', 5 );

--Game--
Insert into Game (magame, manhaphathanh, tengame, theloai, soluottai) 
values ('GA01', 'GRN', 'League of legend', 'Chien thuat', 11192923); 
Insert into Game (magame, manhaphathanh, tengame, theloai, soluottai) 
values ('GA02', 'VNG', 'PUBG', 'Dong doi', 23145783);
Insert into Game (magame, manhaphathanh, tengame, theloai, soluottai) 
values ('GA03', 'VNG', 'CF', 'Tactic',1002908);
Insert into Game (magame, manhaphathanh, tengame, theloai, soluottai) 
values ('GA04', 'VTCG', 'Audition', 'Music', 900879);
Insert into Game (magame, manhaphathanh, tengame, theloai, soluottai) 
values ('GA05', 'Soha', 'Tan vuong', 'Kiem hiep',1928972); 
Insert into Game (magame, manhaphathanh, tengame, theloai, soluottai) 
values ('GA06', 'Soha', 'Anh hung xa dieu', 'Kiem hiep',728126); 

--Choi--
Insert into Choi (maten, magame, thoigianbatdau, thoigianketthuc) 
values ('ST01', 'GA01', TO_DATE('07/01/2022 1:45:16','dd/mm/yyyy 
HH:MI:SS'), TO_DATE('08/01/2022 3:50:33','dd/mm/yyyy HH:MI:SS')); 
Insert into Choi (maten, magame, thoigianbatdau, thoigianketthuc) 
values ('ST01', 'GA02', TO_DATE('16/03/2022 11:20:11','dd/mm/yyyy HH:MI:SS'), TO_DATE('16/03/2022 12:30:01','dd/mm/yyyy HH:MI:SS')); 
Insert into Choi (maten, magame, thoigianbatdau, thoigianketthuc) 
values ('ST06', 'GA05', TO_DATE('12/02/2022 2:12:22','dd/mm/yyyy 
HH:MI:SS'), TO_DATE('12/02/2022 5:50:15','dd/mm/yyyy HH:MI:SS')); 
Insert into Choi (maten, magame, thoigianbatdau, thoigianketthuc) 
values ('ST04', 'GA02', TO_DATE('21/03/2022 3:00:26','dd/mm/yyyy HH:MI:SS'), TO_DATE('21/03/2022 4:22:10','dd/mm/yyyy HH:MI:SS')); 
Insert into Choi (maten, magame, thoigianbatdau, thoigianketthuc) 
values ('ST02', 'GA01', TO_DATE('17/02/2022 08:39:22','dd/mm/yyyy 
HH:MI:SS'), TO_DATE('17/02/2022 11:20:23','dd/mm/yyyy HH:MI:SS')); 
Insert into Choi (maten, magame, thoigianbatdau, thoigianketthuc) 
values ('ST01', 'GA04', TO_DATE('26/02/2022 09:18:45','dd/mm/yyyy HH:MI:SS'), TO_DATE('26/02/2022 12:11:14','dd/mm/yyyy HH:MI:SS')); 
Insert into Choi (maten, magame, thoigianbatdau, thoigianketthuc) 
values ('ST08', 'GA01', TO_DATE('09/03/2022 12:12:22','dd/mm/yyyy 
HH:MI:SS'), TO_DATE('09/03/2023 12:50:55','dd/mm/yyyy HH:MI:SS')); 
Insert into Choi (maten, magame,thoigianbatdau, thoigianketthuc) 
values ('ST03', 'GA05', TO_DATE('12/02/2022 1:33:45','dd/mm/yyyy HH:MI:SS'), TO_DATE('12/02/2022 5:15:11','dd/mm/yyyy HH:MI:SS')); 
Insert into Choi (maten, magame, thoigianbatdau, thoigianketthuc) 
values ('ST01', 'GA03', TO_DATE('07/01/2022 2:03:23','dd/mm/yyyy HH:MI:SS'), TO_DATE('07/01/2022 4:14:56','dd/mm/yyyy HH:MI:SS')); 
Insert into Choi (maten, magame, thoigianbatdau, thoigianketthuc) 
values ('ST05', 'GA02', TO_DATE('24/03/2022 2:22:16','dd/mm/yyyy HH:MI:SS'), TO_DATE('24/03/2022 5:25:40','dd/mm/yyyy HH:MI:SS')); 
Insert into Choi (maten, magame, thoigianbatdau, thoigianketthuc) 
values ('ST10', 'GA06', TO_DATE('13/03/2022 3:12:16','dd/mm/yyyy HH:MI:SS'), TO_DATE('13/03/2022 6:05:20','dd/mm/yyyy HH:MI:SS')); 
Insert into Choi (maten, magame, thoigianbatdau, thoigianketthuc) 
values ('ST03', 'GA06', TO_DATE('13/03/2022 3:12:16','dd/mm/yyyy HH:MI:SS'), TO_DATE('13/03/2022 6:05:20','dd/mm/yyyy HH:MI:SS')); 
--CongDonate --
Insert into Congdonate (webcong, tencong, tilechietkhau) values ('Streamlabs.com', 'Streamlab', 10); 
Insert into Congdonate (webcong, tencong, tilechietkhau) values ('Unghotoi.com', 'Ung ho toi', 22); 
Insert into Congdonate (webcong, tencong, tilechietkhau) values ('Playerdou.com', 'Playerdou', 15.25); 

--Donater --
Insert into Donater (madonater, webcong,tentaikhoan, sodutaikhoan, lichsugiaodich) values ('DN11', 'Streamlabs.com', 'Theblues', 5000000,'Mã giao dịch:azv5g ,Nội dung: Chuc ban ngay cang phat trien'); 
Insert into Donater (madonater, webcong,tentaikhoan, sodutaikhoan, lichsugiaodich) values ('DN02', 'Streamlabs.com', 'Anio', 1000000,'Mã giao dịch:pom7h ,Nội dung: Em gui a 200k, mong a goi ten e!'); 
Insert into Donater (madonater, webcong,tentaikhoan, sodutaikhoan, lichsugiaodich) values ('DN03', 'Playerdou.com', 'Emado', 12000000,' Mã giao dịch: 1ertcw,Nội dung: Top fan Do Mixi mung a 1 trieu'); 
Insert into Donater (madonater, webcong,tentaikhoan, sodutaikhoan, lichsugiaodich) values ('DN04', 'Unghotoi.com', 'KietHuyHa', 3000000,' Mã giao dịch:xcvty ,Nội dung: Rat giai tri bro!'); 
Insert into Donater (madonater, webcong,tentaikhoan, sodutaikhoan, lichsugiaodich) values ('DN05', 'Streamlabs.com', 'MinhKien', 2000000,' Mã giao dịch:bhyrt ,Nội dung: Mung a'); 
Insert into Donater (madonater, webcong,tentaikhoan, sodutaikhoan, lichsugiaodich) values ('DN06', 'Streamlabs.com', 'TeamLih', 5000000,'Mã giao dịch:yuio1 ,Nội dung: Chuc c ngay cang phat trien'); 
Insert into Donater (madonater, webcong,tentaikhoan, sodutaikhoan, lichsugiaodich) values ('DN07', 'Streamlabs.com', 'DavidViet', 5000980,'Mã giao dịch:bshyu ,Nội dung: Gui chi tien tips'); 
Insert into Donater (madonater, webcong,tentaikhoan, sodutaikhoan, lichsugiaodich) values ('DN08', 'Playerdou.com', 'TopView', 10200000,' Mã giao dịch:awcts ,Nội dung: Mai tiep tuc nhe a!'); 
Insert into Donater (madonater, webcong,tentaikhoan, sodutaikhoan, lichsugiaodich) values ('DN09', 'Unghotoi.com', 'TenTenTen', 400000,' Mã giao dịch:thy4q ,Nội dung: Vi ban xung dang'); 
Insert into Donater (madonater, webcong,tentaikhoan, sodutaikhoan, lichsugiaodich) values ('DN10', 'Streamlabs.com', 'HackK', 8000111,' Mã giao dịch:sh1tk ,Nội dung: Uy tin'); 

--Sudung --
Insert into Sudung (website, maten, tentaikhoan, luotdangky) values ('Nimo.tv', 'ST01', 'Misthy_nm', 2483478); 
Insert into Sudung (website, maten, tentaikhoan, luotdangky) values ('Nimo.tv', 'ST02', 'Pew Pew_nm', 1456823); 
Insert into Sudung (website, maten, tentaikhoan, luotdangky) values ('Twitch.tv', 'ST03', 'Linh Ngoc Dam_tw', 1289609); 
Insert into Sudung (website, maten, tentaikhoan, luotdangky) values ('Nimo.tv', 'ST04', 'Do Mixi_nm', 2678545); 
Insert into Sudung (website, maten, tentaikhoan, luotdangky) values ('Youtube.com', 'ST05', 'Cris Phan_yt', 1197356); 
Insert into Sudung (website, maten, tentaikhoan, luotdangky) values ('FacebookGaming.com', 'ST06', 'ViruSs_fb', 1394521); 
Insert into Sudung (website, maten, tentaikhoan, luotdangky) values ('Youtube.com', 'ST07', 'Dũng CT_yt', 3167104); 
Insert into Sudung (website, maten, tentaikhoan, luotdangky) values ('Youtube.com', 'ST08', 'OTV_yt', 772245); 
Insert into Sudung (website, maten, tentaikhoan, luotdangky) values ('Youtube.com', 'ST09', 'Xemesis_yt', 978923); 
Insert into Sudung (website, maten, tentaikhoan, luotdangky) values ('Youtube.com', 'ST10', 'Uyên Pu_yt', 170219); 
 
--Donate
Insert into Donate (maten, webcong, sotien, thoidiemdonate, loinhan) 
values ('ST01', 'Streamlabs.com', 100000, to_date('22/03/2022 03:50:25','dd/mm/yyyy HH:MI:SS'), 'Chuc ban ngay cang phat trien');
Insert into Donate (maten, webcong, sotien, thoidiemdonate, loinhan) 
values ('ST02', 'Streamlabs.com', 1000000, to_date('09/02/2022 11:30:25','dd/mm/yyyy HH:MI:SS'), ' Em gui a 200k, mong a goi ten e!'); 
Insert into Donate (maten, webcong, sotien, thoidiemdonate, loinhan) 
values ('ST04', 'Playerdou.com', 300000, to_date('11/09/2020 5:30:25','dd/mm/yyyy HH:MI:SS'), 'Top fan Do Mixi mung a 1 trieu');
Insert into Donate (maten, webcong, sotien, thoidiemdonate, loinhan) 
values ('ST03', 'Streamlabs.com', 200000, to_date('07/09/2020 10:01:42','dd/mm/yyyy HH:MI:SS'), 'Uy tin'); 
Insert into Donate (maten, webcong, sotien, thoidiemdonate, loinhan) 
values ('ST08', 'Unghotoi.com', 500000, to_date('09/03/2022 12:20:22','dd/mm/yyyy HH:MI:SS'), 'Vi ban xung dang'); 
Insert into Donate (maten, webcong, sotien, thoidiemdonate, loinhan) 
values ('ST07', 'Unghotoi.com', 800000, to_date('21/03/2022 2:20:35','dd/mm/yyyy HH:MI:SS'), 'Rat giai tri bro!'); 
Insert into Donate (maten, webcong, sotien, thoidiemdonate, loinhan) 
values ('ST06', 'Streamlabs.com', 700000, to_date('12/02/2022 3:22:22','dd/mm/yyyy HH:MI:SS'), 'Mung a'); 
Insert into Donate (maten, webcong, sotien, thoidiemdonate, loinhan) 
values ('ST10', 'Streamlabs.com', 900000, to_date('07/09/2020 10:11:12','dd/mm/yyyy HH:MI:SS'), 'Gui chi tien tips'); 
