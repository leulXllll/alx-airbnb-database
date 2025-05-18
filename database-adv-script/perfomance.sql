SELECT b.*,u.*,pro.*,pay.* FROM Bookings b INNER JOIN Users u ON b.guest_id =u.user_id
INNER JOIN Properties pro ON b.property_id = pro.property_id
INNER JOIN Payments pay ON pay.booking_id=b.booking_id;


EXPLAIN SELECT b.*,u.*,pro.*,pay.* FROM Bookings b INNER JOIN Users u ON b.guest_id =u.user_id
INNER JOIN Properties pro ON b.property_id = pro.property_id
LEFT JOIN Payments pay ON pay.booking_id=b.booking_id;

SELECT 
    b.booking_id, b.guest_id, b.property_id, b.date,
    u.user_id, u.name, u.email,
    pro.property_id AS prop_id, pro.name AS prop_name, pro.location,
    pay.payment_id, pay.amount, pay.payment_date
FROM Users u
INNER JOIN Bookings b ON b.guest_id = u.user_id
INNER JOIN Properties pro ON b.property_id = pro.property_id
LEFT JOIN Payments pay ON pay.booking_id = b.booking_id
WHERE u.email LIKE '%@email.com' AND b.date >= '2025-01-01'
ORDER BY b.date;