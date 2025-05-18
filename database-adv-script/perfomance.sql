SELECT b.*,u.*,pro.*,pay.* FROM Bookings b INNER JOIN Users u ON b.guest_id =u.user_id
INNER JOIN Properties pro ON b.property_id = pro.property_id
INNER JOIN Payments pay ON pay.booking_id=b.booking_id;


EXPLAIN SELECT b.*,u.*,pro.*,pay.* FROM Bookings b INNER JOIN Users u ON b.guest_id =u.user_id
INNER JOIN Properties pro ON b.property_id = pro.property_id
LEFT JOIN Payments pay ON pay.booking_id=b.booking_id;


