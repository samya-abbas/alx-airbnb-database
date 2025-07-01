/* ----------------------------------------------------------
   Airbnb Clone – Core Schema (MySQL 8)
   ---------------------------------------------------------- */

CREATE DATABASE IF NOT EXISTS airbnb_clone;
USE airbnb_clone;

/* ================= 1. USER ================= */
CREATE TABLE user (
  user_id        CHAR(36)     PRIMARY KEY,              -- UUID
  first_name     VARCHAR(255) NOT NULL,
  last_name      VARCHAR(255) NOT NULL,
  email          VARCHAR(255) NOT NULL UNIQUE,
  password_hash  VARCHAR(255) NOT NULL,
  phone_number   VARCHAR(50),
  role           ENUM('guest','host','admin') NOT NULL,
  created_at     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- Index for quick look‑up by email (unique already).
CREATE INDEX idx_user_email ON user(email);

/* ================= 2. PROPERTY ================= */
CREATE TABLE property (
  property_id    CHAR(36) PRIMARY KEY,
  host_id        CHAR(36) NOT NULL,
  name           VARCHAR(255) NOT NULL,
  description    TEXT        NOT NULL,
  location       VARCHAR(255) NOT NULL,
  pricepernight  DECIMAL(10,2) NOT NULL,
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT fk_property_host  FOREIGN KEY (host_id) REFERENCES user(user_id)
);

CREATE INDEX idx_property_host_id ON property(host_id);

/* ================= 3. BOOKING ================= */
CREATE TABLE booking (
  booking_id     CHAR(36) PRIMARY KEY,
  property_id    CHAR(36) NOT NULL,
  user_id        CHAR(36) NOT NULL,
  start_date     DATE      NOT NULL,
  end_date       DATE      NOT NULL,
  total_price    DECIMAL(10,2) NOT NULL,
  status         ENUM('pending','confirmed','canceled') DEFAULT 'pending',
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES property(property_id),
  CONSTRAINT fk_booking_user     FOREIGN KEY (user_id)    REFERENCES user(user_id)
);

CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_booking_user_id     ON booking(user_id);

/* ================= 4. PAYMENT ================= */
CREATE TABLE payment (
  payment_id     CHAR(36) PRIMARY KEY,
  booking_id     CHAR(36) NOT NULL,
  amount         DECIMAL(10,2) NOT NULL,
  payment_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method ENUM('credit_card','paypal','stripe') NOT NULL,
  CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
);

CREATE INDEX idx_payment_booking_id ON payment(booking_id);

/* ================= 5. REVIEW ================= */
CREATE TABLE review (
  review_id      CHAR(36) PRIMARY KEY,
  property_id    CHAR(36) NOT NULL,
  user_id        CHAR(36) NOT NULL,
  rating         TINYINT  NOT NULL CHECK (rating BETWEEN 1 AND 5),
  comment        TEXT     NOT NULL,
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES property(property_id),
  CONSTRAINT fk_review_user     FOREIGN KEY (user_id)    REFERENCES user(user_id)
);

CREATE INDEX idx_review_property_id ON review(property_id);
CREATE INDEX idx_review_user_id     ON review(user_id);

/* ================= 6. MESSAGE ================= */
CREATE TABLE message (
  message_id     CHAR(36) PRIMARY KEY,
  sender_id      CHAR(36) NOT NULL,
  recipient_id   CHAR(36) NOT NULL,
  message_body   TEXT     NOT NULL,
  sent_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_message_sender    FOREIGN KEY (sender_id)    REFERENCES user(user_id),
  CONSTRAINT fk_message_recipient FOREIGN KEY (recipient_id) REFERENCES user(user_id)
);

CREATE INDEX idx_msg_sender_id    ON message(sender_id);
CREATE INDEX idx_msg_recipient_id ON message(recipient_id);
