# Database Schema Definition (0x01)

This directory contains the initial SQL script (`schema.sql`) used to define the core database structure for the Airbnb clone application.

The design adheres to Third Normal Form (3NF) and includes all necessary entities, attributes, primary keys (PKs), foreign keys (FKs), and constraints derived from the project specification.

## Key Features of `schema.sql`

* **UUIDs:** Primary keys are defined using `CHAR(36)` to store UUIDs, which are indexed for fast lookup.
* **Constraints:** `UNIQUE` constraints (e.g., on user email) and `CHECK` constraints (e.g., for roles, statuses, and review ratings) are included to maintain data integrity.
* **Foreign Keys:** All relationships are enforced using foreign keys, including the crucial one-to-one constraint between **Bookings** and **Payments**.
* **Indexing:** The required indexes on `email`, `Bookings.property_id`, and `Payments.booking_id` are explicitly created to optimize specific query paths.