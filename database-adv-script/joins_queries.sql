
SELECT b.*,u.* FROM Bookings b INNER JOIN Users u ON b.guest_id = u.user_id;

SELECT p.*,r.* FROM Properties p LEFT JOIN Reviews r ON r.property_id = p.property_id;


SELECT u.*,b.* FROM Users u FULL OUTER JOIN Bookings b ON u.user_id = b.guest_id;