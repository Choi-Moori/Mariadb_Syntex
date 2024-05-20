-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

-- auto_increment
alter table author modify column id bigint auto_increment;
alter table author modify column id bigint auto_increment;

-- auto_increment 초기화
-- 
alter table posts auto_increment = 8;

-- author.id에 제약조건 추가시 fk로 인해 문제 발생시.
-- author의 id 를 posts 의 author_id라는 칼럼에서 이미 참조중인 데이터가 존재하기 때문에 문제가 발생한다.
-- fk 먼저 제거 이후에 author.id에 제약조건 추가
select * from information_schema.key_column_usage where table_name = "post";
-- 삭제
alter table post drop foreign key posts_ibfk_1 ;
--삭제된 제약조건 다시 추가
alter table post add constraint posts_author_fk foreign key(author_id) references author(id); 


-- uuid
alter table post add column user_id char(36) default (UUID()); 

-- unique 제약 조건
alter table author modify column email varchar(255) unique;

-- on delete cascade 테스트 -> 부모 테이블의 id 수정? 수정 안된대 (삭제는 가능)
select * from information_schema.key_column_usage where table_name = "post";
alter table post drop foreign key posts_ibfk_1 ;
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;

-- on delete cascade on update cascade 테스트 -> 부모 테이블의 id 수정? 수정 안된대 (삭제는 가능)
select * from information_schema.key_column_usage where table_name = "post";
alter table post drop foreign key posts_ibfk_1 ;
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade on update cascade;

-- (실습) delete는 set null, update cascade : on delete set null on update cascade
select * from information_schema.key_column_usage where table_name = "post";
alter table post drop foreign key posts_ibfk_1 ;
alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete set null on update cascade;

-- 테스트
delete from author where id =  post의 author_id 에서 참조중인 id;
select * from post;
update author set id = % where id = %;
select * from post;

-- 시간 출력시 05 08 -> 5 8 로 출력을 원할 시
-- cast(~~~) as unsigned(int 로 입력시 빨간줄 뜨지만 정상 출력 or signed 사용해도 된다)
-- 일반적으로 unsigned 사용
select cast(date_format(create_time, '%m') as unsigned) 시간 from post;