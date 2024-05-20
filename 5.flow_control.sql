-- 흐름 제어 : case 문
select column1, column2, column3
case column4
    when [compare1] then result1
    when [compare2] then result2
    else result3
end
from table3;

-- 실습
-- author_id가 있으면 그대로 출력 else author_id
-- 없으면 '익명사용자'로 출력
select id, title, contents,
	case 
		when author_id is null then '익명사용자'
		else author_id
	end 구분
from post;

-- 위 case문을 ifnull구문으로 변환
select id, title, contents, 
    ifnull(author_id, '익명사용자') author_id
from post;

-- if(a,b,c) a 참 = b , a 거짓 = c
-- if 문으로 변환
select id, title, contents,
	if(author_id is null, '익명사용자', author_id) author_id
from post;

