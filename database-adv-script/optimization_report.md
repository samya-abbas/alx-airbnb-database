# 🔧 Query Optimisation Report

## 🎯 Goal
Reduce execution time for the “all‑bookings with user, property & payment details” query.

---

## 1. Baseline Query (perfomance.sql – section 1)

```sql
SELECT b.*, u.*, p.*, pay.*
FROM   bookings b
JOIN   users u        ON u.user_id      = b.user_id
JOIN   properties p   ON p.property_id  = b.property_id
LEFT  JOIN payments pay ON pay.booking_id = b.booking_id;
