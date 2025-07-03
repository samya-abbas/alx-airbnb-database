# 📄  README — `join_queries.sql`

## 1. Purpose
`join_queries.sql` is a small, self‑contained script that demonstrates three critical SQL‑join patterns against the **ALX Airbnb** sample schema:

1. **INNER JOIN** — list bookings with the user who made each booking.  
2. **LEFT JOIN** — list every property, together with any reviews (NULL if none).  
3. **FULL OUTER JOIN** — return every user and every booking, even when a match is missing (implemented with a UNION workaround for MySQL).

These queries are useful for learners who want to verify their understanding of join semantics while working with a realistic Airbnb‑style database.

---

## 2. Prerequisites

| Requirement | Version | Notes |
|-------------|---------|-------|
| **MySQL**   | 8.0+    | The script uses JSON and window functions available from 8.0. <br/>If you’re on PostgreSQL, the queries run unmodified except for the FULL OUTER workaround (PostgreSQL supports it natively). |
| **Schema**  | Tables: `users`, `properties`, `bookings`, `reviews` | Defined in the project’s `schema.sql`. |

---

## 3. How to Run

```bash
# Load database credentials from your shell
export DB="airbnb_clone"
export DBUSER="samya"
export DBPASS="secret"

# Execute the joins
mysql -u $DBUSER -p$DBPASS $DB < join_queries.sql
