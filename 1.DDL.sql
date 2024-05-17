-- 데이터 베이스 접속
powershell : mariadb -u root -p -> 1234

-- 데이터 베이스 목록 보기
show databases;

-- 데이터 베이스 생성
create database 이름;

-- 사용할 데이터베이스 선택
use DB명;

-- 데이터 베이스의 테이블 리스트 보기
show tables;

-- table 생성
create table 이름 (칼럼1 속성(int, varchar) primary key, 칼럼2, foreign key 칼럼2 references 테이블(칼럼));

-- table 생성 쿼리 보기
show create table 테이블명

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
)

-- table index 조회
show index from author;
show index from posts;

-- alter 문 : 테이블 구조 변경
-- 테이블 이름 변경
alter table posts rename post;
-- 테이블 컬럼 추가
alter table author add column test1 varchar(30);
-- 테이블 컬럼 삭제
alter table author drop column test1;
-- 테이블 컬럼명 변경
alter table posts change column content contents varchar(255);
-- 테이블 제약 변경
alter table author modify column email email varchar(255) not null;


alter table author add column address varchar(255);
alter table posts modify column title varchar(255) not null;
alter table posts modify column contents varchar(3000);



