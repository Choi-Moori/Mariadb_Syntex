alter table author add column profile_image blob;

-- enum : 삽일될 수 있는 데이터 종류를 한정하는 데이터 타입
-- role 칼럼 추가
alter table author add column role enum('user', 'admin') not null;

-- enum 칼럼 실습
-- user1을 insert -> error
ininsert into author (id, name, email, role) values (7, "fff", "fff@naver.com", "user1");

-- user or admin insert => 정상
insert into author (id, name, email, role) values (7, "fff", "fff@naver.com", "user");


-- date 타입
-- author 테이블에 birth_day 컬럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
alter table author add column birth_day date;
insert into author date = "1998-01-01" where id = 1;


-- datetime 타입
-- author, posts 둘다 datetime으로 create_time 컬럼 추가
alter table author add column create_time datetime default current_timestamp;
alter table posts add column create_time datetime default current_timestamp;

-- 정규표현식
regexp 
select * from author where name regexp '[a-z]';

-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜
-- cast 와 convert
select cast(20200101 as date);
select cast('20200101' as date);
select convert(20200101,date);
select convert('20200101',date);