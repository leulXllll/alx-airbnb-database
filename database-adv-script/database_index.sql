CREATE INDEX email_idx ON User(email);
CREATE INDEX host_id_idx ON User(email);
CREATE INDEX property_idx ON Bookings(property_id);
CREATE INDEX guest_idx ON Bookings(guest_id);