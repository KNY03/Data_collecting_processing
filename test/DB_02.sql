-- ANY/ALL/SOME ,서브쿼리(SubQuery, 하위쿼리)
/*
서브쿼리
⁃ 쿼리문 안에 또 쿼리문이 들어 있는 것
⁃ 서브쿼리의 결과가 둘 이상이 되면 에러 발생!!
*/

use sqldb;
select name, height FROM usertbl WHERE height > 177;

--  ex) 김경호보다 키가 크거나 같은 사람의 이름과 키 출력
-- 		• WHERE 조건에 김경호의 키를 직접 써주는 것을 쿼리로 해결
select name, height FROM usertbl
	WHERE height > (select height FROM usertbl WHERE name = "김경호");


-- ---------------------------
/*
 ANY
⁃ 서브쿼리의 여러 개의 결과 중 한 가지만 만족해도 가능
⁃ SOME은 ANY와 동일한 의미로 사용
⁃ ‘= ANY(서브쿼리)’는 ‘IN(서브쿼리)’와 동일한 의미
◦ ALL
⁃ 서브쿼리의 결과 중 여러 개의 결과를 모두 만족해야 함
*/

select name, height FROM usertbl
	WHERE height = any (select height FROM usertbl WHERE name = "김경호");
    
-- 경남에 사는 사람보다 키가 작거나 같은 사람의 이름과 키를 조회
select name, height FROM usertbl
	WHERE height >= (select min(height) FROM usertbl WHERE addr = "경남");

select name, height FROM usertbl
	WHERE height >=  any (select (height) FROM usertbl WHERE addr = "경남");
    
    
-- 경남에 사는 사람보다 키가 크거나 같은 사람의 이름과 키를 조회
select name, height FROM usertbl
	WHERE height >= (select max(height) FROM usertbl WHERE addr = "경남");
    
select name, height FROM usertbl
	WHERE height >= all (select (height) FROM usertbl WHERE addr = "경남");



select name, height FROM usertbl
	WHERE height = any (select height FROM usertbl WHERE addr = "경남");

select name, height FROM usertbl
	WHERE height in (select height FROM usertbl WHERE addr = "경남");


select * from usertbl;
select *  from buytbl;

select userID , name ,addr from usertbl
	where userID in (select userID from buytbl where prodName = "운동화");
    
    
-- ------------------------------------------
-- 정렬
-- 오름차순 : ASC  /  내림차순 : DESC 
-- 오름차순은 생략 가능
select name, mDate FROM usertbl order by mDate;
select name, mDate FROM usertbl order by mDate desc;

-- 키(height)를 기준으로 내림차순 정렬하고, 키가 같으면 이름(name)을 오름차순 정렬
select name, height FROM usertbl ORDER BY height DESC, name ASC;

-- -------------------
/*
중복된 것은 하나만 남기는 DISTINCT
	⁃ 중복된 것을 골라서 세기 어려울 때 사용하는 구문
	⁃ 테이블의 크기가 클수록 효율적
	⁃ 중복된 것은 1개씩만 보여주면서 출력
*/
select addr FROM usertbl order by addr;
select distinct addr from usertbl;

-- 주소와 이름의 중복된 조합을 제거하여 조회하고, 주소 순으로 정렬하는 쿼리
select distinct addr, name from usertbl order by addr;

/*
출력하는 개수를 제한하는 LIMIT
	⁃ 일부를 보기 위해 여러 건의 데이터를 출력하는 부담 줄임
	⁃ 상위의 N개만 출력하는 ‘LIMIT N’ 구문 사용
	⁃ 개수의 문제보다는 MySQL의 부담을 많이 줄여주는 방법
*/
use employees;
select emp_no, hire_date FROM employees
	order by hire_date ASC;

-- 상위 5개만 출력
select emp_no, hire_date FROM employees
	order by hire_date ASC
    limit 5;
    
select emp_no, hire_date FROM employees
	order by hire_date ASC
    limit 0, 5;

-- 입사일 순으로 정렬했을 때 11번째부터 15번째 직원까지 조회하는 쿼리
select emp_no, hire_date FROM employees
	order by hire_date ASC
    limit 10, 5;
    
select emp_no, hire_date FROM employees
	order by hire_date ASC
    limit 5 offset 10;
    
