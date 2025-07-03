# 📈 Airbnb Clone – Database Index Optimization

This task focuses on improving the performance of SQL queries in the Airbnb Clone backend by identifying and creating indexes on frequently used columns across the database.

---

## 🎯 Objective

To optimize the execution time of complex queries by creating indexes on columns that are frequently used in:
- `JOIN` conditions
- `WHERE` clauses
- `ORDER BY` operations

---

## 🧱 Targeted Tables and Columns

Based on query patterns from earlier tasks (joins, filtering, aggregations), the following columns were selected for indexing:

| Table     | Column          | Reason for Indexing                            |
|-----------|------------------|-----------------------------------------------|
| `users`   | `user_id`        | Used in JOINs and filtering                    |
| `users`   | `email`          | Used in authentication queries (WHERE clause) |
| `bookings`| `user_id`        | Used in JOINs and filtering                    |
| `bookings`| `property_id`    | JOINed with `properties`                      |
| `properties` | `host_id`     | JOINed with `users` (hosts)                   |
| `reviews` | `property_id`    | Frequently joined or filtered                 |

---

## ⚙️ Index Creation (Defined in `database_index.sql`)

Sample `CREATE INDEX` commands:

```sql
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
