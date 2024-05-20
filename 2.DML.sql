-- 중복 제거
distinct

-- update
update 테이블 set column = value where ~~

-- insert
insert into 테이블 (column1, column2) values (value1, value2);

-- delete
delete from 테이블 where column=value

-- auto increment 값 초기화
alter table post auto_increment =0;
alter table author auto_increment =0;

-- author 테이블 값 제거 후 넣기
delete from author where id >= 1;
insert into author(name, email) values('kim', 'kim@naver.com');
insert into author(name, email) values('Lee', 'Lee@naver.com');
insert into author(name, email) values('Park', 'Park@naver.com');
insert into author(name, email) values('Choi', 'Choi@naver.com');

-- post 테이블 값 제거 후 넣기
delete from post where id >= 1;
insert into post (title, contents, author_id) values('kim', 'kimkim', 1);
insert into post (title, contents, author_id) values('lee', 'leelee', 2);
insert into post (title, contents, author_id) values('park', 'parkpark', 3);
insert into post (title, contents, author_id) values('choi', 'choichoi', 4);
insert into post (title, contents) values ('bang','bangbang');
