CREATE TABLE subway_congestion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    요일구분 VARCHAR(20),
    호선 VARCHAR(20),
    역번호 INT,
    출발역 VARCHAR(100),
    상하구분 VARCHAR(20),

    `5시30분` DECIMAL(5,1),
    `6시00분` DECIMAL(5,1),
    `6시30분` DECIMAL(5,1),
    `7시00분` DECIMAL(5,1),
    `7시30분` DECIMAL(5,1),
    `8시00분` DECIMAL(5,1),
    `8시30분` DECIMAL(5,1),
    `9시00분` DECIMAL(5,1),
    `9시30분` DECIMAL(5,1),
    `10시00분` DECIMAL(5,1),
    `10시30분` DECIMAL(5,1),
    `11시00분` DECIMAL(5,1),
    `11시30분` DECIMAL(5,1),
    `12시00분` DECIMAL(5,1),
    `12시30분` DECIMAL(5,1),
    `13시00분` DECIMAL(5,1),
    `13시30분` DECIMAL(5,1),
    `14시00분` DECIMAL(5,1),
    `14시30분` DECIMAL(5,1),
    `15시00분` DECIMAL(5,1),
    `15시30분` DECIMAL(5,1),
    `16시00분` DECIMAL(5,1),
    `16시30분` DECIMAL(5,1),
    `17시00분` DECIMAL(5,1),
    `17시30분` DECIMAL(5,1),
    `18시00분` DECIMAL(5,1),
    `18시30분` DECIMAL(5,1),
    `19시00분` DECIMAL(5,1),
    `19시30분` DECIMAL(5,1),
    `20시00분` DECIMAL(5,1),
    `20시30분` DECIMAL(5,1),
    `21시00분` DECIMAL(5,1),
    `21시30분` DECIMAL(5,1),
    `22시00분` DECIMAL(5,1),
    `22시30분` DECIMAL(5,1),
    `23시00분` DECIMAL(5,1),
    `23시30분` DECIMAL(5,1),
    `00시00분` DECIMAL(5,1),
    `00시30분` DECIMAL(5,1),

    기준일자 INT,
    기준연도 INT,
    기준월 INT
);

CREATE TABLE line_info (
    line_id INT AUTO_INCREMENT PRIMARY KEY,
    line_name VARCHAR(20) UNIQUE
);

CREATE TABLE station_info (
    station_id INT AUTO_INCREMENT PRIMARY KEY,
    station_no INT,
    station_name VARCHAR(100),
    line_id INT,
    FOREIGN KEY (line_id) REFERENCES line_info(line_id)
);

CREATE TABLE date_info (
    date_id INT AUTO_INCREMENT PRIMARY KEY,
    base_date INT,
    base_year INT,
    base_month INT,
    day_type VARCHAR(20)
);

CREATE TABLE congestion_fact (
    congestion_id INT AUTO_INCREMENT PRIMARY KEY,
    station_id INT,
    date_id INT,
    direction VARCHAR(20),
    time_slot VARCHAR(20),
    congestion_value DECIMAL(5 , 1 ),
    FOREIGN KEY (station_id)
        REFERENCES station_info (station_id),
    FOREIGN KEY (date_id)
        REFERENCES date_info (date_id)
);

USE subway_db;
SHOW TABLES;
SELECT *FROM congestion_fact;
commit;

USE subwaydb;
DESC congestion_fact;

CREATE DATABASE IF NOT EXISTS subwaydb
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

USE subwaydb;

DROP TABLE IF EXISTS ridership_total_by_hour;

CREATE TABLE ridership_total_by_hour (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year_no INT NOT NULL,
    category VARCHAR(100) NOT NULL,
    time_slot VARCHAR(30) NOT NULL,
    total_passengers BIGINT NOT NULL
);


-- =========================
-- 1. 데이터베이스 생성 및 선택
-- =========================
CREATE DATABASE IF NOT EXISTS subway_ridership_db
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

USE subway_ridership_db;

-- =========================
-- 2. 기존 테이블 삭제
-- =========================
DROP TABLE IF EXISTS ridership_total_by_hour;

-- =========================
-- 3. 테이블 생성
-- =========================
CREATE TABLE ridership_total_by_hour (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year_no INT NOT NULL,
    time_slot VARCHAR(30) NOT NULL,
    total_passengers BIGINT NOT NULL
);

-- =========================
-- 4. 2023년 데이터 삽입
-- =========================
INSERT INTO ridership_total_by_hour (year_no, time_slot, total_passengers) VALUES
(2023, '06시 이전', 21006896),
(2023, '06시-07시', 41441826),
(2023, '07시-08시', 81525015),
(2023, '08시-09시', 116453645),
(2023, '09시-10시', 68178028),
(2023, '10시-11시', 52498999),
(2023, '11시-12시', 54133731),
(2023, '12시-13시', 60321975),
(2023, '13시-14시', 66285703),
(2023, '14시-15시', 71685186),
(2023, '15시-16시', 78614078),
(2023, '16시-17시', 91191874),
(2023, '17시-18시', 111237391),
(2023, '18시-19시', 123188701),
(2023, '19시-20시', 89245170),
(2023, '20시-21시', 71373766),
(2023, '21시-22시', 64512080),
(2023, '22시-23시', 53951617),
(2023, '23시-24시', 23564440),
(2023, '24시 이후', 3765347);

-- =========================
-- 5. 2024년 데이터 삽입
-- =========================
INSERT INTO ridership_total_by_hour (year_no, time_slot, total_passengers) VALUES
(2024, '06시 이전', 21619713),
(2024, '06시-07시', 42475855),
(2024, '07시-08시', 83207579),
(2024, '08시-09시', 118762337),
(2024, '09시-10시', 69475827),
(2024, '10시-11시', 53407620),
(2024, '11시-12시', 54849354),
(2024, '12시-13시', 61089792),
(2024, '13시-14시', 66819995),
(2024, '14시-15시', 71956225),
(2024, '15시-16시', 78822181),
(2024, '16시-17시', 91579972),
(2024, '17시-18시', 111891790),
(2024, '18시-19시', 123888006),
(2024, '19시-20시', 89727927),
(2024, '20시-21시', 71923036),
(2024, '21시-22시', 65226502),
(2024, '22시-23시', 54869928),
(2024, '23시-24시', 23831432),
(2024, '24시 이후', 3861728);

-- =========================
-- 6. 전체 조회
-- =========================
SELECT * 
FROM ridership_total_by_hour
ORDER BY year_no, id;

-- =========================
-- 7. 연도별 시간대 승차 인원 비교
-- =========================
SELECT 
    a.time_slot,
    a.total_passengers AS passengers_2023,
    b.total_passengers AS passengers_2024,
    (b.total_passengers - a.total_passengers) AS diff
FROM ridership_total_by_hour a
JOIN ridership_total_by_hour b
    ON a.time_slot = b.time_slot
WHERE a.year_no = 2023
  AND b.year_no = 2024
ORDER BY a.id;

-- =========================
-- 8. 가장 승차 인원이 많은 시간대 조회
-- =========================
SELECT *
FROM ridership_total_by_hour
ORDER BY total_passengers DESC
LIMIT 10;

-- =========================
-- 9. 연도별 총 승차 인원 합계
-- =========================
SELECT 
    year_no,
    SUM(total_passengers) AS yearly_total_passengers
FROM ridership_total_by_hour
GROUP BY year_no
ORDER BY year_no;