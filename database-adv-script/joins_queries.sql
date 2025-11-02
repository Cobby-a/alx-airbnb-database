-- 1. INNER JOIN: Retrieve all bookings and the respective user who made them.
SELECT
    B.booking_id,
    B.start_date,
    B.end_date,
    B.total_price,
    B.status AS booking_status,
    U.user_id,
    U.first_name,
    U.last_name,
    U.email
FROM
    Bookings B
INNER JOIN
    Users U ON B.user_id = U.user_id;


-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties
--    that have no reviews (Review fields will be NULL).
SELECT
    P.property_id,
    P.name AS property_name,
    P.location,
    P.pricepernight,
    R.review_id,
    R.rating,
    R.comment,
    R.created_at AS review_date
FROM
    Properties P
LEFT JOIN
    Reviews R ON P.property_id = R.property_id
ORDER BY
    P.property_id, R.created_at;


-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has
--    no booking or a booking is not linked to a user.

-- OPTION A: Standard SQL (e.g., PostgreSQL, SQL Server)

SELECT
    U.user_id,
    U.email,
    B.booking_id,
    B.start_date,
    B.status
FROM
    Users U
FULL OUTER JOIN
    Bookings B ON U.user_id = B.user_id
ORDER BY
    user_id, booking_id;


-- OPTION B: MySQL-Compatible (Using UNION of LEFT and RIGHT Joins)
(
    SELECT
        U.user_id,
        U.email,
        B.booking_id,
        B.start_date,
        B.status
    FROM
        Users U
    LEFT JOIN
        Bookings B ON U.user_id = B.user_id
)
UNION
(
    SELECT
        U.user_id,
        U.email,
        B.booking_id,
        B.start_date,
        B.status
    FROM
        Users U
    RIGHT JOIN
        Bookings B ON U.user_id = B.user_id
    WHERE
        U.user_id IS NULL
)
ORDER BY
    user_id, booking_id;