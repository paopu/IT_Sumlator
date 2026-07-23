CREATE DATABASE IT_SIMULATOR_DB;
USE DATABASE IT_SIMULATOR_DB;
USE SCHEMA PUBLIC;

-- Create the Player/Trainee Dimension Table
CREATE TABLE PLAYER_DIM (
player_id VARCHAR PRIMARY KEY,
signup_date DATE,
cohort VARCHAR,
account_tier VARCHAR
);

-- Create the Telemetry Game Logs Table
CREATE TABLE GAME_LOGS (
log_id VARCHAR PRIMARY KEY,
player_id VARCHAR,
timestamp TIMESTAMP_NTZ,
level_reached INT,
completion_velocity_sec INT,
errors_encountered INT,
status VARCHAR
);

-- 2. Which account tiers and cohorts are hitting the highest number of errors?
SELECT p.account_tier,
    p.cohort,
    SUM(g.errors_encountered) AS total_errors_logged,
    ROUND(AVG(g.completion_velocity_sec), 2) AS avg_velocity_seconds,
    COUNT(DISTINCT g.player_id) AS active_players_in_tier
FROM GAME_LOGS g 
INNER JOIN player_dim p 
    ON g.player_id = p.player_id
GROUP BY p.account_tier, p.cohort
ORDER BY total_errors_logged DESC;

-- 3. What is our overall pipeline failure rate by status code?
SELECT status,
    COUNT(log_id) AS total_occurrences,
    ROUND(COUNT(log_id) * 100.0 / SUM(COUNT(log_id)) OVER(), 2) AS percentage_of_total
FROM GAME_LOGS
GROUP BY status
ORDER BY total_occurrences DESC;

-- 4. What are the top 5 most unstable failed runs per player based on errors and latency?
WITH RankedLatency AS (
SELECT player_id,
    log_id,
    level_reached,
    completion_velocity_sec,
    errors_encountered,
    DENSE_RANK() OVER (PARTITION BY player_id ORDER BY errors_encountered DESC, completion_velocity_sec DESC) AS trouble_rank
FROM GAME_LOGS
)
