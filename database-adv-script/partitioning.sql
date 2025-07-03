-- 1. Create a new partitioned bookings table by RANGE on start_date
CREATE TABLE bookings_partitioned (
    booking_id    UUID PRIMARY KEY,
    user_id       UUID NOT NULL,
    property_id   UUID NOT NULL,
    start_date    DATE NOT NULL,
    end_date      DATE NOT NULL,
    total_price   DECIMAL(10, 2) NOT NULL,
    status        VARCHAR(20),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- 2. Create partitions per quarter of 2025
CREATE TABLE bookings_2025_q1 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');

CREATE TABLE bookings_2025_q2 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');

CREATE TABLE bookings_2025_q3 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-07-01') TO ('2025-10-01');

CREATE TABLE bookings_2025_q4 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-10-01') TO ('2026-01-01');

-- 3. Optional indexes for filtering
CREATE INDEX idx_partition_q1_user_id ON bookings_2025_q1(user_id);
CREATE INDEX idx_partition_q2_user_id ON bookings_2025_q2(user_id);
CREATE INDEX idx_partition_q3_user_id ON bookings_2025_q3(user_id);
CREATE INDEX idx_partition_q4_user_id ON bookings_2025_q4(user_id);

-- 4. Sample partition-aware query (should scan only one partition)
EXPLAIN ANALYZE
SELECT *
FROM bookings_partitioned
WHERE start_date BETWEEN '2025-04-01' AND '2025-06-30';
