CREATE TABLE Bookings (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL,
    guest_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (guest_id) REFERENCES Users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_properties FOREIGN KEY (property_id) REFERENCES Properties(property_id) ON DELETE CASCADE ON UPDATE CASCADE
) PARTITION BY RANGE (start_date);

CREATE TABLE Bookings_2023 PARTITION OF Bookings
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Bookings_2024 PARTITION OF Bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE Bookings_2025 PARTITION OF Bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE Bookings_2026 PARTITION OF Bookings
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

CREATE TABLE Bookings_default PARTITION OF Bookings DEFAULT;

CREATE INDEX idx_bookings_2023_start_date ON Bookings_2023(start_date);
CREATE INDEX idx_bookings_2024_start_date ON Bookings_2024(start_date);
CREATE INDEX idx_bookings_2025_start_date ON Bookings_2025(start_date);
CREATE INDEX idx_bookings_2026_start_date ON Bookings_2026(start_date);
CREATE INDEX idx_bookings_default_start_date ON Bookings_default(start_date);


-- Query 1: Fetch bookings within a specific date range (e.g., July 2024)
EXPLAIN ANALYZE
SELECT * 
FROM Bookings 
WHERE start_date BETWEEN '2024-07-01' AND '2024-07-31';

-- Query 2: Fetch bookings for a specific property in 2024
EXPLAIN ANALYZE
SELECT * 
FROM Bookings 
WHERE start_date >= '2024-01-01' 
  AND start_date < '2025-01-01' 
  AND property_id = '550e8400-e29b-41d4-a716-446655440000';

-- Query 3: Aggregate total bookings by status for 2025
EXPLAIN ANALYZE
SELECT status, COUNT(*) 
FROM Bookings 
WHERE start_date >= '2025-01-01' 
  AND start_date < '2026-01-01' 
GROUP BY status;