# local에서 sql 덤프 파일 생성
mysqldump -u root -p board > dumpfile.sql

# 한글 깨질때 -> linux 환경에서 ACSII~~~ 오류 뜰 때
mysqldump -u root -p board -r dumpfile.sql

# dump 파일을 github에 업로드
git add .
git commit -m "Aasdf"
git push origin main

# mariadb 서버 설치
sudo apt-get install mariadb-server

# mariadb 서버 시작
sudo systemctl start mariadb

# mariadb 접속 테스트
sudo mariadb -u root -p

# git 설치
sudo apt install git

# git을 통해 repo clone
git clone 레포지토리 주소

# dump파일 복원 == 적용
sudo mysql -u root -p board <덤프명.sql