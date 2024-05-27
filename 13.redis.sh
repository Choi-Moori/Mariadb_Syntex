sudo apt-get update
sudo apt-get install redis-server

-- redis 접속
# cli : command line interface
redis-cli

# redis는 0~15번까지의 database 구성
# 데이터베이스 선택
select 번호(0번 디폴트)

# 데이터베이스내 모든 키 조회
keys *

# 일반 String 자료구조
# key 값은 중복되면 안됨
Set key(키값) value(값)
set test_key1 test_value1
set user:email:1 hongildong@naver.com
# set 할때 key 값이 이미 존재하면 덮어쓰기 되는것이 기본
# 맵저장소에서 key값은 유일하게 관리가 되므로
# nx : not exist -> nx 가 안붙으면 덮어쓰기 됨
set user:email:1 hongildon2@naver.com nx
# ex(만료시간-초단위) - ttl(time to live)
set user:email:2 hong2@naver.com ex 20


# get을 통해 value값 얻기
get test_key1

# 특정 key 삭제
del user:email:1
# 현재 DB 모든 key 값 삭제
flushdb

# 좋아요 기능 구현
set likes:posting:1 0
incr likes:posting:1 # 특정 key 값의 value를 1만큼 증가
decr likes:posting:1
get likes:posting:1


# 재고 기능 구현
set product:stock:1 100
decr product:1:stock
get product:1:stock
#bash쉘을 활용하여 재고감소 프로그램 작성