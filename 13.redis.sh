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

# 캐싱 기능 구현
# 1번 author 회원 정보 조회
# select name, email, age from author where id=1;  
# 위 데이터의 결과값을 redis로 캐싱 : json 데이터 형식으로 저장
set user:1:detail "{\"name\":\"hong\", \"email\":\"hong@naver.com\", \"age\":30}" ex 10

# redis 는 deque 의 자료구조 형태를 가지고 있다. 좋은디?
# redis의 list 는 java의 deque 와 같은 구조 즉, double-ended queue 구조
# RPUSH, LPOP

# 데이터 왼쪽 삽입 : LPUSH
LPUSH key value
# 데이터 오른쪽 삽입
RPUSH key value
# 데이터 왼쪽 POP
LPOP key
# 데이터 오른쪽 POP
RPOP key

lpush hongildongs hong1 
lpush hongildongs hong2
lpush hongildongs hong3
lpop hongildons -> hong3 출력

# 꺼내서 없애는게 아니라, 꺼내서 보기만
lrange hongildongs -1 -1 # 맨 오른쪽
lrange hongildongs 0 0   # 맨 왼쪽

#데이터 개수 조회
llen key
llen hongildongs

# list의 요소 조회시에는 범위 지정
lrange hongildongs 0 -1 # 처음부터 끝까지
# start부터 end 까지 조회
lrange hongildongs start end

# TTL 적용
expire hongildongs 30

# TTL 조회
ttl hongildongs

# pop과 push 동시 - 페이지 앞으로가기 뒤로가기
rpoplpush a리스트 b리스트

# 최근 방문한 페이지
# 5개 정도 데이터 push
# 최근 방문한 페이지 3개 정도만 보여주는 
rpush mypages www.google.com
rpush mypages www.naver.com
rpush mypages www.google.com
rpush mypages www.daum.com
rpush mypages www.naver.com
lrange mypages 2 -1


# 방문페이지를 5개에서 뒤로가기 앞으로 가기 구현
# 뒤로가기 페이지를 누르면 뒤로가기 페이지가 뭔지 출력
# 다시 앞으로가기 누르면 앞으로간 페이지가 뭔지 출력
rpoplpush mypages mypages2
lrange mypages -1 -1
rpush mypages 

# set 자료구조
# set 자료구조에 멤버추가
sadd members member1
sadd members member2
sadd members member3

# set 조회
smembers members

# set에서 멤버 삭제
srem members member2
# set멤버 개수 반환
scard members 
# 특정 멤버가 set 안에 있는지 존재 여부 확인
sismember members member3

# 매일 방문자수 계산
sadd visit:2024-05-27 hong1@naver.com

# zset(sorted set) 
zadd zmembers 3 member1
zadd zmembers 4 member2
zadd zmembers 1 member3
zadd zmembers 2 member4

# score 기준 오름차순 정렬
zrange zmembers 0 -1
# score 기준 내림차순 정렬
zrevrange zmembers 0 -1


# zset 삭제
zrem zmembers member2
# zrank는 해당 멤버가 index 몇번인지 출력
zrank zmembers member2
#zmembers 의 0번을 맨 마지막으로
zadd zmembers 0 -1

# 최근 본 상품목록 => sorted set (zset) 을 활용하는 것이 적절
zadd recent:products 192411 apple
zadd recent:products 192413 apple
zadd recent:products 192415 banana
zadd recent:products 192420 orange
zadd recent:products 192425 apple
zadd recent:products 192430 apple
zrevrange recent:products 0 2

# hashes 
# 해당 자료구조에서는 문자, 숫자가 구분
hset product:1 name "apple" price 1000 stock 50
hset product:1 price 

# 모든 객체값 get
hgetall product:1
# 특정 요소갑 수정
hset product:1 stock 40

# 그정 요소의 값을 증가
hincrby product:1 stock 5
hget product:1 stock

String : key:value => 좋아요, 재고관리
list : key:value, value가 list형식인데, deque => 최근 방문 페이지 관리
set : 중복제거, 순서없음 => 오늘 방문자 수.
zset : set은 set 인데, 순서 있는 set => score : 시간으로 가장 많이 사용 => 최근 본 상품 목록
hset(hashes) => 객체형식으로 values값. 숫자 연산의 편의. hincrby


