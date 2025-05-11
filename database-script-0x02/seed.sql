INSERT INTO Users (first_name, last_name, email, phone_number, password_hash, role)
VALUES 
  ('Alice', 'Smith', 'alice@example.com', '1234567890', 'hashedpassword1', 'host'),
  ('Bob', 'Johnson', 'bob@example.com', '0987654321', 'hashedpassword2', 'guest'),
  ('Carol', 'Williams', 'carol@example.com', '1122334455', 'hashedpassword3', 'guest');


-- Assume Alice is the host
INSERT INTO Properties (host_id, name, description, location, pricepernight)
SELECT user_id, 'Cozy Cottage', 'A small, charming cottage in the woods.', 'Asheville, NC', 120.00
FROM Users WHERE email = 'alice@example.com';

INSERT INTO Properties (host_id, name, description, location, pricepernight)
SELECT user_id, 'City Apartment', 'Modern apartment in downtown.', 'New York, NY', 200.00
FROM Users WHERE email = 'alice@example.com';


-- Bob books Cozy Cottage
INSERT INTO Bookings (property_id, user_id, start_date, end_date, total_price, status)
SELECT p.property_id, u.user_id, '2025-06-01', '2025-06-05', 480.00, 'confirmed'
FROM Properties p, Users u
WHERE p.name = 'Cozy Cottage' AND u.email = 'bob@example.com';

-- Carol books City Apartment
INSERT INTO Bookings (property_id, user_id, start_date, end_date, total_price, status)
SELECT p.property_id, u.user_id, '2025-06-10', '2025-06-15', 1000.00, 'pending'
FROM Properties p, Users u
WHERE p.name = 'City Apartment' AND u.email = 'carol@example.com';


-- Payment for Bob's booking
INSERT INTO Payments (booking_id, amount, payment_method)
SELECT booking_id, 480.00, 'credit_card'
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
WHERE u.email = 'bob@example.com';

-- Payment for Carol's booking (assume pre-paid)
INSERT INTO Payments (booking_id, amount, payment_method)
SELECT booking_id, 1000.00, 'paypal'
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
WHERE u.email = 'carol@example.com';


-- Bob reviews Cozy Cottage
INSERT INTO Reviews (property_id, user_id, rating, comment)
SELECT p.property_id, u.user_id, 5, 'Amazing place, very cozy and clean!'
FROM Properties p, Users u
WHERE p.name = 'Cozy Cottage' AND u.email = 'bob@example.com';

-- Carol reviews City Apartment
INSERT INTO Reviews (property_id, user_id, rating, comment)
SELECT p.property_id, u.user_id, 4, 'Great location, but a bit noisy at night.'
FROM Properties p, Users u
WHERE p.name = 'City Apartment' AND u.email = 'carol@example.com';


-- Bob sends message to Alice
INSERT INTO Messages (sender_id, recipient_id, message_body)
SELECT s.user_id, r.user_id, 'Hi, I have a question about the check-in time.'
FROM Users s, Users r
WHERE s.email = 'bob@example.com' AND r.email = 'alice@example.com';

-- Alice replies to Bob
INSERT INTO Messages (sender_id, recipient_id, message_body)
SELECT s.user_id, r.user_id, 'Check-in starts at 3 PM. Let me know if you need anything else!'
FROM Users s, Users r
WHERE s.email = 'alice@example.com' AND r.email = 'bob@example.com';
