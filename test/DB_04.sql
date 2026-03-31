-- =========================================================
-- 1. usertbl 생성 : 회원 정보를 저장하는 테이블
-- =========================================================
CREATE TABLE usertbl -- 회원 테이블
(
  userID    CHAR(8) PRIMARY KEY,     -- 사용자 아이디, 기본키(PRIMARY KEY)
  name      VARCHAR(10) NOT NULL,    -- 이름, 반드시 값이 있어야 함
  birthYear INT,                     -- 출생년도
  addr      CHAR(2),                 -- 지역(경기, 서울, 경남 등 2글자 저장)
  mobile1   CHAR(3),                 -- 휴대폰 앞번호(011, 016, 017, 018, 019, 010 등)
  mobile2   CHAR(8),                 -- 휴대폰 나머지 번호(하이픈 제외)
  height    SMALLINT,                -- 키
  mDate     DATE                     -- 회원 가입일
);

-- =========================================================
-- 2. usertbl 데이터 입력 : 회원 샘플 데이터 저장
-- =========================================================
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12'); -- 휴대폰 번호 없음
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');   -- 휴대폰 번호 없음
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');

-- usertbl에 저장된 전체 데이터 조회
SELECT * FROM usertbl;

-- =========================================================
-- 3. buytbl 생성 : 회원의 구매 정보 저장 테이블
-- =========================================================
create table buytbl
(
    num INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 구매번호, 자동 증가, 기본키
    userid CHAR(8) NOT NULL,                     -- 구매한 회원의 아이디
    prodName CHAR(6) NOT NULL,                   -- 상품명
    groupName CHAR(4) NULL,                      -- 상품 분류(전자, 의류, 서적 등), NULL 허용
    price INT NOT NULL,                          -- 가격
    amount SMALLINT NOT NULL,                    -- 수량
    FOREIGN KEY(userid) REFERENCES usertbl(userID) -- 외래키 : buytbl.userid는 usertbl.userID를 참조
);

-- =========================================================
-- 4. buytbl 데이터 입력 : 구매 내역 샘플 데이터 저장
-- =========================================================
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);       -- num은 AUTO_INCREMENT이므로 NULL 입력
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

-- usertbl 전체 조회
SELECT * FROM usertbl;

-- buytbl 전체 조회
SELECT * FROM buytbl;


-- =========================================================
-- 5. prodTbl 생성 : 복합 기본키 실습용 테이블
-- =========================================================

-- prodTbl이 이미 존재하면 삭제
DROP TABLE IF EXISTS prodTbl;

-- 기본키 없이 먼저 테이블 생성
CREATE TABLE prodTbl
(
   prodCode CHAR(3) NOT NULL,   -- 상품 코드
   prodID   CHAR(4) NOT NULL,   -- 상품 ID
   prodDate DATETIME NOT NULL,  -- 등록 일시
   prodCur  CHAR(10) NULL       -- 상태 또는 분류값 저장용 컬럼
);

-- ALTER TABLE을 이용해 복합 기본키 추가
-- prodCode와 prodID를 묶어서 하나의 기본키로 사용
ALTER TABLE prodTbl
    ADD CONSTRAINT PK_prodTbl_prodCode_prodID
    PRIMARY KEY (prodCode, prodID);

-- prodTbl의 인덱스 정보 확인
-- 기본키를 만들면 자동으로 인덱스도 생성됨
SHOW INDEX FROM prodTbl;


-- =========================================================
-- 6. 제약조건 삭제 실습
-- =========================================================

-- buytbl에 설정되어 있던 외래키 삭제
-- buytbl_ibfk_1은 외래키 제약조건 이름
ALTER TABLE buytbl
    DROP FOREIGN KEY buytbl_ibfk_1;

-- buytbl의 기본키 삭제
ALTER TABLE buytbl
    DROP PRIMARY KEY;

-- usertbl의 기본키 삭제
ALTER TABLE usertbl
    DROP PRIMARY KEY;
    
-- prodTbl의 구조 확인
DESC prodTbl;

-- 현재 tabledb 스키마에 존재하는 제약조건 이름과 종류 확인
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'tabledb';


-- =========================================================
-- 7. CHECK 제약 조건
-- =========================================================

-- 기존 usertbl 삭제
-- 위에서 사용한 usertbl과는 다른 실습용 재생성 과정
DROP TABLE IF EXISTS usertbl;

