-- dirty read 실습
-- 워크벤치에서 auto_commit해체후 update 실행 -> commit이 안된상태
-- 터미널을 열어서 select 했을때 위 변경사항이 변경 되었는지 확인.

-- if 값이 추가되거나 제거되었따 - phandom_read

-- phantom_read 동시성 이슈 실습
-- 워크벤치에서 시간을 두고 2번의 select가 이뤄지고,
-- 터미널에서 중간에 insert 실행 -> 2번의 select 결과값이 동일한지 확인
start transaction
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;

-- 터미널에서 아래 insert문 실행
insert into author(name, email) values ('Kim', 'Kim@naver.com');


-- lost update 이슈를 해결하긴 위한 공유락(shared lock)
-- workbench 에서 아래 코드 실행
start transaction;
select post_count from author where id = 1 lock in share mode;
do sleep(15);
select post_count from author where id = 1 lock in share mode;
commit;


select post_count from author where id = 1;
update author set post_count = 0 where id = 1;

-- 배타적 잠금(exclusive lock) : select for update
-- select 부터 lock - transaction 끝날때 까지 다른 트랜잭션에서 select 불가
start transaction;
select post_count from author where id = 1 for update;
do sleep(15);
select post_count from author where id = 1 for update;
commit;


select post_count from author where id = 1 for update;
update author set post_count = 0 where id = 1;

