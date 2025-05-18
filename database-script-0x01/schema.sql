    CREATE TYPE ROLES AS ENUM('host','guest','admin');
    CREATE TYPE STATUS AS ENUM('pending','confirmed','canceled');
    CREATE TYPE PAYMENT_METHOD AS ENUM ('credit_card', 'paypal', 'stripe');

    CREATE TABLE Users(
        user_id UUID PRIMARY KEY  DEFAULT gen_random_uuid() NOT NULL,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255) NOT NULL,
        email VARCHAR(200) UNIQUE NOT NULL,
        phone_number VARCHAR(50) NOT NULL,
        password_hash VARCHAR(255) NOT NULL,
        role ROLES NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE Properties(
        property_id UUID PRIMARY KEY  DEFAULT gen_random_uuid() NOT NULL,
        host_id UUID NOT NULL,
        name VARCHAR(255) NOT NULL,
        description TEXT  NOT NULL,
        location VARCHAR(255) NOT NULL,
        pricepernight DECIMAL(10,2) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

        CONSTRAINT fk_host
            FOREIGN KEY (host_id) REFERENCES Users(user_id)
            ON DELETE CASCADE 
            ON UPDATE CASCADE
    );


    CREATE TABLE Bookings(
        
        booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        property_id UUID NOT NULL,
        guest_id UUID NOT NULL,
        start_date DATE NOT NULL,
        end_date DATE NOT NULL,
        total_price DECIMAL(10,2) NOT NULL,
        status STATUS NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

        CONSTRAINT fk_user 
        FOREIGN KEY (guest_id) REFERENCES Users(user_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,

        CONSTRAINT fk_properties 
        FOREIGN KEY (property_id) REFERENCES Properties(property_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
    );

    CREATE TABLE Payments(
        
        payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        booking_id UUID NOT NULL,
        amount DECIMAL(10,2) NOT NULL,
        payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        payment_method PAYMENT_METHOD NOT NULL,

        CONSTRAINT fk_booking 
        FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    );

    CREATE TABLE Reviews(
        
        review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        property_id UUID NOT NULL,
        user_id UUID NOT NULL,
        rating  INTEGER NOT NULL,
        comment  TEXT NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

        CONSTRAINT validate_rating CHECK (rating BETWEEN 1 AND 5),

        CONSTRAINT fk_userid
        FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

        CONSTRAINT fk_property
        FOREIGN KEY (property_id) REFERENCES Properties(property_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    );

    CREATE TABLE Messages(
        
        message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        recipient_id UUID NOT NULL,
        sender_id UUID NOT NULL,
        message_body TEXT NOT NULL,
        sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

        CONSTRAINT Fk_sender
        FOREIGN KEY (sender_id) REFERENCES Users(user_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,

        CONSTRAINT Fk_receiver
        FOREIGN KEY (recipient_id) REFERENCES Users(user_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
    );

    CREATE INDEX idx_email ON Users(email);
    CREATE INDEX idx_property_id ON Bookings(property_id);
    CREATE INDEX idx_booking_id ON Payments(booking_id);