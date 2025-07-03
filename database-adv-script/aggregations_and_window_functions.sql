/* =========================================================
   aggregations_and_window_functions.sql
   =========================================================
   1.  Aggregation: count total bookings per user
   2.  Window function: RANK() properties by booking volume
   ========================================================= */

/* 1️⃣  Total bookings made by each user */
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM   users      AS u
LEFT JOIN bookings AS b
       ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

/* 2️⃣  Rank properties based on total bookings (RANK window function) */
SELECT
    p.property_id,
    p.name             AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM   properties AS p
LEFT JOIN bookings   AS b
       ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_rank;
