-- [MySQL에서 지원하는 데이터 형식의 종류]
-- ---------------------------------------------

/*
데이터 형식과 형 변환
	◦ 데이터 형식 변환 함수
	⁃ CAST( ), CONVERT( ) 함수를 가장 일반적으로 사용
	⁃ 데이터 형식 중에서 가능한 것은 BINARY, CHAR, DATE, DATETIME, DECIMAL, JSON, SIGNED INTEGER,
		TIME, UNSIGNED INTEGER
*/
select AVG(amount) as '평균 구매 개수' FROM buytbl;
select CAST( AVG(amount) as signed integer) 
	as '평균 구매 개수' FROM buytbl;
select convert( AVG(amount), signed integer) 
	as '평균 구매 개수' FROM buytbl;

-- DATE
SELECT CAST('2020$12$12' as DATe);
SELECT CAST('2020/12/12' as DATe);
SELECT CAST('2020%12%12' as DATe);
SELECT CAST('2020@12$@12' as DATe);


SELECT num,
       CONCAT(CAST(price AS CHAR(10)), ' x ',
              CAST(amount AS CHAR(4)), ' =') AS '단가 X 수량',
       price * amount AS '구매액'
FROM buytbl;

-- ------------------------------------------------
-- [MySQL 내장 함수]
/*
내장 함수
	⁃ 흐름 함수, 문자열 함수, 수학 함수, 날짜/시간 함수, 전체 텍스트 검색 함수, 형 변환 함수, XML 함수,
		비트 함수, 보안/압축 함 수, 정보 함수, 공간 분석 함수, 기타 함수 등
◦ 제어 흐름 함수
	⁃ 프로그램의 흐름 제어
	⁃ IF (수식, 참, 거짓)
		• 수식이 참 또는 거짓인지 결과에 따라서 2중 분
	⁃ IFNULL(수식1, 수식2)
		• 수식1이 NULL이 아니면 수식1이 반환되고 수식1이 NULL이면 수식2가 반환
*/

select if (100 > 200, '참이다', '거짓이다');
select ifnull(null, '널이다'), ifnull(100, '널이다');
select nullif(100,100), ifnull(200,100);


/*
⁃ CASE ~ WHEN ~ ELSE ~ END
	• CASE는 내장 함수는 아니며 연산자(Operator)로 분류
	• CASE 뒤의 값이 10이므로 세 번째 WHEN이 수행되어 ‘십’ 반환
	• 만약, 해당하는 사항이 없다면 ELSE 부분이 반환
*/
select case 100
		when 1 then '일'
		when 5 then '오'
		when 10 then '십'
		else '모름'
    end as 'case연습';

select ASCII('A'), char(65);

select bit_length('abc'), char_length('abc'), LENGTH('abc');
select bit_length('가나다'), char_length('가나다'), LENGTH('가나다');


select concat_ws('/','2025','01','01');

select elt(2, '하나', '둘', '셋'), field('둘', '하나', '둘' ,'셋'),
   find_in_set('둘', '하나,둘,셋'), instr('하나둘셋', '둘'), locate('둘', '하나둘셋');

SELECT LEFT('abcdefghi', 3), RIGHT('abcdefghi', 3);
SELECT LOWER('abcdEFGH'), UPPER('abcdEFGH');
SELECT LPAD('이것이', 5, '##'), RPAD('이것이', 5, '##');
SELECT LTRIM('    이것이'), RTRIM('이것이    ');
SELECT TRIM('    이것이    '), TRIM(BOTH '=' FROM '===ㅋㅋ재밌어요.ㅋㅋㅋ');

select substring('대한민국만세', 3,3);
select substring_index('cafe.naver.com', '.', 1),
	substring_index('cafe.naver.com', '.', -1);

select ceiling(4.7), floor(4.7), round(4.7);
select ceiling(-4.7), floor(-4.7), round(-4.7);

