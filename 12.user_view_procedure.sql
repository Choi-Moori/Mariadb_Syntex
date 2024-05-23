-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
-- %는 원격 포함한 anywhere 접속
create user 'test1'@'localhost' identified by '4321'

-- 사용자에게 권한 부여
grant select on board.author to 'test1'@'localhost'

-- 사용자 권한 회수
revoke select on board.author from 'test1'@'localhost';

-- 환경설정을 변경후 확정 안되는 시스템이 존재하여 해주는게 좋다.
flush privileges;

-- 권한 조회
show grants for 'test1'@'localhost';

-- test1으로 로그인 후에
select * from board.author;

-- 사용자 계정 삭제
drop user 'test1'@'localhost';

-- view
-- view 생성
create view author_for_marketing_team as select name, age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- test계정 view select 권한부여
grant select on board.author_for_marketing_team to 'test1'@'localhost';

-- view 변경
create or replace view author_For_marketing_team as 
select name , email, age, role from author;

-- 프로시저 생성
DELIMITER //
create procedure test_procedure()
BEGIN 
    select 'hello world';
END
// DELIMITER;

call test_procedure();

DELIMITER //
create procedure 게시글단건조회(in 저자id int, in 제목 varchar(255))
BEGIN
    select * from post where author_id = 저자id and title = 제목;
end
// DELIMITER;
call 게시글단건조회(4,'hello');

-- 글쓰기 : title, contents, 저자id

delimiter //
create procedure 글쓰기 ( in titleInput varchar(255), in contentsInput varchar(255), in authorId int)
BEGIN
    insert into post(title, contents, author_id) values (titleInput, contentsInput, authorId);
end
// delimiter;
call 글쓰기("abc","cba",2);

-- 글쓰기 : title, contents, email
DELIMITER //
create procefure 글쓰기 (in titleInput varchar(255), in contentsInput varchar(255), in emailInput varchar(255))
BEGIN
    DECLARE authorId int;
    select id into authorId from author where email = emailInput;
    insert into post(title, contents, author_id) values (titleInput, contentsInput, authorId);
end
// DELIMITER
    
------------------------------------------------------------------------------------------------
-- sql에서 문자열 합치는 기능 : concat('hello', 'world')
-- 글 상세조회 : input 값이 postId
-- title, contents, '이름' + '님'
DELIMITER //
create procedure 조회 (in emailInput varchar(255))
BEGIN
    DECLARE authorname varchar(255);
    DECLARE authorId int;
    DECLARE authorEmail varchar(255);

    select email into authorEmail from author where email = emailInput;
    select name into authorname from author where email = authorEmail;
    select id into authorId from author where email = authorEmail;

    select title, contents , concat(authorname, '님') as 작성자 from post where author_id = authorId;
end
// DELIMITER ;

DELIMITER //
create procedure 조회 (in emailInput varchar(255))
BEGIN
    DECLARE authorname varchar(255);
    DECLARE authorId int;

    select name into authorname from author where email = emailInput;
    select id into authorId from author where email = emailInput;

    select title, contents , concat(authorname, '님') as 작성자 from post where author_id = authorId;
end
// DELIMITER ;
------------------------------------------------------------------------------------------------

-- 등급조회
-- 글을 100개 이상 쓴 사용자는 고수입니다. 출력
-- 10개이상 100개 미만이면 중수입니다.
-- 그 외는 초보입니다.
-- input 값 : email값

DELIMITER //
create procedure 등급조회 (in emailInput varchar(255))
begin
    declare count int;
    declare authorId int;

    select id into authorId from author where email = emailInput;
    select count(*) into count from post where author_id = id;

    if count >= 100 then
        select '고수입니다';
    elseif count >= 10 then
        select '중수입니다';
    else
        select '초보입니다';
    end if;
    -- case count
    --     when count >= 100 then select "고수입니다"
    --     when count >= 10 then select "중수입니다"
    --     else select "초보입니다"
    -- end
end // delimiter ;


-- 반복을 통해 post 대량 생산
-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, title은 '안녕하세요'
delimiter //
create procedure 글도배(in count int)
begin
    declare count_times int default 0;
    -- set count_times = 0;
    while count_times < count DO
        insert into post(title) values('안녕하세요');
        set count_times = count_times + 1;
    end while;
end 
// DELIMITER ;

-- 프로시저 생성문 조회
show create procedure 프로시져명;

-- 프로시저 권한 부여
grant excute on board.글도배 to 'test1'@'localhost';