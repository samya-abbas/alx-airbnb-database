SELECT
    p.property_id,
    p.name,
    p.location,
    /* show the computed average for reference */
    (
        SELECT AVG(r.rating)
        FROM reviews r
        WHERE r.property_id = p.property_id
    ) AS avg_rating
FROM properties AS p
WHERE (
    SELECT AVG(r.rating)
    FROM reviews r
    WHERE r.property_id = p.property_id
) > 4.0;

SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    (
        SELECT COUNT(*)
        FROM bookings b
        WHERE b.user_id = u.user_id
    ) AS booking_count
FROM users AS u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;

SELECT u.user_id, u.first_name
FROM users u
WHERE (
  SELECT COUNT(*)
  FROM bookings b
  WHERE b.user_id = u.user_id
) > 3;