/*
추가로 LIMIT a, b는 이렇게 이해
a = 몇 개 건너뛸지
b = 몇 개 가져올지
*/


    
/*
테이블을 복사하는 CREATE TABLE … SELECT
	⁃ 테이블을 복사해서 사용할 경우 주로 사용
	⁃ CREATE TABLE 새로운 테이블 (SELECT 복사할 열 FROM 기존테이블)
	⁃ 지정한 일부 열만 복사하는 것도 가능
	⁃ PK나 FK 같은 제약 조건은 복사되지 않음
*/
use sqldb;
create table buytbl2(select * From buytbl);
desc buytbl;
desc buytbl2;
    
create table buytbl3 (select userID, prodName From buytbl);
select * From buytbl3;
desc buytbl3;

-- --------------------
/*
GROUP BY절
⁃ 그룹으로 묶어주는 역할
⁃ 집계 함수(Aggregate Function)와 함께 사용
• 효율적인 데이터 그룹화 (Grouping)
• ex) 각 사용자 별로 구매한 개수를 합쳐 출력
*/
select userID, amount FROM buytbl order by userID;
SELECT userID, SUM(amount) FROM buytbl GROUP BY userID;
--  읽기 좋게 하기 위해 별칭(Alias) AS 사용
select userID as '사용자 아이디', sum(amount) as '총 구매 개수'
	FROM buytbl GROUP by userID;
    
select userID as '사용자 아이디', sum(price*amount) as '총 구매액'
	FROM buytbl GROUP by userID;
    
-- 집계함수 
select AVG(amount) as "평균 구매 개수" FROM buytbl;
select userID , AVG(amount) as "평균 구매 개수" FROM buytbl group by userID;

/*
select name, max(height), min(height) FROM usertbl
MAX(height), MIN(height)는 집계 함수입니다.
그런데 name은 집계하지도 않았고 GROUP BY도 없습니다.
따라서 이 쿼리는 DB 설정에 따라 오류가 나거나, 의미가 애매한 결과가 나올 수 있습니다.

핵심적으로,
최댓값/최솟값은 테이블 전체 기준인데 name은 누구의 이름인지 정할 수 없기 때문
*/
select name, max(height), min(height) FROM usertbl group by name;

select name, height 
	from usertbl
    where height = (select MAX(height) from usertbl)
		or height = (select MIN(height) FROM usertbl);
        
select count(*) from usertbl;
select * from usertbl;
select count(mobile1) from usertbl;


-- -------------------
/*
 Having절
	⁃ WHERE와 비슷한 개념으로 조건 제한하는 것이지만, 집계 함수에 대해서 조건을 제한하는 것
	⁃ HAVING절은 꼭 GROUP BY절 다음에 나와야 함(순서 바뀌면 안됨!!!)
*/
select userID AS "사용자" , sum(price * amount) AS '총 구매액'
	From buytbl 
    group by userID;
        
select userID AS "사용자" , sum(price * amount) AS '총 구매액'
	From buytbl 
    group by userID
    having sum(price * amount ) > 1000;
        
select userID AS "사용자" , sum(price * amount) AS '총 구매액'
	From buytbl 
    group by userID
    having sum(price * amount ) > 1000
    order by sum(price * amount ) ;
    

-- -----------------------
/*
 ROLLUP
	⁃ 총합 또는 중간 합계가 필요할 경우 사용
	⁃ GROUP BY절과 함께 WITH ROLLUP문 사용
		• ex) 분류(groupName) 별로 합계 및 그 총합 구하기	
*/

select num , groupName, SUM(price * amount) as "비용"
	from buytbl
    group by groupName, num
    with rollup;
    

select groupName, SUM(price * amount) as "비용"
	from buytbl
    group by groupName
    with rollup;
    
