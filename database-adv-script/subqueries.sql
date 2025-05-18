SELECT * FROM Properties p WHERE p.property_id IN (SELECT r.property_id FROM Reviews r GROUP BY r.property_id HAVING AVG(r.rating)>4);

SELECT *
FROM Users u
WHERE (
    SELECT COUNT(*)
    FROM Bookings b
    WHERE b.guest_id = u.user_id
) > 3;