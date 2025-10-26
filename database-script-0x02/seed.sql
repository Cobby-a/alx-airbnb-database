-- ====================================================================
-- SAMPLE DATA INSERTION SCRIPT: seed.sql (for alx-airbnb-database)
-- ====================================================================

-- 1. USERS
INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'Alice', 'Hostington', 'alice.host@example.com', 'hash_alice_host', '111-222-3333', 'host'),
('550e8400-e29b-41d4-a716-446655440002', 'Bob', 'Guestman', 'bob.guest@example.com', 'hash_bob_guest', '444-555-6666', 'guest'),
('550e8400-e29b-41d4-a716-446655440003', 'Charlie', 'Admin', 'charlie.admin@example.com', 'hash_charlie_admin', NULL, 'admin'),
('550e8400-e29b-41d4-a716-446655440004', 'Dana', 'Wanderer', 'dana.guest@example.com', 'hash_dana_guest', '777-888-9999', 'guest');


-- 2. PROPERTIES (Hosted by Alice and Charlie)
INSERT INTO Properties (property_id, host_id, name, description, location, pricepernight) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380011', '550e8400-e29b-41d4-a716-446655440001', 'Luxury Downtown Penthouse', 'A modern, high-rise penthouse with stunning city views.', 'New York, NY', 350.00),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380022', '550e8400-e29b-41d4-a716-446655440001', 'Cozy Lakeside Cabin', 'Rustic cabin perfect for a peaceful nature retreat.', 'Lake Tahoe, CA', 180.00),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380033', '550e8400-e29b-41d4-a716-446655440003', 'Tropical Beach Villa', 'Private villa steps from the sand, hosted by admin Charlie.', 'Miami, FL', 500.00);


-- 3. BOOKINGS
INSERT INTO Bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380101', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380011', '550e8400-e29b-41d4-a716-446655440002', '2024-11-15', '2024-11-18', 1050.00, 'confirmed'), -- Bob (Guest) booked Penthouse (3 nights @ $350)
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380102', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380022', '550e8400-e29b-41d4-a716-446655440004', '2024-12-20', '2024-12-25', 900.00, 'pending'), -- Dana (Guest) booked Cabin (5 nights @ $180)
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380103', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380033', '550e8400-e29b-41d4-a716-446655440002', '2025-01-05', '2025-01-07', 1000.00, 'canceled'); -- Bob (Guest) canceled Beach Villa (2 nights @ $500)


-- 4. PAYMENTS (Linked 1:1 to Confirmed Booking b0ee...0101)
-- Payment ID: p0ee...0201
INSERT INTO Payments (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('p0eebc99-9c0b-4ef8-bb6d-6bb9bd380201', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380101', 1050.00, '2024-10-25 10:00:00', 'credit_card');


-- 5. REVIEWS
-- Review IDs: r0ee...0301, r0ee...0302
INSERT INTO Reviews (review_id, property_id, user_id, rating, comment) VALUES
('r0eebc99-9c0b-4ef8-bb6d-6bb9bd380301', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380011', '550e8400-e29b-41d4-a716-446655440002', 5, 'Absolutely loved the view! Alice was a wonderful host and the location was perfect.'), -- Bob reviews Penthouse
('r0eebc99-9c0b-4ef8-bb6d-6bb9bd380302', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380033', '550e8400-e29b-41d4-a716-446655440004', 4, 'Great villa, spacious and clean. Pool area was very relaxing.'); -- Dana reviews Beach Villa


-- 6. MESSAGES (Bob (Guest) to Alice (Host) conversation)
-- Message IDs: m0ee...0401, m0ee...0402
INSERT INTO Messages (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('m0eebc99-9c0b-4ef8-bb6d-6bb9bd380401', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Hi Alice, is early check-in possible for the Nov 15th booking?', '2024-10-25 12:00:00'),
('m0eebc99-9c0b-4ef8-bb6d-6bb9bd380402', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440002', 'Hello Bob, I can offer check-in at 1 PM. I will send you the access code then.', '2024-10-25 12:10:00');