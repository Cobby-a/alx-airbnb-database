# Advanced Database Queries (0x03)

This directory contains `joins_queries.sql`, a script dedicated to demonstrating advanced SQL concepts, specifically different types of JOIN operations. These queries are fundamental for linking data across the normalized tables (Users, Properties, Bookings, Reviews, etc.) for reporting and application logic.

## Queries Included

The script covers the three major join types:

1. **INNER JOIN:** To find matching records between the `Bookings` and `Users` tables.
2. **LEFT JOIN:** To retrieve all properties and their related reviews, including properties with zero reviews (NULL review data).
3. **FULL OUTER JOIN:** To show all users and all bookings, regardless of whether a matching relationship exists. The script provides both the standard `FULL OUTER JOIN` syntax (for PostgreSQL, SQL Server, etc.) and the MySQL-compatible `UNION` equivalent.