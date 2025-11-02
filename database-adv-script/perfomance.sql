-- ====================================================================
-- SQL QUERY OPTIMIZATION: PERFORMANCE BASELINE AND REFACTORING
-- Objective: Analyze and refactor a complex, multi-join query for speed.
-- ====================================================================

-- --- INITIAL QUERY (Performance Baseline) ---
-- Retrieves all bookings, along with details from Users, Properties, and Payments.
-- This query uses four tables and is a good candidate for performance analysis.
SELECT
    B.booking_id,
    B.start_date,
    B.end_date,
    B.total_price AS booking_amount,
    U.first_name AS guest_first_name,
    U.last_name AS guest_last_name,
    P.name AS property_name,
    P.location AS property_location,
    Py.payment_date,
    Py.amount AS paid_amount,
    Py.payment_method
FROM
    Bookings B
INNER JOIN
    Users U ON B.user_id = U.user_id        -- Join 1: To get User details
INNER JOIN
    Properties P ON B.property_id = P.property_id -- Join 2: To get Property details
LEFT JOIN
    Payments Py ON B.booking_id = Py.booking_id -- Join 3: To get Payment details (LEFT JOIN ensures bookings without payment are still included, which is often realistic)
ORDER BY
    B.start_date DESC;

-- --- ANALYSIS STEP 1: EXPLAIN BASELINE ---
-- Use this command to see the execution plan and identify bottlenecks (e.g., Full Table Scans)
-- EXPLAIN ANALYZE SELECT ... (the query above) ...

-- -----------------------------------------------------------------------------

-- --- REFACTORED QUERY (Optimized Version) ---
-- The structure is often kept the same, but optimization relies heavily on having
-- the correct indexes in place (see database_index.sql) for all JOIN and ORDER BY columns:
-- 1. Bookings.user_id (indexed as a FK)
-- 2. Bookings.property_id (indexed as a FK)
-- 3. Payments.booking_id (indexed as UNIQUE)
-- 4. Bookings.start_date (indexed by idx_booking_start_date)

-- If indexing is applied correctly, the query becomes efficient without structural changes.
-- If the Payment table is large, keeping the LEFT JOIN ensures efficiency only for the payments needed.
SELECT
    B.booking_id,
    B.start_date,
    B.end_date,
    B.total_price AS booking_amount,
    U.first_name AS guest_first_name,
    U.last_name AS guest_last_name,
    P.name AS property_name,
    P.location AS property_location,
    Py.payment_date,
    Py.amount AS paid_amount,
    Py.payment_method
FROM
    Bookings B
INNER JOIN
    Users U ON B.user_id = U.user_id
INNER JOIN
    Properties P ON B.property_id = P.property_id
LEFT JOIN
    Payments Py ON B.booking_id = Py.booking_id
ORDER BY
    B.start_date DESC; -- Optimized by index on Bookings.start_date

-- --- ANALYSIS STEP 2: EXPLAIN OPTIMIZED ---
-- Use this command to confirm the execution plan now uses Index Scans instead of Table Scans.
-- EXPLAIN ANALYZE SELECT ... (the query above) ...