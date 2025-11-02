-- ====================================================================
-- ADVANCED SQL QUERIES: SUBQUERIES (subqueries.sql)
-- Objective: Demonstrate the use of non-correlated and correlated subqueries
-- ====================================================================

-- 1. NON-CORRELATED SUBQUERY: Find all properties where the average rating is greater than 4.0.

SELECT
    property_id,
    name,
    location,
    pricepernight
FROM
    Properties
WHERE
    property_id IN (
        SELECT
            property_id
        FROM
            Reviews
        GROUP BY
            property_id
        HAVING
            AVG(rating) > 4.0
    );

-- ----------------------------------------------------------------------------------

-- 2. CORRELATED SUBQUERY: Find users who have made more than 3 bookings.
SELECT
    U.user_id,
    U.first_name,
    U.last_name,
    U.email
FROM
    Users U
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            Bookings B
        WHERE
            B.user_id = U.user_id
    ) > 3;