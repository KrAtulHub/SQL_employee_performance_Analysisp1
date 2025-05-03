CREATE DATABASE employee_perf_db;

-- Use the new database
\c employee_perf_db;

-- Create performance table
CREATE TABLE employee_performance (
    emp_id INT,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    rating_date DATE,
    reviewer VARCHAR(100),
    performance_score INT CHECK (performance_score BETWEEN 1 AND 5),
    comments TEXT,
    PRIMARY KEY (emp_id, rating_date)
);

DROP TABLE employee_performance;

INSERT INTO employee_performance (emp_id, emp_name, department, gender, age, rating_date, reviewer, performance_score, comments)
VALUES
(101, 'Alice Johnson', 'HR', 'Female', 29, '2023-01-15', 'Manager A', 5, 'Excellent'),
(102, 'Bob Smith', 'Sales', 'Male', 34, '2023-01-15', 'Manager B', 4, 'Good performer'),
(103, 'Charlie Lee', 'Tech', 'Male', 27, '2023-02-10', 'Manager C', 3, 'Average output'),
(104, 'Daisy Patel', 'Tech', 'Female', 31, '2023-03-05', 'Manager C', 2, 'Needs improvement'),
(101, 'Alice Johnson', 'HR', 'Female', 29, '2023-06-15', 'Manager A', 4, 'Slightly dropped'),
(102, 'Bob Smith', 'Sales', 'Male', 34, '2023-06-15', 'Manager B', 3, 'Neutral'),
(105, 'Evan Zhang', 'Finance', 'Male', 40, '2023-04-20', 'Manager D', 5, 'Outstanding');

SELECT*FROM employee_performance;

--  Data Cleaning
SELECT COUNT(*) FROM employee_performance;

-- Null Value Check
SELECT * FROM employee_performance
WHERE emp_id IS NULL OR emp_name IS NULL OR department IS NULL OR
      gender IS NULL OR age IS NULL OR rating_date IS NULL OR
      reviewer IS NULL OR performance_score IS NULL;

-- Delete Incomplete Records
DELETE FROM employee_performance
WHERE emp_id IS NULL OR emp_name IS NULL OR department IS NULL OR
      gender IS NULL OR age IS NULL OR rating_date IS NULL OR
      reviewer IS NULL OR performance_score IS NULL;


                                      --Exploratory & Business Analysis Queries


-- 1. Identify Employees with Performance Drop Over Time
SELECT emp_id, emp_name, MIN(performance_score) AS min_score, MAX(performance_score) AS max_score, 
       MAX(performance_score) - MIN(performance_score) AS score_diff 
FROM employee_performance 
GROUP BY emp_id, emp_name 
HAVING MAX(performance_score) > MIN(performance_score) 
ORDER BY score_diff DESC;

-- 2. Employees with Consistently Excellent Scores (Score ≥ 4)
SELECT emp_id, emp_name 
FROM employee_performance 
GROUP BY emp_id, emp_name 
HAVING MIN(performance_score) >= 4;

-- 3. Flag Underperforming Employees (Score ≤ 2)
SELECT DISTINCT emp_id, emp_name 
FROM employee_performance 
WHERE performance_score <= 2;

-- 4. Employees Reviewed Multiple Times in the Same Year
SELECT emp_id, emp_name, EXTRACT(YEAR FROM rating_date) AS year, COUNT(*) AS reviews_in_year 
FROM employee_performance 
GROUP BY emp_id, emp_name, year 
HAVING COUNT(*) > 1;

-- 5. Quarterly Average Performance by Department
SELECT department, 
       CONCAT('Q', CEIL(EXTRACT(MONTH FROM rating_date)/3)) AS quarter, 
       EXTRACT(YEAR FROM rating_date) AS year, 
       ROUND(AVG(performance_score), 2) AS avg_score 
FROM employee_performance 
GROUP BY department, year, quarter 
ORDER BY department, year, quarter;

-- 6. Reviewer-wise Average Performance Score
SELECT reviewer, 
       ROUND(AVG(performance_score), 2) AS avg_given_score 
FROM employee_performance 
GROUP BY reviewer 
ORDER BY avg_given_score DESC;

-- 7. Yearly Performance Trend (All Employees Combined)
SELECT EXTRACT(YEAR FROM rating_date) AS year, 
       ROUND(AVG(performance_score), 2) AS avg_score 
FROM employee_performance 
GROUP BY year 
ORDER BY year;

-- 8. Department with Highest Average Score
SELECT department, 
       ROUND(AVG(performance_score), 2) AS avg_score 
FROM employee_performance 
GROUP BY department 
ORDER BY avg_score DESC 
LIMIT 1;

-- 9. Department-wise Gender Breakdown of Reviews
SELECT department, gender, 
       COUNT(*) AS num_reviews 
FROM employee_performance 
GROUP BY department, gender 
ORDER BY department, gender;

-- 10. Latest Review per Employee
SELECT ep.* 
FROM employee_performance ep 
INNER JOIN (
    SELECT emp_id, MAX(rating_date) AS latest_date 
    FROM employee_performance 
    GROUP BY emp_id
) latest 
ON ep.emp_id = latest.emp_id AND ep.rating_date = latest.latest_date 
ORDER BY ep.emp_id;

--11. Find employees who received both high (≥4) and low (≤2) ratings
SELECT emp_id, emp_name
FROM employee_performance
GROUP BY emp_id, emp_name
HAVING MAX(performance_score) >= 4 AND MIN(performance_score) <= 2;

-- 12. Most Active Reviewer (gave the most reviews)
SELECT reviewer, COUNT(*) AS total_reviews
FROM employee_performance
GROUP BY reviewer
ORDER BY total_reviews DESC
LIMIT 1;

--16. Average Score by Age Group (e.g., 20s, 30s, 40s)
SELECT FLOOR(age/10)*10 AS age_group, ROUND(AVG(performance_score), 2) AS avg_score
FROM employee_performance
GROUP BY age_group
ORDER BY age_group;

-- End of project






