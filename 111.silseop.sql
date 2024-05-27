-- - (실습)주문(order) ERD DB 설계 및 구축
--     - 서비스 요구사항
--         - 회원가입
--              - 판매자, 일반사용자 구분 필요
                -- - 회원 탈퇴는 update 로 del_YN 등으로 표시
--         - 상품 등록 및 상품 목록조회
--             - 재고 컬럼은 필수
--         - 주문하기 및 나의 주문 목록조회
--             - 한번에 여러상품을 여러개 주문할수 있는 일반적인 주문서비스 가
--             - ex) 사과 5개, 배 3개를 한 사람이 주문할 경우 -> order 테이블
--         - 그 외
--             - 상품 정보 조회, 주문 상세 조회 
--     - user테이블(사용자), order테이블(주문), product테이블(상품) 등 컬럼, 테이블 설계 추가 자유
--     - 서비스 단계별로 테스트 쿼리 생성 필요
    
use test2;

----------------------------------------------------------------
-- user 등록

alter table tbl_user auto_increment = 0;
delimiter //
create procedure input_user(idInput varchar(30), passwordInput varchar(100), nameInput varchar(20), 
							 ageInput int, genderInput varchar(20), emailInput varchar(50), divisionInput varchar(10),
                             conturyInput varchar(20), cityInput varchar(20))
begin
	declare user_id_information int;
    
	insert into tbl_user(id, password, name, age, gender, email, user_division) values (idInput, passwordInput, nameInput, ageInput, genderInput,emailInput,divisionInput);
    select user_num into user_id_information from tbl_user where id = idInput;
    insert into tbl_user_address(user_id, contury, city) values (user_id_information, conturyInput, cityInput);
end
// delimiter ;

call input_user('aaaa','aaaa','choi',25,'M','aaaa@naver.com', 'B' ,'Korea', 'Seoul');
call input_user('bbbb','bbbb','Lee',35,'M','Lee@naver.com', 'B' ,'U.S.A', 'LA');
call input_user('cccc','cccc','bang',40,'M','bang@naver.com', 'B' ,'U.K', 'London');
call input_user('dddd','dddd','min',55,'M','min@naver.com', 'S' ,'France', 'Paris');
call input_user('eeee','eeee','kim',46,'M','kim@naver.com', 'S' ,'Spain', 'Madrid');
select * from tbl_user;

------------------------------------------------------------
-- 상품등록
delimiter //
create procedure regi_product(pnameInput varchar(50), Sidinput varchar(45), pcountInput int)
begin
	declare usernum int;
    declare divi varchar(10);
    declare seller_address varchar(40);
    
    select user_num into usernum from tbl_user where id = Sidinput;
    select user_division into divi from tbl_user where id = Sidinput;
    select concat(contury, "_" ,city) into seller_address from tbl_user_address where user_id = usernum;
    
    if divi = 'S' then
		insert into tbl_information_product(p_name, s_id, address, p_count) values (pnameInput, Sidinput, seller_address, pcountInput);
	else
		select "판매 등록을 해주세요"; 
	end if;
end
// delimiter ;

select * from tbl_user_address;
call regi_product("사과",'dddd',10);
call regi_product("배",'eeee',20); 
call regi_product("책상",'eeee',5); 
call regi_product("컴퓨터",'dddd',3); 
call regi_product("의자",'eeee',5); 

select * from tbl_information_product;

---------------------------------------------------------------------------------------
-- 주문 등록
-- 만약 tbl_order_usernum 테이블에 입력받은 id가 있다면 tbl_order_detail 에만 추가를 해야 하는데
-- 시간 부족으로 거기까진 구현을 못하였음.

delimiter //
create procedure order_product(useridInput varchar(30), pnameInput varchar(30), ordercountINput int)
begin
	declare buyer_information int;
    declare order_division varchar(10);
    declare orders_num int;
    declare product_count int;
    
    select user_num into buyer_information from tbl_user where id = useridInput;
    select user_division into order_division from tbl_user where id = useridInput;
    select p_count into product_count from tbl_information_product where p_name = pnameInput;
    
    if order_division = 'B' then
		insert into tbl_order_usernum(b_id) values (useridInput);
        select order_num into orders_num from tbl_order_usernum where b_id = useridInput;
        
        if product_count >= pnameInput then
			insert into tbl_order_detail(b_order_num, b_order_id, p_name , order_count) values (orders_num, useridInput, pnameInput,ordercountInput);
            update tbl_information_product set p_count = product_count - pnameInput;
		else
			select '재고가 부족합니다.';
		end if;
	end if;
end
// delimiter ;

call order_product('aaaa','사과', 5);