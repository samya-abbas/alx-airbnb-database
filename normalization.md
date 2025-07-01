# 🧼 Normalization Requirements – Airbnb Clone Backend

This document reviews the database design of the **Airbnb Clone Backend** using normalization principles. Normalization ensures data integrity, reduces redundancy, and prevents anomalies in insert, update, and delete operations.

---

## ✅ Normalization Goals

| Normal Form | Requirement |
|-------------|-------------|
| **1NF** | All fields contain atomic (indivisible) values; no repeating groups. |
| **2NF** | Every non-primary-key attribute depends on the whole primary key (no partial dependencies). |
| **3NF** | No transitive dependencies between non-key attributes (non-key should only depend on the primary key). |

---

## 🧩 Normalization Assessment by Table

### 1. User Table

- **Primary Key:** `user_id`
- **Fields:** `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`
- **Constraints:** `email` is unique

| Normal Form | Status | Explanation |
|-------------|--------|-------------|
| 1NF | ✅ | All values are atomic |
| 2NF | ✅ | Single primary key, no partial dependencies |
| 3NF | ✅ | All fields depend on the primary key only |

**Status:** Fully normalized

---

### 2. Property Table

- **Primary Key:** `property_id`
- **Foreign Key:** `host_id → user_id`
- **Fields:** `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`

| Normal Form | Status | Explanation |
|-------------|--------|-------------|
| 1NF | ✅ | Atomic values only |
| 2NF | ✅ | No composite keys; all fields depend on `property_id` |
| 3NF | ✅ | No transitive dependencies |

**Status:** Fully normalized

---

### 3. Booking Table

- **Primary Key:** `booking_id`
- **Foreign Keys:** `property_id → property_id`, `user_id → user_id`
- **Fields:** `start_date`, `end_date`, `total_price`, `status`, `created_at`

| Normal Form | Status | Explanation |
|-------------|--------|-------------|
| 1NF | ✅ | Atomic fields |
| 2NF | ✅ | No composite keys, dependencies are clean |
| 3NF | ✅ | No non-key dependency issues |

**Status:** Fully normalized

---

### 4. Payment Table

- **Primary Key:** `payment_id`
- **Foreign Key:** `booking_id → booking_id`
- **Fields:** `amount`, `payment_date`, `payment_method`

| Normal Form | Status | Explanation |
|-------------|--------|-------------|
| 1NF | ✅ | All fields are atomic |
| 2NF | ✅ | Single primary key structure |
| 3NF | ⚠️ | `amount` may be derived from `Booking.total_price` |

**Note:** `amount` is intentionally retained for flexibility (partial payments, discounts). This is an acceptable case of **controlled denormalization**.

---

### 5. Review Table

- **Primary Key:** `review_id`
- **Foreign Keys:** `property_id → property_id`, `user_id → user_id`
- **Fields:** `rating`, `comment`, `created_at`

| Normal Form | Status | Explanation |
|-------------|--------|-------------|
| 1NF | ✅ | No repeating fields |
| 2NF | ✅ | No partial dependencies |
| 3NF | ✅ | Rating and comments depend only on `review_id` |

**Status:** Fully normalized

---

### 6. Message Table

- **Primary Key:** `message_id`
- **Foreign Keys:** `sender_id → user_id`, `recipient_id → user_id`
- **Fields:** `message_body`, `sent_at`

| Normal Form | Status | Explanation |
|-------------|--------|-------------|
| 1NF | ✅ | All values are atomic |
| 2NF | ✅ | No composite key issues |
| 3NF | ✅ | All attributes depend on `message_id` only |

**Status:** Fully normalized

---

## 📝 Summary

| Table     | 1NF | 2NF | 3NF | Notes |
|-----------|-----|-----|-----|-------|
| **User**     | ✅  | ✅  | ✅  | Fully normalized |
| **Property** | ✅  | ✅  | ✅  | Clean design |
| **Booking**  | ✅  | ✅  | ✅  | Meets all requirements |
| **Payment**  | ✅  | ✅  | ⚠️  | `amount` is denormalized by design |
| **Review**   | ✅  | ✅  | ✅  | No transitive dependency |
| **Message**  | ✅  | ✅  | ✅  | Proper message linking |

---

## ✅ Conclusion

The database schema adheres to the **Third Normal Form (3NF)** in all key areas, with a conscious decision to relax 3NF in the **Payment table** for practical reasons. This ensures:

- Data consistency
- Minimal redundancy
- High scalability and performance

  You can safely use this structure for backend implementation of the Airbnb clone with confidence in its data integrity.
