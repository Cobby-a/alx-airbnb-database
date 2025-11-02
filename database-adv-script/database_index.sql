-- ====================================================================
-- INDEX CREATION SCRIPT: Optimization for Query Performance
-- Objective: Create non-unique indexes on frequently queried and joined columns.
-- ====================================================================

-- 1. Index on Users.role
-- Purpose: Speeds up queries filtering users by their role (e.g., getting all 'hosts' or all 'guests').
CREATE INDEX idx_user_role ON Users (role);

-- 2. Index on Properties.location
-- Purpose: Essential for the core search functionality, which heavily relies on location filtering.
-- This dramatically speeds up 'SELECT * FROM Properties WHERE location = "Paris"'.
CREATE INDEX idx_property_location ON Properties (location);

-- 3. Index on Properties.pricepernight
-- Purpose: Optimizes queries filtering by price range (e.g., WHERE pricepernight BETWEEN 100 AND 200).
CREATE INDEX idx_property_price ON Properties (pricepernight);

-- 4. Index on Bookings.user_id
-- Purpose: Even though this is a Foreign Key, explicitly indexing it speeds up queries
-- retrieving all bookings for a specific user (GET /users/{user_id}/bookings).
CREATE INDEX idx_booking_user_id ON Bookings (user_id);

-- 5. Index on Bookings.start_date
-- Purpose: Improves performance for date range queries, which are common for availability checks
-- and filtering upcoming trips.
CREATE INDEX idx_booking_start_date ON Bookings (start_date);

-- 6. Index on Reviews.property_id
-- Purpose: Speeds up queries fetching all reviews for a single property (a core UI feature).
CREATE INDEX idx_review_property_id ON Reviews (property_id);