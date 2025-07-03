# 🏠 Airbnb‑Clone SQL Query Suite

This repository contains a collection of SQL scripts designed to explore and analyze the backend data model for an Airbnb-style platform. Each script demonstrates a specific concept such as joins, subqueries, aggregation, and ranking.

---

## 📁 Files Included

| Filename                        | Purpose                                 |
|---------------------------------|-----------------------------------------|
| `join_queries.sql`              | Demonstrates `INNER`, `LEFT`, and `FULL OUTER JOIN` usage |
| `sub_queries.sql`               | Contains correlated and non-correlated subqueries |
| `aggregation_window_queries.sql` | Uses aggregate functions and window functions (e.g. `COUNT`, `RANK`) |

---

## 🔎 Aggregation and Window Function Queries

### 1️⃣ Total Bookings per User

This query returns the total number of bookings made by each user using `COUNT()` and `GROUP BY`.

```sql
SELECT u.user_id, COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id;