-- CHECK 제약조건을 포함한 usertbl 생성
CREATE TABLE usertbl
(
  userID    CHAR(8) PRIMARY KEY,                                 -- 사용자 아이디, 기본키
  name      VARCHAR(10),                                         -- 이름
  birthYear INT CHECK (birthYear >= 1900 AND birthYear <= 2023),-- 출생년도는 1900~2023만 허용
  mobile1   CHAR(3) NULL,                                        -- 휴대폰 앞번호, NULL 허용
  CONSTRAINT CK_name CHECK (name IS NOT NULL)                    -- 이름은 반드시 입력되어야 함
);

-- CK_name이라는 CHECK 제약조건 삭제
ALTER TABLE usertbl
    DROP CONSTRAINT CK_name;
    
-- usertbl에 설정된 제약조건만 조회
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'tabledb' AND TABLE_NAME = "usertbl";


-- =========================================================
-- 8. DEFAULT 정의
-- =========================================================
DROP TABLE IF EXISTS userTBL;
CREATE TABLE userTBL
( userID    CHAR(8) NOT NULL PRIMARY KEY,
  name      VARCHAR(10) NOT NULL,
  birthYear INT NOT NULL DEFAULT -1,
  addr      CHAR(2) NOT NULL DEFAULT '서울',
  mobile1   CHAR(3) NULL,
  mobile2   CHAR(8) NULL,
  height    SMALLINT NULL DEFAULT 170,
  mDate     DATE NULL
);
DESC usertbl;

-- usertbl 테이블의 mobile1 컬럼 기본값을 '010'으로 설정
-- 값을 입력하지 않으면 자동으로 '010'이 들어가도록 지정
ALTER TABLE usertbl
	ALTER COLUMN mobile1 SET DEFAULT '010';
    
-- usertbl 테이블의 height 컬럼 이름을 HE로 변경하고,
-- 데이터 형식도 INT로 변경
-- 기존에 NOT NULL이나 DEFAULT가 있었다면 필요하면 같이 다시 적어줘야 함.
ALTER TABLE usertbl
	CHANGE COLUMN height HE INT;
    
-- usertbl 테이블의 HE 컬럼 자료형을 SMALLINT로 변경
-- 컬럼 이름은 그대로 두고, 데이터 형식만 수정
/*
MODIFY
→ 컬럼명을 바꾸지 않고 자료형이나 속성만 수정할 때 사용
*/
ALTER TABLE usertbl
	MODIFY HE SMALLINT;
    
    
-- =========================================================
-- 9. ALTER TABLE문 사용
-- =========================================================
-- 사용할 데이터베이스를 tabledb로 선택
USE tabledb;

-- usertbl 테이블에 homepage 컬럼을 새로 추가
ALTER TABLE usertbl
    ADD homepage VARCHAR(30)      -- 열 추가, 최대 30글자 문자열
        DEFAULT 'http://www.hanbit.co.kr' -- 값을 입력하지 않으면 기본값으로 이 주소 저장
        NULL;                     -- NULL 값도 허용
        
ALTER TABLE usertbl
    ADD homepage VARCHAR(30) DEFAULT 'http://www.hanbit.co.kr' AFTER he;
    
-- usertbl 테이블에서 name 컬럼명을 uName으로 변경하고,
-- 데이터 형식을 VARCHAR(20)으로 수정하며 NULL도 허용
ALTER TABLE usertbl
    CHANGE COLUMN name uName VARCHAR(20) NULL;

-- 변경된 usertbl 테이블 구조 확인
DESC usertbl;

-- usertbl 테이블에서 homepage 컬럼 삭제
ALTER TABLE usertbl
    DROP COLUMN homepage;

-- 변경 후 usertbl 테이블 구조 확인
DESC usertbl;

-- -------------------------------------
-- =========================================================
-- 10. 뷰(VIEW)의 개념
--    ※ 이 코드는 뷰를 만들기 전, 기본 테이블(usertbl, buytbl)과
--      기본키/외래키 관계를 준비하는 과정입니다.
-- =========================================================

-- ---------------------------------------------------------
-- 1. 기존 usertbl이 있으면 삭제
-- ---------------------------------------------------------
DROP TABLE IF EXISTS usertbl;

-- ---------------------------------------------------------
-- 2. 회원 정보를 저장할 usertbl 생성
-- ---------------------------------------------------------
CREATE TABLE usertbl 
( userID    CHAR(8),      -- 사용자 아이디
  name      VARCHAR(10),  -- 이름
  birthYear INT,          -- 출생년도
  addr      CHAR(2),      -- 지역
  mobile1   CHAR(3),      -- 휴대폰 앞자리
  mobile2   CHAR(8),      -- 휴대폰 뒷자리
  height    SMALLINT,     -- 키
  mDate     DATE          -- 가입일
);

