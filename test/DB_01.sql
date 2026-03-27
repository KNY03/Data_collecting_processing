SELECT  last_name, gender, first_name FROM employees;
-- -> employees 테이블에서 last_name, gender, first_name 열만 조회

select * from employees;
-- -> employees 테이블의 모든 열 조회

show table status;
-- -> 데이터베이스의 테이블 상태 정보 조회

show tables;
-- -> 현재 데이터베이스의 테이블 목록 조회

desc employees;
-- -> employees 테이블의 구조(컬럼명, 자료형 등) 확인

/* 
char(10): 고정길이
-> 항상 10글자 크기로 저장하는 고정길이 문자형

varchar(10): 가변길이
-> 입력한 글자 수만큼 저장하는 가변길이 문자형

Primary key(기본키)
-> 테이블에서 각 행을 유일하게 구분하는 키 (중복 X, NULL X)
-> 개체 무결성 보장
	- 한 테이블에 1개만 존재
	- 여러 컬럼을 묶어서 설정 가능 (복합키)
	- 자동으로 인덱스 생성됨
*/

select * from employees;

-- 조건을 겅어 데이터를 조회하고 싶을 떄 사용
-- WHERE 절을 사용

create database sqldb; -- 생성
drop database sqldb; -- 제거 (단 제거할때 안에 들어있는 테이블도 다 삭제됨)

use sqldb; -- 사용할때

PRIMARYCREATE TABLE usertbl -- 회원 테이블
( userID     CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name       VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr        CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1   CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2   CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height       SMALLINT,  -- 키 (16 bit)
  mDate       DATE  -- 회원 가입일
);

CREATE TABLE buytbl -- 회원 구매 테이블(Buy Table의 약자)
(  num       INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID     CHAR(8) NOT NULL, -- 아이디(FK)
   prodName    CHAR(6) NOT NULL, --  물품명
   groupName    CHAR(4)  , -- 분 ? - 단가
   amount       SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES usertbl(userID)
);
-- AUTO_INCREMENT → 새로운 데이터가 추가될 때 숫자가 자동으로 1씩 증가하는 기능
/*
Primary Key (기본키)
→ 테이블에서 각 행을 유일하게 구분하는 키 (중복 X, NULL X)
→ 개체 무결성 보장
	한 테이블에 1개만 존재
	복합키 가능
	자동으로 인덱스 생성됨

한 줄 요약:
기본키: 각 데이터를 유일하게 식별하는 값
--------------------------------------
Foreign Key (외래키)
→ 다른 테이블의 Primary Key를 참조하는 키
→ 참조 무결성 보장
	중복 가능
	NULL 가능 (설정에 따라 다름)
	두 테이블 간 관계를 연결함

한 줄 요약:
외래키: 다른 테이블의 기본키를 참조하여 관계를 만드는 값
*/

-- --------------------------------

INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');


select * from usertbl;

-- --------------------------------------
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
-- num 컬럼은 자동으로 순서를 맞춰줌 그래서 NULL 사용

select * from buytbl;

-- 특정 조건의 데이터만 조회 - <select ... FROM ... WHERE>
select * FROM usertbl where name = "김경호";
select userID, name FROM usertbl where name = "김경호"; -- 원하는 것만 골라서 사용가능

-- --------------------------
-- 관계 연산자 OR AND
select * from usertbl;
select userID, Name From usertbl where birthYear >= 1970 AND height >= 182;
-- 대소문자 구분하지 않음
select userID, Name, birthYear, height From usertbl where birthYear >= 1970 or height >= 182;
-- ---------------------
-- between and : 데이터가 숫자로 구성이 되어 있으면 연속적인 값
select * where height >= 180 AND height >= 183;
select * From usertbl where height between 180 and 183;

-- 이산적인(Discrete)값의 조건: IN() 사용
select * from usertbl where addr = "경북"  or addr = "경남"  or addr = "전남";
select * from usertbl where addr in ("경북" , "경남", "전남" );

-- 문자열의 내용 검색: LINK 사용(문자뒤에 % - 무엇이든 허용, 한글자와 매치'_' 사용)
select name, height from usertbl where name like '김%';
select name, height from usertbl where name like '_종신';
select name, height from usertbl where name like '윤__';


