CREATE INDEX email_idx ON User(email);
CREATE INDEX host_idx ON Properties(host_id); 
CREATE INDEX property_idx ON Bookings(property_id);
CREATE INDEX guest_idx ON Bookings(guest_id);


EXPLAIN ANALYZE
SELECT 
    p.property_id,
    p.name,
    COUNT(b.booking_id) AS total_bookings,
    u.host_id
FROM Properties p
LEFT JOIN Bookings b ON p.property_id = b.property_id
JOIN Users u ON b.guest_id = u.user_id
WHERE u.email LIKE '%@email.com'
  AND (u.host_id IS NULL OR u.host_id IN (SELECT user_id FROM Users WHERE host_id IS NOT NULL))
GROUP BY p.property_id, p.name, u.host_id
ORDER BY total_bookings DESC;