/* ==========================================================
   SAMPLE DATA – Airbnb Clone
   ----------------------------------------------------------
   Load order: user → property → booking → payment → review → message
   ========================================================== */

/* ---------- 1. USERS (2 hosts, 2 guests, 1 admin) ---------- */
INSERT INTO user (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  ('11111111-1111-1111-1111-111111111111', 'Alice',  'Hoster',  'alice@bnb.com',  'hashed_pw_1', '+123456781', 'host'),
  ('22222222-2222-2222-2222-222222222222', 'Bob',    'Owner',   'bob@bnb.com',    'hashed_pw_2', '+123456782', 'host'),
  ('33333333-3333-3333-3333-333333333333', 'Charlie','Guest',   'charlie@bnb.com','hashed_pw_3', '+123456783', 'guest'),
  ('44444444-4444-4444-4444-444444444444', 'Dana',   'Traveler','dana@bnb.com',   'hashed_pw_4', '+123456784', 'guest'),
  ('55555555-5555-5555-5555-555555555555', 'Admin',  'Root',    'admin@bnb.com',  'hashed_pw_5', NULL,         'admin');

/* ---------- 2. PROPERTIES (3 listings) ---------- */
INSERT INTO property (property_id, host_id, name, description, location, pricepernight)
VALUES
  ('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111',
   'Cozy Cottage', 'A small, cozy cottage in the countryside.', 'Oxford, UK', 75.00),
  ('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '11111111-1111-1111-1111-111111111111',
   'Downtown Loft', 'Modern loft in the city center.', 'London, UK', 120.00),
  ('aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3', '22222222-2222-2222-2222-222222222222',
   'Beach House', 'House with sea view and private beach.', 'Brighton, UK', 200.00);

/* ---------- 3. BOOKINGS (3 reservations) ---------- */
INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  ('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
   '33333333-3333-3333-3333-333333333333', '2025-08-10', '2025-08-15', 375.00, 'confirmed'),
  ('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
   '44444444-4444-4444-4444-444444444444', '2025-09-01', '2025-09-05', 480.00, 'confirmed'),
  ('bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbb3', 'aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3',
   '33333333-3333-3333-3333-333333333333', '2025-12-20', '2025-12-27', 1400.00, 'pending');

/* ---------- 4. PAYMENTS (match confirmed bookings) ---------- */
INSERT INTO payment (payment_id, booking_id, amount, payment_method)
VALUES
  ('ccccccc1-cccc-cccc-cccc-ccccccccccc1', 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 375.00, 'credit_card'),
  ('ccccccc2-cccc-cccc-cccc-ccccccccccc2', 'bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 480.00, 'paypal');

/* ---------- 5. REVIEWS (only for completed/confirmed stays) ---------- */
INSERT INTO review (review_id, property_id, user_id, rating, comment)
VALUES
  ('ddddddd1-dddd-dddd-dddd-ddddddddddd1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
   '33333333-3333-3333-3333-333333333333', 5, 'Wonderful quiet stay!'),
  ('ddddddd2-dddd-dddd-dddd-ddddddddddd2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
   '44444444-4444-4444-4444-444444444444', 4, 'Great location, a bit noisy at night.');

/* ---------- 6. MESSAGES (guest‑host chats) ---------- */
INSERT INTO message (message_id, sender_id, recipient_id, message_body)
VALUES
  ('eeeeeee1-eeee-eeee-eeee-eeeeeeeeeee1', '33333333-3333-3333-3333-333333333333',
   '11111111-1111-1111-1111-111111111111',
   'Hi Alice, is early check‑in possible?'),
  ('eeeeeee2-eeee-eeee-eeee-eeeeeeeeeee2', '11111111-1111-1111-1111-111111111111',
   '33333333-3333-3333-3333-333333333333',
   'Sure, you can check in from 11 AM.');
