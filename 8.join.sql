-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기.
select * from author inner join post on author.id = post.author_id;
-- 별칭 설정
select * from author a inner join post p on a.id = p.author_id;

-- 글쓴이가 존재하는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id,p.title, p.contents, a.email from post p inner join author a on p.author_id = a.id;

-- 모든 글 목록을 출력하고, 만약 글쓴이가 있다면 이메일을 출력
select p.id, p.title, p.contents, a.email from post p left join author a on p.author_id = a.id;
select p.*, a.email from post p left join author a on p.author_id = a.id;

-- join 된 상황에서의 where 조건 : on 뒤에 where 조건이 나옴
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 저자의 나이는 25세이상인 글만,
-- 2) 글쓴이가 있는 글의 title과 저자가 있다면 email을 출력, 2024-05-01 이후에 만들어진 글만 출력.
-- on 은 join 전에 필터링을 한다. where 는 join 후에 필터링을 한다.
select title, email from post p inner join author a on p.author_id = a.id where a.age >= 25;

select title, ifnull(email, '익명사용자') 
from post p left join author a 
on p.author_id = a.id 
where a.create_time like "2024-05%";

select title, ifnull(email, '익명사용자') 
from post p left join author a 
on p.author_id = a.id 
where p.title is not null and a.create_time >= "2024-05-01";

-- 만약 not null 조건이 걸려 있으면 inner join 이나 left, right outer join 이나 결과가 같다.

-- union : 중복 제외한 두 테이블의 select을 결합
-- 컬럼의 개수와 타입이 같아야 함에 유의
-- union all : 중복 포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;
-- author 테이블의 name, email 그리고 post 테이블의 title, contents union
select name, email from author union select title, contents from post;

-- 서브쿼리 : select문 안에 또 다른 select 문을 서브쿼리라 한다.

-- select절 안에 서브쿼리
-- author email과 해당 author 가 쓴 글의 개수를 출력
select email, (select count(*) from post where post.author_id = author.id) from author 

-- from절 안에 서브쿼리
select a.name from (select * from author) a; 

-- where절 안에 서브쿼리
select a.* from author a inner join post p on a.id = p.author_id;
select * from author where id in (select author_id from post);

-- 집계함수 (round : 반올림 ex)round(avg(칼럼), 반올림 자릿수) )
COUNT(*)
SUM(price)
avg(price)
min(price)
max(price)

-- group by와 집계함수
select author_id, count(*), sum(price), min(price), max(price), round(avg(price), 0) 
from post group by author_id;

-- 저자 email, 해당저자가 작성한 글 수를 출력
-- inner join 가능할까? -- 안될듯 ,
select author.id, if(post.id is null, 0 , count(*)) 
from author left join post on author.id = post.author_id 
group by author.id;

-- group by와 where
-- 연도별 post 글 출력, 연도가 null인 것은 제외
select date_format(create_time, '%Y'), count(*) 
from post 
where create_time is not null
group by date_format(create_time, '%Y');



-- HAVING : group by를 통해 나온 통계에 대한 조건.
select author_id, count(*) as cnt from post 
group by author_id having cnt >= 2; 

-- (실습) 포스팅 price 가 3000원 이상인 글을 
-- 작성자별로 몇건인지와 평균 price를 구하되, 
-- 평균 price가 3000원 이상인 데이터를 대상으로 통계 출력
select author_id, count(author_id), round(avg(price), 1) as average
from post where price >= 2000 group by author_id having average >= 3000;

-- (실습)2건 이상의 글을 쓴 사람의 id 와 email 구할건데,
-- 나이는 25세 이상인 사람만 통계에 사용하고,
-- 가장 나이 많은 사람 1명의 통계만 출력
select a.id, count(a.id) as count, a.age ,a.email 
from author a inner join post p on a.id = p.author_id
where a.age >= 25
group by a.id having count >= 2 
order by age desc limit 1;

SELECT id, email, count
FROM (
    SELECT a.id, a.age, a.email, COUNT(a.id) as count
    FROM author a INNER JOIN post p ON a.id = p.author_id
    WHERE a.age >= 25
    GROUP BY a.id HAVING count >= 2
) cnt
ORDER BY cnt.age desc limit 1;

-- 다중열 group by
select author_id, title, count(*) from post group by author_id, title;

-- 재구매가 일어난 상품과 회원 리스트 구하기
