# 🏠 Airbnb‑Clone — SQL Query Collection

This repository now contains **two** illustrative SQL scripts for the ALX Airbnb schema:

| File               | Focus Area | What it demonstrates |
|--------------------|------------|----------------------|
| `join_queries.sql` | Joins      | INNER, LEFT, and FULL OUTER joins across `users`, `properties`, `bookings`, and `reviews`. |
| `sub_queries.sql`  | Subqueries | Non‑correlated and correlated sub‑queries used for analytics‑style questions. |

---

## 1. Join Queries (recap)

* See the original README section for details.  
* Key use‑cases:  
  - **INNER JOIN** to pair bookings with their users.  
  - **LEFT JOIN** to show properties even when they lack reviews.  
  - **FULL OUTER JOIN** (using native syntax) to union users and bookings, keeping unmatched rows.

---

## 2. Sub‑queries

### 2.1 Properties Rated > 4.0

*Non‑correlated* sub‑query filters `properties` by the average `rating` in `reviews`.

```sql
SELECT p.property_id, p.name
FROM properties p
WHERE (
  SELECT AVG(r.rating)
  FROM reviews r
  WHERE r.property_id = p.property_id
) > 4.0;
