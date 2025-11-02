# Index and Performance Optimization Analysis

This document outlines the procedure and expected results for measuring the performance impact of the newly created indexes defined in `database_index.sql`.

## 1. Objective

To demonstrate significant query performance improvements by measuring execution time before and after applying indexes on high-usage columns (like `location`, `role`, and `start_date`).

## 2. Measurement Procedure

To accurately measure performance, use the database's built-in query analysis tool, such as `EXPLAIN ANALYZE` (PostgreSQL/MySQL).

### Step 1: Pre-Index Measurement

Run the following queries *before* executing `database_index.sql` and record the execution time and plan:

```sql
-- Query A: Search by Location (Key filter)
EXPLAIN ANALYZE SELECT property_id, name FROM Properties WHERE location = 'New York City';

-- Query B: Find Bookings by User (Key join/filter)
EXPLAIN ANALYZE SELECT * FROM Bookings WHERE user_id = 'c1664183-f27a-426b-871d-7206d2c4e207';

-- Query C: Find all Hosts (Key filter by role)
EXPLAIN ANALYZE SELECT user_id, email FROM Users WHERE role = 'host' ORDER BY last_name;

```

### Step 2: Execute all CREATE INDEX statements from the database_index.sql file.


### Step 2: Post-Index Measurement

Run the exact same queries again and record the new execution time and plan:

```sql
-- Re-run Query A
EXPLAIN ANALYZE SELECT property_id, name FROM Properties WHERE location = 'New York City';

-- Re-run Query B
EXPLAIN ANALYZE SELECT * FROM Bookings WHERE user_id = 'c1664183-f27a-426b-871d-7206d2c4e207';

-- Re-run Query C
EXPLAIN ANALYZE SELECT user_id, email FROM Users WHERE role = 'host' ORDER BY last_name;

```