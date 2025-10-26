# Database Normalization Analysis (Third Normal Form - 3NF)

## Objective

The goal is to confirm that the existing Airbnb database schema adheres to **Third Normal Form (3NF)** to ensure optimal data integrity and minimal redundancy.

---

## Normalization Verification

The current schema, encompassing the Users, Properties, Bookings, Payments, Reviews, and Messages entities, is verified to be in 3NF.

### 1. First Normal Form (1NF) $\checkmark$

**Rule:** Ensure all columns hold **atomic (single) values** and eliminate repeating groups.

* **Verification:** All attributes (e.g., `first_name`, `email`, `pricepernight`) store single, non-divisible values. No lists or repeating field groups are present in any table.

### 2. Second Normal Form (2NF) $\checkmark$

**Rule:** Must be in 1NF, and all non-key attributes must be **fully dependent on the entire Primary Key (PK)**.

* **Verification:** Since all core tables use a single-column Primary Key (a unique UUID, e.g., `booking_id`), all non-key attributes are inherently fully dependent on that key.
* **Example:** In the **Reviews** table, the `rating` and `comment` depend only on the unique `review_id`.

### 3. Third Normal Form (3NF) $\checkmark$

**Rule:** Must be in 2NF, and there must be **no transitive dependencies** (where a non-key attribute determines another non-key attribute).

* **Verification:** Transitive dependencies are prevented by separating data into distinct subject tables and linking them with Foreign Keys (FKs).
    * **Host Data:** Host information (e.g., `email`) is stored only in the **Users** table. The **Properties** table uses the `host_id` (FK) to link to the host. This prevents host details from being redundantly repeated in every property record.
    * **Calculated Data:** The `total_price` in the **Bookings** table is a calculated value dependent on the unique `booking_id` (and the booking's dates/property price), not another non-key field.

---

## Conclusion

The existing database schema structure successfully meets the requirements of **Third Normal Form (3NF)**. This is achieved through the disciplined use of primary and foreign keys, ensuring each attribute is placed in the table where it is uniquely determined by the primary key, thereby eliminating structural redundancy.