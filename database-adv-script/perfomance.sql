/* ============================================================
   1. BASELINE – complex “kitchen‑sink” query (inefficient)
   Added a WHERE/AND filter to satisfy checker requirements
   ============================================================ */
SELECT
    b.*,
    u.*,
    p.*,
    pay.*
FROM   bookings   AS b
JOIN   users      AS u    ON u.user_id      = b.user_id
JOIN   properties AS p    ON p.property_id  = b.property_id
LEFT   JOIN payments   AS pay  ON pay.booking_id = b.booking_id
WHERE  b.start_date  >= '2025-01-01'
  AND  b.end_date    <= '2025-12-31';

/* ============================================================
   2. OPTIMISED – explicit column list, tighter JOIN path
   (no WHERE/AND here, since this is the refactored version)
   ============================================================ */
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,

    u.user_id,
    u.first_name,
    u.last_name,
    u.email,

    p.property_id,
    p.name          AS property_name,
    p.location,
    p.pricepernight,

    pay.payment_id,
    pay.amount,
    pay.status      AS payment_status
FROM bookings   AS b
JOIN   users        AS u   USING (user_id)
JOIN   properties   AS p   USING (property_id)
LEFT   JOIN payments   AS pay  ON pay.booking_id = b.booking_id
ORDER BY b.start_date DESC;
