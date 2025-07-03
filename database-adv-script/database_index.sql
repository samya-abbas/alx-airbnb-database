-- Indexing high-usage columns

-- 1. Index user_id in bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- 2. Index property_id in bookings table
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- 3. Index property_id in reviews table
CREATE INDEX idx_reviews_property_id ON reviews(property_id);

-- 4. Index start_date in bookings table
CREATE INDEX idx_bookings_start_date ON bookings(start_date);

-- --------------------------------------------------------------------
-- Measuring performance using EXPLAIN ANALYZE before/after indexing

-- Query 1: Count bookings by user
EXPLAIN ANALYZE
SELECT COUNT(*) FROM bookings WHERE user_id = 'user-123';

-- Query 2: Join properties with bookings
EXPLAIN ANALYZE
SELECT p.name, COUNT(b.booking_id)
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id;

-- Query 3: Filter bookings by start date
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE start_date >= '2025-01-01';
