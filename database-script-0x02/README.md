# Database Seeding Script (0x02)

This directory contains the SQL script (`seed.sql`) used to populate the core database tables with sample data. This data is designed to be realistic and is essential for validating the schema constraints and testing initial database queries.

## Content Overview

The `seed.sql` file includes `INSERT` statements for all six entities, ensuring all foreign key relationships are correctly established:

1. **Users:** Four users with different roles (Host, Guest, Admin).

2. **Properties:** Three properties linked to hosts.

3. **Bookings:** Three bookings demonstrating various statuses (confirmed, pending, canceled).

4. **Payments:** A successful payment record linked 1:1 to the confirmed booking.

5. **Reviews:** Two reviews left by a guest for a property.

6. **Messages:** A short conversation thread between a guest and a host.