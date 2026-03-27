USE 한빛무역;

-- 1번
select * from 고객;

-- 2번
select 고객번호, 담당자명, 고객회사명 from 고객;

-- 3번
select 고객번호, 담당자명, 마일리지 From 고객 where 마일리지 >= 100000;

-- 4번
select * From 고객  where 담당자명 like '김%' and 담당자직위 = "영업 사원";

-- 5명
select 고객번호, 고객회사명, 담당자명 from 고객 where 도시 in ("서울특별시" , "인천광역시", "대구광역시" );
