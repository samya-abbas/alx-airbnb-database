-- ***************************************************
-- ALX Airbnb Database: Aggregations & Window Functions
-- File: aggregations_and_window_functions.sql
-- Description: Count total bookings per user and rank properties by bookings using ROW_NUMBER and RANK
-- ***************************************************

-- =============================================
-- 1. Aggregation:
-- Count the total number of bookings made by each user
-- =============================================

SELECT 
    u.id AS user_id,
    u.first_name,
    u.last_name,
    COUNT(b.id) AS total_bookings
FROM 
    users u
JOIN 
    bookings b ON u.id = b.user_id
GROUP BY 
    u.id, u.first_name, u.last_name
ORDER BY 
    total_bookings DESC;

-- =============================================
-- 2. Window Function with ROW_NUMBER():
-- Rank properties based on total number of bookings using ROW_NUMBER
-- =============================================

SELECT 
    p.id AS property_id,
    p.name AS property_name,
    COUNT(b.id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.id) DESC) AS property_row_number
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.id = b.property_id
GROUP BY 
    p.id, p.name;

-- =============================================
-- 3. Window Function with RANK():
-- Rank properties based on total number of bookings using RANK
-- =============================================

SELECT 
    p.id AS property_id,
    p.name AS property_name,
    COUNT(b.id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.id) DESC) AS property_rank
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.id = b.property_id
GROUP BY 
    p.id, p.name;
