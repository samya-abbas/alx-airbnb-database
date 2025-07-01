# 🏠 Airbnb Clone Backend – Entity and Relationship Overview

This document outlines the key **entities**, their **attributes**, and the **relationships** used in designing the backend database for the Airbnb Clone project. The structure ensures support for user management, property listings, booking systems, payments, reviews, and messaging.

---

## 🗂️ Entities and Attributes

### 1. **User**
| Attribute       | Type      | Constraints                                |
|----------------|-----------|--------------------------------------------|
| user_id        | UUID      | Primary Key, Indexed                       |
| first_name     | VARCHAR   | NOT NULL                                   |
| last_name      | VARCHAR   | NOT NULL                                   |
| email          | VARCHAR   | UNIQUE, NOT NULL                           |
| password_hash  | VARCHAR   | NOT NULL                                   |
| phone_number   | VARCHAR   | NULL (Optional)                            |
| role           | ENUM      | guest, host, admin – NOT NULL              |
| created_at     | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                  |

---

### 2. **Property**
| Attribute       | Type      | Constraints                                |
|----------------|-----------|--------------------------------------------|
| property_id     | UUID      | Primary Key, Indexed                       |
| host_id         | UUID      | Foreign Key → `User(user_id)`              |
| name            | VARCHAR   | NOT NULL                                   |
| description     | TEXT      | NOT NULL                                   |
| location        | VARCHAR   | NOT NULL                                   |
| pricepernight   | DECIMAL   | NOT NULL                                   |
| created_at      | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                  |
| updated_at      | TIMESTAMP | Auto-updated on change                     |

---

### 3. **Booking**
| Attribute       | Type      | Constraints                                |
|----------------|-----------|--------------------------------------------|
| booking_id      | UUID      | Primary Key, Indexed                       |
| property_id     | UUID      | Foreign Key → `Property(property_id)`       |
| user_id         | UUID      | Foreign Key → `User(user_id)`              |
| start_date      | DATE      | NOT NULL                                   |
| end_date        | DATE      | NOT NULL                                   |
| total_price     | DECIMAL   | NOT NULL                                   |
| status          | ENUM      | pending, confirmed, canceled               |
| created_at      | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                  |

---

### 4. **Payment**
| Attribute       | Type      | Constraints                                |
|----------------|-----------|--------------------------------------------|
| payment_id      | UUID      | Primary Key, Indexed                       |
| booking_id      | UUID      | Foreign Key → `Booking(booking_id)`         |
| amount          | DECIMAL   | NOT NULL                                   |
| payment_date    | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                  |
| payment_method  | ENUM      | credit_card, paypal, stripe                |

---

### 5. **Review**
| Attribute       | Type      | Constraints                                |
|----------------|-----------|--------------------------------------------|
| review_id       | UUID      | Primary Key, Indexed                       |
| property_id     | UUID      | Foreign Key → `Property(property_id)`       |
| user_id         | UUID      | Foreign Key → `User(user_id)`              |
| rating          | INTEGER   | BETWEEN 1 AND 5                            |
| comment         | TEXT      | NOT NULL                                   |
| created_at      | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                  |

---

### 6. **Message**
| Attribute       | Type      | Constraints                                |
|----------------|-----------|--------------------------------------------|
| message_id      | UUID      | Primary Key, Indexed                       |
| sender_id       | UUID      | Foreign Key → `User(user_id)`              |
| recipient_id    | UUID      | Foreign Key → `User(user_id)`              |
| message_body    | TEXT      | NOT NULL                                   |
| sent_at         | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                  |

---

## 🔗 Relationships Between Entities

| Entity A   | Relationship Type | Entity B   | Description                                         |
|------------|-------------------|------------|-----------------------------------------------------|
| User       | 1-to-Many         | Property   | A host (user) can own multiple properties           |
| User       | 1-to-Many         | Booking    | A user can make multiple bookings                   |
| Property   | 1-to-Many         | Booking    | A property can be booked multiple times             |
| Booking    | 1-to-1            | Payment    | Each booking has a corresponding payment            |
| Property   | 1-to-Many         | Review     | Each property can have multiple reviews             |
| User       | 1-to-Many         | Review     | Users can write multiple reviews                    |
| User       | Many-to-Many      | Message    | Users can send and receive multiple messages        |

---

## ✅ Notes

- **All UUID primary keys** are indexed for performance.
- **Foreign key constraints** ensure referential integrity across tables.
- **ENUMs** are used to enforce valid status types and roles.
- Indexes on fields like `email`, `property_id`, and `booking_id` enhance query efficiency.

---