-- ---------------------------------------------------------
-- 3. usertbl에 회원 데이터 삽입
-- ---------------------------------------------------------
INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', NULL, '경남', '011', '2222222', 173, '2012-4-4'); -- birthYear가 NULL
INSERT INTO usertbl VALUES('KKH', '김경호', 1871, '전남', '019', '3333333', 177, '2007-7-7'); -- 비정상 출생년도 예시
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');

-- 회원 테이블 전체 조회
SELECT * FROM usertbl;

-- ---------------------------------------------------------
-- 4. 기존 buytbl이 있으면 삭제
-- ---------------------------------------------------------
DROP TABLE IF EXISTS buytbl;

-- ---------------------------------------------------------
-- 5. 구매 정보를 저장할 buytbl 생성
-- ---------------------------------------------------------
CREATE TABLE buytbl 
(  num       INT AUTO_INCREMENT PRIMARY KEY, -- 구매번호, 자동 증가, 기본키
   userid    CHAR(8),                        -- 구매한 회원의 아이디
   prodName  CHAR(6),                        -- 상품명
   groupName CHAR(4),                        -- 상품 분류
   price     INT,                            -- 가격
   amount    SMALLINT                        -- 수량
);

-- ---------------------------------------------------------
-- 6. buytbl에 구매 데이터 삽입
-- ---------------------------------------------------------
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5); -- usertbl에 없는 아이디 BBK

DELETE FROM buytbl WHERE userid = 'BBK';

-- 구매 테이블 전체 조회
SELECT * FROM buytbl;

-- ---------------------------------------------------------
-- 7. usertbl의 userID 컬럼에 기본키 추가
--    → 각 회원을 중복 없이 구분하기 위한 제약조건
-- ---------------------------------------------------------
ALTER TABLE usertbl
    ADD CONSTRAINT PK_usertbl_userID 
    PRIMARY KEY (userID);
    
-- ---------------------------------------------------------
-- 8. buytbl의 userID를 usertbl의 userID와 연결하는 외래키 추가
--    → buytbl에 입력되는 userID는 usertbl에 실제 존재해야 함
-- ---------------------------------------------------------
ALTER TABLE buytbl
    ADD CONSTRAINT FK_usertbl_buytbl 
    FOREIGN KEY (userID) 
    REFERENCES usertbl(userID);
    
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'tabledb'
  AND TABLE_NAME = 'buytbl';
  
  -- ---------------------------------------
-- v_usertbl 이라는 뷰(View) 생성
-- usertbl 테이블에서 userid, name, addr 컬럼만 선택하여 가상의 테이블처럼 사용할 수 있도록 정의
-- usertbl 테이블에서 userid, name, addr만 보여주는 뷰 생성
CREATE VIEW v_usertbl
AS
    SELECT userid, name, addr FROM usertbl;

-- information_schema.TABLES에서 VIEW만 조회
-- tabledb 데이터베이스에 있는 뷰의 스키마명, 뷰 이름, 타입 확인
SELECT table_schema, table_name, table_type
FROM information_schema.TABLES
WHERE table_type LIKE 'VIEW'
  AND table_schema = 'tabledb';
  

-- 생성한 뷰 조회
-- 뷰는 실제 데이터를 저장하지 않지만, 테이블처럼 SELECT 가능
SELECT * FROM v_usertbl;  -- 뷰를 테이블처럼 사용 가능
SELECT userid, name FROM v_usertbl; 


/*
뷰의 장점
	◦ 보안에 도움
		⁃ 사용자가 중요한 정보에 바로 접근하지 못함
	◦ 복잡한 쿼리 단순화
		⁃ 긴 쿼리를 뷰로 작성, 뷰를 테이블처럼 사용 가능
*/
CREATE VIEW v_userbuytbl
AS
    SELECT 
        U.userid, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
    FROM usertbl U INNER JOIN buytbl B 
    ON U.userid = B.userid;
    
SELECT * FROM v_userbuytbl; 
SELECT userid, name, probName FROM v_userbuytbl; 
    
SHOW FULL TABLES IN tabledb WHERE table_type LIKE "VIEW";

SHOW CREATE VIEW v_userbuytbl; 