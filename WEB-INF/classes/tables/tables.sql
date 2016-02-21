create table login_digisafe(username varchar2(100) primary key,password varchar2(100),question 
varchar2(200),answer varchar2(200),check1 number(1))
/
insert into login_digisafe values('admin','aditya','what is java','language',2)
/
create table inbox_digisafe 
(username_receiver varchar2(100) references login_digisafe(username),
username_sender varchar2(100) references login_digisafe(username),
subject varchar2(1000),
message varchar2(4000),
message_digest long raw,
message_key varchar2(2000),
message_date date,
check1 number(1))
/
alter table inbox_digisafe add constraint inbox_date_pk primary key(message_date)
/
create table certificate_digisafe (username varchar2(100) references login_digisafe primary key,cfile varchar2(200))
/
create table sent_digisafe(user_receiver varchar2(100),
user_sender varchar2(100),
subject varchar2(500),
message varchar2(4000),
message_date date primary key)
/
create table attachment_digisafe(message_date date,attach1 varchar2(200),message_digest1 varchar2(200),
attach2 varchar2(200),
message_digest2 varchar2(200),
attach3 varchar2(200),
message_digest3 varchar2(200),
attach4 varchar2(200),
message_digest4 varchar2(200),
attach5 varchar2(200),
message_digest5 varchar2(200))
/
stop
/
