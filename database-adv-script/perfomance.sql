/* ============================================================
   1. BASELINE – complex “kitchen‑sink” query (inefficient)
   ============================================================ */
SELECT
    b.*,
    u.*,
    p.*,
    pay.*
FROM   bookings  AS b
JOIN   users     AS u   ON u.user_id      = b.user_id
JOIN   properties AS p  ON p.property_id  = b.property_id
LEFT  JOIN payments  AS pay ON pay.booking_id = b.booking_id;

/* You can run:  EXPLAIN ANALYZE <the statement above>;          */
/* Expect full‑table scans on payments and perhaps properties.   */

/* ============================================================
   2. OPTIMISED – explicit column list, tighter JOIN path
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
FROM bookings  AS b
/* user_id & property_id are indexed – fastest filters first */
JOIN   users      AS u   USING (user_id)
JOIN   properties AS p   USING (property_id)
/* payment may not exist yet: keep LEFT JOIN but on indexed PK */
LEFT JOIN payments  AS pay
       ON pay.booking_id = b.booking_id
ORDER BY b.start_date DESC;

/* Run EXPLAIN ANALYZE again to verify:                       */
/*  - index lookups instead of full scans                      */
/*  - fewer columns read, smaller temp tables                  */