SELECT ADDDATE('2025-01-01', INTERVAL 31 DAY), ADDDATE('2025-01-01', INTERVAL 1 MONTH);
SELECT SUBDATE('2025-01-01', INTERVAL 31 DAY), SUBDATE('2025-01-01', INTERVAL 1 MONTH);
SELECT ADDTIME('2025-01-01 23:59:59', '1:1:1'), ADDTIME('15:00:00', '2:10:10');
SELECT SUBTIME('2025-01-01 23:59:59', '1:1:1'), SUBTIME('15:00:00', '2:10:10');
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE());
SELECT HOUR(CURTIME()), MINUTE(CURRENT_TIME()), SECOND(CURRENT_TIME()),
       MICROSECOND(CURRENT_TIME);

select now(), date(now()), time(now());


-- ----------------------------
-- 매우 중요!!
-- [조인(Join)]
/*
◦ 조인
	⁃ 두 개 이상의 테이블을 서로 묶어서 하나의 결과 집합으로 만들어 내는 것
	⁃ 종류 : INNER JOIN, OUTER JOIN, CROSS JOIN, SELF JOIN
◦ 데이터베이스의 테이블
	⁃ 중복과 공간 낭비를 피하고 데이터의 무결성을 위해서 여러 개의 테이블로 분리하여 저장
	⁃ 분리된 테이블들은 서로 관계(Relation)를 가짐
	⁃ 1대 다 관계 보편적
*/
/*
INNER JOIN(내부 조인)
◦ 조인 중에서 가장 많이 사용되는 조인
	⁃ 대개의 업무에서 조인은 INNER JOIN 사용
	⁃ 일반적으로 JOIN이라고 얘기하는 것이 이 INNER JOIN 지칭
*/

USE sqldb;
SELECT *
    FROM buytbl
        INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID
WHERE buytbl.userID = 'KBS';

SELECT *
    FROM buytbl
        INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID
	ORDER BY num;

-- 오류가 난다
-- 어느 userID인지 모르기 때문에
-- 어느 테이블의 필드인지 알아야 함 
SELECT userID, name, prodName, addr, mobile1 + mobile2 AS '연락처'
    FROM buytbl
        INNER JOIN usertbl
        ON buytbl.userID = usertbl.userID
	ORDER BY num;
-- 이렇게 식별 되도록 해줘야함
SELECT b.userID, name, prodName, addr, mobile1 + mobile2 AS '연락처'
    FROM buytbl as b -- 별칭으로 더 쉽게 코드를 적을 수 있음
        INNER JOIN usertbl  as u
        ON b.userID = u.userID
	ORDER BY num;

SELECT B.userID, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2 AS '연락처'
	FROM buytbl B 
		INNER JOIN usertbl U
			ON B.userID = U.userID
	ORDER BY B.num;

-- 테이블 3개 라면??
CREATE TABLE stdtbl 
( stdName    VARCHAR(10) NOT NULL PRIMARY KEY,
  addr     CHAR(4) NOT NULL
);
CREATE TABLE clubtbl 
( clubName    VARCHAR(10) NOT NULL PRIMARY KEY,
  roomNo    CHAR(4) NOT NULL
);
CREATE TABLE stdclubtbl
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   stdName    VARCHAR(10) NOT NULL,
   clubName    VARCHAR(10) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
FOREIGN KEY(clubName) REFERENCES clubtbl(clubName)
);
INSERT INTO stdtbl VALUES ('김범수','경남'), ('성시경','서울'), ('조용필','경기'), ('은지원','경북'),('바비킴','서울');
INSERT INTO clubtbl VALUES ('수영','101호'), ('바둑','102호'), ('축구','103호'), ('봉사','104호');
INSERT INTO stdclubtbl VALUES (NULL, '김범수','바둑'), (NULL,'김범수','축구'), (NULL,'조용필','축구'), (NULL,'은지원','축구'), (NULL,'은지원','봉사'), (NULL,'바비킴','봉사');
select * from stdtbl;
select * from clubtbl;
select * from stdclubtbl;

SELECT S.stdName, S.addr, SC.clubName, C.roomNo
    FROM stdtbl S
        INNER JOIN stdclubtbl SC
            ON S.stdName = SC.stdName
        INNER JOIN clubtbl C
            ON SC.clubName = C.clubName
    ORDER BY S.stdName;


