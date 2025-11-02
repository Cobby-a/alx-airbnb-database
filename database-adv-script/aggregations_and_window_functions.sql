-- ====================================================================
-- ADVANCED SQL QUERIES: AGGREGATIONS AND WINDOW FUNCTIONS
-- Objective: Analyze data using COUNT, GROUP BY, and ranking functions.
-- ====================================================================

-- 1. AGGREGATION QUERY: Find the total number of bookings made by each user.
--    Uses COUNT and GROUP BY. A LEFT JOIN is used to include all users,
--    even those who have made zero bookings (COUNT will be 0).
SELECT
    U.user_id,
    U.first_name,
    U.last_name,
    COUNT(B.booking_id) AS total_bookings_made
FROM
    Users U
LEFT JOIN
    Bookings B ON U.user_id = B.user_id
GROUP BY
    U.user_id, U.first_name, U.last_name
ORDER BY
    total_bookings_made DESC, U.last_name;


-- 2. WINDOW FUNCTION QUERY: Rank properties based on the total number of bookings received.
--    This uses a subquery to calculate the total bookings per property first,
--    then applies the window functions RANK() and ROW_NUMBER() in the outer query.
SELECT
    property_id,
    property_name,
    total_bookings,
    -- RANK: Assigns the same rank to properties with the same number of bookings (creates gaps in numbering).
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank,
    -- ROW_NUMBER: Assigns a unique, sequential integer to each row (no gaps).
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS sequential_row_num
FROM
    (
        SELECT
            P.property_id,
            P.name AS property_name,
            COUNT(B.booking_id) AS total_bookings
        FROM
            Properties P
        LEFT JOIN
            Bookings B ON P.property_id = B.property_id
        GROUP BY
            P.property_id, P.name
    ) AS PropertyBookingCounts
ORDER BY
    booking_rank, property_name;