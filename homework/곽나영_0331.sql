-- ---- 조인 ----
-- 1. ‘이소미’ 사원의 사원번호, 직위, 부서번호, 부서명을 보이시오.
SELECT 사원번호, 직위, 부서명, B.부서번호 FROM 사원 C
	INNER JOIN 부서 B ON B.부서번호 = C.부서번호
    WHERE C.이름 = '이소미';

-- 2. 고객 회사들이 주문한 주문건수를 주문건수가 많은 순서대로 보이시오. 이때 고객 회사의 정보로는 고객번호, 담당자명, 고객회사명을 보이시오.
SELECT 
    C.고객번호, C.담당자명, C.고객회사명, COUNT(O.주문번호) AS 주문건수
	FROM 고객 C
	INNER JOIN 주문 O
		ON C.고객번호 = O.고객번호
	GROUP BY O.고객번호
	ORDER BY 주문건수 DESC;

-- 3. 고객별(고객번호, 담당자명, 고객회사명)로 주문금액 합을 보이되, 주문금액 합이 많은 순서대로 보이시오.
SELECT C.고객번호, C.담당자명, C.고객회사명, SUM(OD.주문수량 * OD.단가 * (1-OD.할인율)) AS 총주문금액
	FROM 고객 C
	INNER JOIN 주문 O
		ON C.고객번호 = O.고객번호
	INNER JOIN 주문세부 OD
		ON O.주문번호 = OD.주문번호
	GROUP BY C.고객번호, C.담당자명, C.고객회사명
	ORDER BY 총주문금액 DESC;
		
-- 4. 고객 테이블에서 담당자가 ‘이은광’인 경우의 고객번호, 고객회사명, 담당자명, 마일리지와 마일리지등급을 보이시오.
SELECT C.고객번호, C.고객회사명, C.담당자명, C.마일리지, M.등급명
FROM 고객 C
INNER JOIN 마일리지등급 M
    ON C.마일리지 BETWEEN M.하한마일리지 AND M.상한마일리지
WHERE C.담당자명 = '이은광';