-- --------------------------
-- [OUTER JOIN(외부 조인)]
-- ◦ 조인의 조건에 만족되지 않는 행까지도 포함시키는 것
/*
 LEFT OUTER JOIN
	⁃ 왼쪽 테이블의 것은 모두 출력되어야 한다로 이해
	⁃ 줄여서 LEFT JOIN으로 쓸수있음
◦ RIGHT OUTER JOIN
	⁃ 오른쪽 테이블의 것은 모두 출력되어야 한다로 이해
*/
-- OUTER JOIN(외부 조인) : LEFT OUTER JOIN
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
    FROM usertbl U
        LEFT OUTER JOIN buytbl B
            ON U.userID = B.userID
ORDER BY U.userID;

-- OUTER JOIN(외부 조인) : RIGHT OUTER JOIN
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
    FROM usertbl U
        RIGHT OUTER JOIN buytbl B
            ON U.userID = B.userID
ORDER BY U.userID;

-- --------------------------
-- [CROSS JOIN(상호 조인)]
-- ◦ 한쪽 테이블의 모든 행들과 다른 쪽 테이블의 모든 행을 조인시키는 기능
-- ◦ CROSS JOIN의 결과 개수 = 두 테이블 개수를 곱한 개수
/*
CROSS JOIN(상호 조인)
	◦ 테스트로 사용할 많은 용량의 데이터를 생성할 때 주로 사용
	◦ ON 구문을 사용할 수 없음
	◦ 대량의 데이터를 생성하면 시스템이 다운되거나 디스크 용량이 모두 찰 수 있어 COUNT(*) 함수로 개수만 카운트
*/
select count(*) from usertbl;
select count(*) from buytbl;

-- --------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!
-- [SELF JOIN(자체 조인)]
-- 자기 자신과 자기 자신이 조인한다는 의미

CREATE TABLE empTbl (emp CHAR(3), manager CHAR(3), empTel VARCHAR(8));

INSERT INTO empTbl VALUES('나사장',NULL,'0000');
INSERT INTO empTbl VALUES('김재무','나사장','2222');
INSERT INTO empTbl VALUES('김부장','김재무','2222-1');
INSERT INTO empTbl VALUES('이부장','김재무','2222-2');
INSERT INTO empTbl VALUES('우대리','이부장','2222-2-1');
INSERT INTO empTbl VALUES('지사원','이부장','2222-2-2');
INSERT INTO empTbl VALUES('이영업','나사장','1111');
INSERT INTO empTbl VALUES('한과장','이영업','1111-1');
INSERT INTO empTbl VALUES('최정보','나사장','3333');
INSERT INTO empTbl VALUES('윤차장','최정보','3333-1');
INSERT INTO empTbl VALUES('이주임','윤차장','3333-1-1');

SELECT * FROM emptbl;
-- 우대리의 직속 상관의 이름과 연락처를 조회하시오.
SELECT A.emp AS '부하직원', B.emp AS '직속상관', B.empTel AS '직속상관연락처'
	FROM empTbl A
		INNER JOIN empTbl B
			ON A.manager = B.emp
	WHERE A.emp = '우대리';
    
-- -------------------------------------
/*
UNION / UNION ALL / NOT IN / IN
◦ 두 쿼리의 결과를 행으로 합치는 것
*/
-- --- 1
select stdName, addr FROM stdtbl
	UNION ALL
SELECT clubNAME, roomNo FROM clubtbl;

	
SELECT clubNAME, roomNo FROM clubtbl
	UNION ALL
select stdName, addr FROM stdtbl;

-- --- 2
SELECT name, CONCAT(mobile1, mobile2) AS '전화번호' FROM usertbl
	WHERE name NOT IN (SELECT name FROM usertbl WHERE mobile1 IS NULL);

SELECT name, CONCAT(mobile1, mobile2) AS '전화번호' FROM usertbl
	WHERE name IN (SELECT name FROM usertbl WHERE mobile1 IS NULL);
    