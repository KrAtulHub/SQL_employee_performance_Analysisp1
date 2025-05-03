# 📊 Employee Performance Analysis SQL Project

Welcome to the **Employee Performance Analysis** project! This project demonstrates a complete end-to-end workflow using **SQL** to manage, clean, and analyze employee performance review data. It’s designed to showcase your skills in database design, data cleaning, exploratory analysis, and deriving actionable business insights.

## 👨‍💼 Project Owner
**Atul Kr Prasad**

---

## 🗃️ Project Structure

- **Database:** PostgreSQL
- **Schema:** `employee_perf_db`
- **Table:** `employee_performance`
- **Primary Key:** `(emp_id, rating_date)`

---

## ⚙️ Features Implemented

### ✅ Data Modeling
- Defined structure using appropriate data types
- Implemented constraints (e.g., CHECK for performance score between 1–5)
- Used composite primary key for tracking multiple reviews per employee

### ✅ Data Cleaning
- Handled NULL checks
- Removed incomplete records
- Verified total rows and data consistency

### ✅ Exploratory & Business Analysis

#### General Queries:
- All reviews on specific dates
- High performers (score ≥ 4)
- Total reviews by department
- Average score by department
- Reviews by gender
- Monthly review trends

#### Advanced Analysis:
- Employees with performance drops
- Employees with consistent excellence
- Underperformers (score ≤ 2)
- Quarterly averages by department
- Reviewer-wise average score
- Yearly performance trends
- Gender breakdown by department
- Most active reviewer
- Latest review per employee
- Mixed-performance employees (both high and low scores)
- Score trends by age group (20s, 30s, etc.)

---

## 📌 Sample Insights

- 📈 **Top-performing department:** Finance (Avg. Score = 5.0)
- 👩‍💼 **Most reviewed employee:** Alice Johnson
- 🧑‍⚖️ **Most active reviewer:** Manager C
- 🧓 **Age group with highest average score:** 40s
- 🕵️ **Employees needing attention:** Daisy Patel (score = 2)

---

## 🛠️ Technologies Used

- PostgreSQL
- SQL (DDL, DML, Aggregates, Joins, Grouping)
- pgAdmin / psql CLI

---

⚡ "Data tells stories. In this project, each SQL query uncovers a new chapter in employee performance."
