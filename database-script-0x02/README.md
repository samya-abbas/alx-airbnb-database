# 📥 Airbnb Database Sample Data Seeder

`sample_data.sql` populates the **Airbnb Clone** schema with realistic demo records—users, properties, bookings, payments, reviews, and messages—so you can test the backend instantly.

---

## 🎯 What’s Included

| Table      | Rows | Highlights |
|------------|------|------------|
| **user**       | 5  | 2 hosts, 2 guests, 1 admin (UUID primary keys) |
| **property**   | 3  | Listings in Oxford, London, and Brighton |
| **booking**    | 3  | Overlapping hosts/guests with pending & confirmed states |
| **payment**    | 2  | Matches confirmed bookings; different payment methods |
| **review**     | 2  | Star ratings and comments tied to completed stays |
| **message**    | 2  | Guest ↔ host chat samples |

> All UUIDs are hard‑coded to guarantee foreign‑key integrity right out of the box.

---

## 🚀 Quick Start

1. **Load the schema** (if you haven’t already):

   ```bash
   mysql -u <user> -p < schema.sql
