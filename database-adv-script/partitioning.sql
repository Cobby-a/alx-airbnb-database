-- ====================================================================
-- TABLE PARTITIONING SCRIPT: Optimizing the Bookings Table
-- Objective: Partition the large Bookings table by start_date for improved
--            query performance, especially on date range lookups.
-- ====================================================================

-- NOTE: This script uses PostgreSQL's declarative partitioning syntax.
-- Implementation details may vary significantly for MySQL (which uses sub-tables)
-- or other database systems.

-- 1. Create the new partitioned master table (Bookings_Partitioned)
--    The PARTITION BY clause specifies the column and method (RANGE in this case).
CREATE TABLE Bookings_Partitioned (
    booking_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- 2. Create individual partitions based on time ranges (e.g., yearly)
--    Queries targeting a specific year will only scan the relevant partition.

-- Partition for 2024 Bookings
CREATE TABLE bookings_y2024 PARTITION OF Bookings_Partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Partition for 2025 Bookings (Upcoming)
CREATE TABLE bookings_y2025 PARTITION OF Bookings_Partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Optional: Create a default partition for future or unexpected dates
CREATE TABLE bookings_default PARTITION OF Bookings_Partitioned DEFAULT;

-- 3. Add Foreign Key Constraints to the master table
--    These constraints are checked across all partitions.
ALTER TABLE Bookings_Partitioned
    ADD CONSTRAINT fk_user
    FOREIGN KEY (user_id) REFERENCES Users (user_id);

ALTER TABLE Bookings_Partitioned
    ADD CONSTRAINT fk_property
    FOREIGN KEY (property_id) REFERENCES Properties (property_id);

-- 4. Create Indexes on frequently used columns within the partitions
--    (These indexes are applied automatically to all current and future partitions)
CREATE INDEX idx_part_user_id ON Bookings_Partitioned (user_id);
CREATE INDEX idx_part_property_id ON Bookings_Partitioned (property_id);