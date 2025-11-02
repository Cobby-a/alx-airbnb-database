Continuous Performance Monitoring and Refinement

This report outlines a strategy for the ongoing analysis and optimization of the Airbnb Clone database, ensuring high performance as the data volume and complexity of queries increase.

1. Monitoring Strategy

We will use EXPLAIN ANALYZE (or SHOW PROFILE in MySQL) to monitor the top 10 most frequent and resource-intensive queries identified by application logs. A common high-impact query, which is critical for the guest search experience, is chosen for demonstration below.

Example Query Monitored (Finding Available Properties by Location and Date Range)

This query is highly selective and complex, making it an excellent candidate for continuous monitoring.

-- Initial Query: Find properties in a specific city with available dates for a period.
SELECT
    P.property_id,
    P.name,
    P.pricepernight
FROM
    Properties P
LEFT JOIN
    Bookings B ON P.property_id = B.property_id
    AND B.status NOT IN ('canceled', 'rejected') -- Only consider confirmed/pending bookings
    AND B.end_date > '2025-01-01'               -- Start of search window
    AND B.start_date < '2025-01-15'             -- End of search window
WHERE
    P.location = 'San Francisco'
    AND B.booking_id IS NULL -- Crucial step to filter out properties that are booked during the period
ORDER BY
    P.pricepernight ASC;


2. Identifying Bottlenecks

Monitoring Tool Output

Initial Bottleneck Identified

Root Cause

EXPLAIN ANALYZE

High execution time on the LEFT JOIN condition involving multiple date comparisons and status checks.

The join condition on Bookings is complex, requiring the database to evaluate multiple fields (property_id, status, end_date, start_date) simultaneously.

I/O Cost

High sequential scans on the Properties table despite indexing on location.

The ORDER BY pricepernight often forces a Filesort if the result set is large and is not already ordered using an efficient index.

3. Recommended Adjustments and Implementation

Based on the analysis, the following schema adjustment and new index are crucial for refinement:

Adjustment 1: New Compound Index on Bookings

To optimize the highly selective LEFT JOIN used for availability checks, a Compound Index on the Bookings table is implemented.

SQL Implementation:

-- Creates an index to optimize joins and availability checks.
-- Order of columns is crucial: property_id first for join/filter, then dates/status for range checks.
CREATE INDEX idx_booking_availability ON Bookings (property_id, start_date, end_date, status);


Improvement: This index allows the query planner to quickly find or rule out conflicting bookings using a single index lookup (Index Scan) rather than evaluating four separate columns across the entire table, significantly reducing I/O and CPU load.

Adjustment 2: Database Schema Adjustment (Materialized View)

To optimize the calculation of aggregated data (which is slow but changes infrequently), a Materialized View is suggested.

Suggestion: Implement a Materialized View called mv_property_summary.

Rationale: The calculation of a property's average_rating is frequently required on detail pages but changes only when a new review is submitted. Pre-calculating this value and refreshing it nightly (or upon review submission) using a materialized view speeds up property detail pages significantly.

Conceptual SQL (Materialized View):

-- Requires periodic REFRESH MATERIALIZED VIEW after new reviews
CREATE MATERIALIZED VIEW mv_property_summary AS
SELECT
    P.property_id,
    COALESCE(AVG(R.rating), 0) AS average_rating,
    COUNT(R.review_id) AS review_count
FROM
    Properties P
LEFT JOIN
    Reviews R ON P.property_id = R.property_id
GROUP BY
    P.property_id;


4. Reporting Improvements

After implementing the idx_booking_availability index, the test query (Section 1) should be re-run with EXPLAIN ANALYZE.

The final result should confirm that the database executes the query using the new Index Scan for the availability join, and that the overall execution time has decreased by a measurable amount (e.g., 50-80%), validating the successful refinement.