# 🏠 ALX Airbnb Database Schema

This folder contains the SQL and documentation for an Airbnb‑style platform.  
The schema is **normalized (3 NF)**, enforces referential integrity, and uses indexes and UUIDs for scalability.

---

## 📂 File Structure

| File | Purpose |
|------|---------|
| `schema.sql` | All `CREATE TABLE` statements, foreign keys, constraints, and indexes |
| `README.md`  | Human‑readable overview of the schema, relationships, and design choices |

---

## 📄 Table Overview

### 1. **User**

| Key Facts | Details |
|-----------|---------|
| Primary Key | `user_id` (`UUID`) |
| Important Columns | `email` (unique, indexed), `role` (`ENUM`: `guest` \| `host` \| `admin`) |
| Purpose | Stores every account: guests, hosts, and admins |

### 2. **Property**

| Key Facts | Details |
|-----------|---------|
| Primary Key | `property_id` (`UUID`) |
| Foreign Key | `host_id → user.user_id` |
| Notable Columns | `location`, `pricepernight`, timestamps |
| Indexes | `host_id` for quick “all listings by host” queries |

### 3. **Booking**

| Key Facts | Details |
|-----------|---------|
| Primary Key | `booking_id` (`UUID`) |
| Foreign Keys | `property_id → property.property_id` <br> `user_id → user.user_id` |
| Tracks | Start/end dates, `total_price`, `status` (`pending`, `confirmed`, `canceled`) |
| Indexes | `property_id`, `user_id` to speed up lookups |

### 4. **Payment**

| Key Facts | Details |
|-----------|---------|
| Primary Key | `payment_id` (`UUID`) |
| Foreign Key | `booking_id → booking.booking_id` |
| Columns | `amount`, `payment_method` (`credit_card`, `paypal`, `stripe`), `payment_date` |
| Note | `amount` stored for flexibility (partial or adjusted payments) |

### 5. **Review**

| Key Facts | Details |
|-----------|---------|
| Primary Key | `review_id` (`UUID`) |
| Foreign Keys | `property_id`, `user_id` |
| Columns | `rating` (1–5), `comment`, `created_at` |

### 6. **Message**

| Key Facts | Details |
|-----------|---------|
| Primary Key | `message_id` (`UUID`) |
| Foreign Keys | `sender_id`, `recipient_id` (both → `user.user_id`) |
| Columns | `message_body`, `sent_at` |
| Purpose | Direct communication between guests and hosts |

---

## 🧠 Design Principles

| Principle | Implementation |
|-----------|----------------|
| **Third Normal Form (3 NF)** | No partial or transitive dependencies; all tables reviewed for redundancy |
| **Foreign Keys** | Maintain referential integrity between Users, Properties, Bookings, Payments, etc. |
| **Indexes** | Added to columns frequently used in `JOIN`/filter operations (`email`, `host_id`, `property_id`, `user_id`) |
| **UUIDs** | Universally unique identifiers support distributed systems and data sharding |
| **Controlled Denormalization** | `Payment.amount` kept for real‑world flexibility (refunds, discounts) |

---

## 🚀 Getting Started

```bash
# Create database and load schema (MySQL)
mysql -u <user> -p < schema.sql


## 🤝 Contributing
Pull requests are welcome. Please open an issue first to discuss major changes.