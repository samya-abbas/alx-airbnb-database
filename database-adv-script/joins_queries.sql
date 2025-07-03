SELECT
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM bookings AS b
INNER JOIN users AS u
      ON b.user_id = u.user_id;


SELECT
    p.property_id,
    p.name,
    r.review_id,
    r.rating,
    r.comment
FROM properties AS p
LEFT JOIN reviews AS r
       ON p.property_id = r.property_id
ORDER BY p.property_id;

-- part A: everyone who has a booking  (users LEFT JOIN bookings)
SELECT
    u.user_id,
    u.first_name,
    b.booking_id,
    b.property_id,
    'left_side' AS join_side
FROM users AS u
LEFT JOIN bookings AS b
       ON u.user_id = b.user_id

UNION ALL

-- part B: bookings that have no matching user  (anti‑join)
SELECT
    u.user_id,
    u.first_name,
    b.booking_id,
    b.property_id,
    'right_side' AS join_side
FROM bookings AS b
LEFT JOIN users AS u
       ON b.user_id = u.user_id
WHERE u.user_id IS NULL;

/* Q3 – all users plus all bookings, linked or not */
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM   users    AS u
FULL OUTER JOIN bookings AS b
       ON u.user_id = b.user_id;

