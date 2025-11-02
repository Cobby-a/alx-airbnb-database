# Advanced Database Queries (0x03)

This directory contains SQL scripts that demonstrate advanced query writing techniques and database optimization strategies, focusing on linking data, complex analysis, and performance tuning.

---

## 1. File: `joins_queries.sql` (Mastering Joins)

This script covers the three major join types necessary for retrieving relational data:

1.  **INNER JOIN:** Used to find matching records (e.g., all bookings that have a corresponding user).
2.  **LEFT JOIN:** Used to retrieve all records from the left table and matching records from the right (e.g., all properties, including those with zero reviews).
3.  **FULL OUTER JOIN:** Used to show all records from both tables, regardless of whether a matching relationship exists. The script provides both the standard `FULL OUTER JOIN` syntax and the MySQL-compatible `UNION` equivalent.

---

## 2. File: `subqueries.sql` (Complex Filtering)

This script demonstrates the use of nested queries for sophisticated data manipulation:

1.  **Non-Correlated Subquery:** Used to find properties based on a calculated aggregate (e.g., average rating greater than 4.0). The inner query is independent of the outer query.
2.  **Correlated Subquery:** Used to find users based on criteria that depend on their related records (e.g., users who have made more than 3 bookings). The inner query executes once for every row processed by the outer query.

---

## 3. File: `aggregations_and_window_functions.sql` (Analysis and Ranking)

This script focuses on analytical queries used for reporting and ranking:

1.  **Aggregation (`COUNT` and `GROUP BY`):** Calculates the total number of bookings made by each user.
2.  **Window Functions (`RANK` and `ROW_NUMBER`):** Ranks properties based on their popularity (total number of bookings), illustrating the difference between rank functions that handle ties (`RANK`) and those that assign a unique sequential number (`ROW_NUMBER`).

---

## 4. Performance Optimization and Monitoring

These files address advanced performance tuning and maintenance:

* **`database_index.sql`:** Contains `CREATE INDEX` statements for key columns (`location`, `role`, `start_date`, etc.) to significantly speed up filtering and join operations.
* **`perfomance.sql`:** Contains an initial multi-join query (baseline) and a refactored version.
* **`optimization_report.md`:** Documents the required procedure for measuring query execution time using `EXPLAIN ANALYZE` and details the strategy of leveraging indices.
* **`partitioning.sql`:** Contains the SQL commands to implement **Range Partitioning** on the large `Bookings` table.
* **`partition_performance.md`:** Documents the benefits of partitioning, showing how **partition pruning** drastically reduces the query search space.
* **`performance_monitoring.md`:** Outlines a strategy for continuous monitoring, demonstrating the identification of a bottleneck in availability checks and suggesting advanced solutions like **Compound Indexes** and **Materialized Views**.