-- --------------------------
-- [SQL의 분류]
/*
 DML (Data Manipulation Language, 데이터 조작 언어)
	⁃ 데이터를 조작(선택, 삽입, 수정, 삭제)하는 데 사용되는 언어
	⁃ DML 구문이 사용되는 대상은 테이블의 행
	⁃ DML 사용하기 위해서는 테이블이 정의되어 있어야 함
	⁃ SQL문 중 SELECT, INSERT, UPDATE, DELETE가 이 구문에 해당
	⁃ 트랜잭션(Transaction)이 발생하는 SQL도 DML에 속함
		• 테이블의 데이터를 변경(입력/수정/삭제)할 때 실제 테이블에 완전히 적용하지 않고, 임시로 적용
		시키는 것
		• 취소 가능
DDL (Data Definition Language, 데이터 정의 언어)
	⁃ 데이터베이스, 테이블, 뷰, 인덱스 등의 데이터베이스 개체를 생성/삭제/변경하는 역할
	⁃ CREATE, DROP, ALTER 자주 사용
	⁃ DDL은 트랜잭션 발생시키지 않음 !!!!!
	⁃ 되돌림(ROLLBACK)이나 완전적용(COMMIT) 사용 불가
	⁃ 실행 즉시 MySQL에 적용
    
DCL (Data Control Language, 데이터 제어 언어)
	⁃ 사용자에게 어떤 권한을 부여하거나 빼앗을 때 주로 사용하는 구문
	⁃ GRANT/REVOKE/DENY 구문
*/

-- --------------------------------
-- [데이터의 삽입 : INSERT]
/*
 테이블 이름 다음에 나오는 열 생략 가능
	• 생략할 경우에 VALUES 다음에 나오는 값들의 순서 및 개수가 테이블이 정의된 열 순서 및 개수와
	동일해야 함

◦ 자동으로 증가하는 AUTO_INCREMENT
	⁃ INSERT에서는 해당 열이 없다고 생각하고 입력
		• INSERT문에서 NULL 값 지정하면 자동으로 값 입력
	⁃ 1부터 증가하는 값 자동 입력
	⁃ 적용할 열이 PRIMARY KEY 또는 UNIQUE일 때만 사용가능
	⁃ 데이터 형은 숫자 형식만 사용 가능

*/

create table testTbl1 (
	id int,
    userName char(3),
    age int
);
insert into testTbl1 ( id, userName, age) values (1, '홍길동', 30);
select * from testtbl1;
insert into testTbl1 values (2, '이기자', 27);

create table testTbl2(
	id int auto_increment primary key,
    userName char(3),
    age int
);

insert into testTbl2 values (NULL, '지민', 25);
insert into testTbl2 values (NULL, '유나', 22);
insert into testTbl2 values (NULL, '유경', 21);

select * From testtbl2;
select last_insert_id();


create table testTbl3(
	id int auto_increment primary key,
    userName char(3),
    age int
);

ALTER Table testtbl3 auto_increment = 1000;
set @@auto_increment_increment = 3;
insert into testTbl3 values (NULL, '나연', 20);
insert into testTbl3 values (NULL, '정현', 18);
insert into testTbl3 values (NULL, '모모', 19);
select * From testtbl3;

-- 대량 데이터 추가
create table testTbl4 (
	id int,
	Fname varchar(50),
    Lname varchar(50)
);

insert into testTbl4
	select emp_no, first_name, last_name
		from employees.employees;
select * from testtbl4;

-- -------------------------------------
-- [데이터의 수정 : UPDATE]
--  기존에 입력되어 있는 값 변경하는 구문
/*
◦ WHERE절 생략 가능하나 WHERE절 생략하면 테이블의 전체 행의 내용 변경됨
	⁃ 실무에서 실수가 종종 일어남, 주의 필요
	⁃ 원상태로 복구하기 복잡하며, 다시 되돌릴 수 없는 경우도 있음
*/
update testTbl4
	set Lname = '없음'
	where Fname = 'Georgi';
select * from testtbl4;

update testTbl4
	set Lname = '없음', Fname = 'Georgi'
	where id = 10002;
select * from testtbl4;

-- --------------------------
-- [데이터의 삭제 : DELETE FROM]
-- 행 단위로 데이터 삭제하는 구문
/*
WHERE절 생략되면 전체 데이터를 삭제함
◦ 테이블을 삭제하는 경우의 속도 비교
	⁃ DML문인 DELETE는 트랜잭션 로그 기록 작업 때문에 삭제 느림
	⁃ DDL문인 DROP과 TRUNCATE문은 트랜잭션 없어 빠름
		• 테이블 자체가 필요 없을 경우에는 DROP 으로 삭제
		• 테이블의 구조는 남겨놓고 싶다면 TRUNCATE로 삭제하는 것이 효율적
*/

delete from testtbl4 where id = 10001;
select * from testtbl4;

drop table testtbl4; -- 복구 불가

select * from testtbl3;
truncate table testtbl3;
	









