# NAME: Laura Piedrahita
-- Step 0: Create the database

CREATE DATABASE equestrian;
USE equestrian;

/* Step 1: Create Tables */
-- horses
CREATE TABLE horses(
	horse_id		VARCHAR(255)	PRIMARY KEY,
    name			VARCHAR(255)	UNIQUE,
    gender			VARCHAR(255),
    birth_year		NUMERIC,
    status			VARCHAR(255),
    spendings		DECIMAL(12, 2)	DEFAULT 0,
    barn_id			INT
);

-- barns
CREATE TABLE barns(
	barn_id		INT				PRIMARY KEY		AUTO_INCREMENT,
    name		VARCHAR(255),
    city		VARCHAR(255),
    country		VARCHAR(255),
    capacity	NUMERIC,
    available	NUMERIC,
    CHECK (available <= capacity),
    CHECK (available >= 0)
);

-- shows
CREATE TABLE shows(
	show_id			VARCHAR(255)	PRIMARY KEY,
    city			VARCHAR(255),
    country			VARCHAR(255),
    start_date		DATE,
    end_date		DATE,
    level			VARCHAR(255) 
);

-- schedule
CREATE TABLE schedule(
	schedule_id			INT				PRIMARY KEY		AUTO_INCREMENT,
    horse_id			VARCHAR(255),
    show_id				VARCHAR(255),
    total_classes		INT
);

-- financials
CREATE TABLE financials(
	financial_id		INT				PRIMARY KEY		AUTO_INCREMENT,
    date				TIMESTAMP		DEFAULT NOW(),
    horse_id			VARCHAR(255),
    type				VARCHAR(255),
    amount				DECIMAL(12,2),
    description			VARCHAR(255)
);

-- Step 2: Insert data into tables 
-- INSERT INTO barns
INSERT INTO barns (barn_id, name, city, country, capacity, available) VALUES 
	(1, 'Hidden Farm', 'Ocala','US', 10, 8),
	(2, 'Grand Village', 'Wellington', 'US', 20, 16),
    (3, 'CCC','Bogota', 'Colombia', 5, 3),
    (4, 'Castle Farm', 'Brussels', 'Belgium', 15, 13);

-- INSERT INTO horses
INSERT INTO horses (horse_id, name, gender, birth_year, status, spendings, barn_id) VALUES 
	('USEF 56402', 'Charlie', 'Gelding', 2008, 'Active', 0, 2),
    ('USEF 58674', 'Freedom', 'Mare', 2015, 'Active', 0, 2),
    ('USEF 52587', 'Queen', 'Mare', 2004, 'Retired', 0, 1),
    ('USEF 51299', 'Prince', 'Stallion', 2018, 'Active', 0, 3),
    ('USEF 80850', 'Ranchi', 'Mare', 2010, 'Retired', 0, 4),
    ('USEF 95275', 'Acalix', 'Gelding', 2011, 'Leased', 0, 2),
    ('FEI 1AO10', 'Vivant', 'Gelding', 2014, 'Active', 0, 2),
    ('FEI 10X46', 'Corelli de Mies', 'Stallion', 2011, 'Active', 0, 4),
    ('FEI 10345', 'HH Azur', 'Mare', 2006, 'Retired', 0, 1),
    ('FEI 10217', 'Bubalu VDL', 'Stallion', 2000, 'Retired', 0, 3);

-- INSERT INTO shows
INSERT INTO shows (show_id, city, country, start_date, end_date, level) VALUES
	('WEC49', 'Ocala', 'US', '2023-12-06','2023-12-10', 'CSI3*'),
    ('WEF1', 'Wellington', 'US', '2024-01-10','2024-01-14', 'CSI3*'),
    ('WEF2', 'Wellington', 'US', '2024-01-17','2024-01-21', 'CSI3*'),
    ('WEF3', 'Wellington', 'US', '2024-01-24','2024-01-28', 'CSI4*'),
    ('WEF4', 'Wellington', 'US', '2024-01-31','2024-02-04', 'CSI4*'),
    ('WEF5', 'Wellington', 'US', '2024-02-07','2024-02-11', 'CSI5*'),
    ('WEF6', 'Wellington', 'US', '2024-02-14','2024-02-18', 'CSI3*'),
    ('WEF7', 'Wellington', 'US', '2024-02-21','2024-02-25', 'CSI5*'),
    ('WEF8', 'Wellington', 'US', '2024-02-28','2024-03-03', 'CSIO4*'),
    ('WEF9', 'Wellington', 'US', '2024-03-06','2024-03-10', 'CSI5*'),
    ('WEF10', 'Wellington', 'US', '2024-03-13','2024-03-17', 'CSI4*'),
    ('WEF11', 'Wellington', 'US', '2024-03-20','2024-03-24', 'CSI4*'),
    ('WEF12', 'Wellington', 'US', '2024-03-27','2024-03-31', 'CSI5*'),
    ('MET1', 'Valencia', 'Spain', '2023-11-27','2023-12-03', 'CSI2*'),
    ('MET2', 'Valencia', 'Spain', '2023-12-04','2023-12-10', 'CSI3*'),
    ('MET3', 'Valencia', 'Spain', '2023-12-11','2023-12-17', 'CSI3*');

-- INSERT INTO schedule
INSERT INTO schedule (schedule_id, horse_id, show_id, total_classes) VALUES
	(1, 'USEF 56402', 'WEF1', '3'),
    (2, 'USEF 56402', 'WEF2', '2'),
    (3, 'USEF 56402', 'WEF5', '3'),
    (4, 'USEF 56402', 'WEF6', '2'),
    (5, 'FEI 1AO10', 'WEF2', '3'),
    (6, 'FEI 1AO10', 'WEF4', '3'),
    (7, 'FEI 1AO10', 'WEF6', '3'),
    (8, 'USEF 95275', 'MET3', '4'),
    (9, 'USEF 95275', 'WEC49', '2');

/* Step 3: CREATE VIEWS */
-- Horse's Financials
CREATE VIEW	horse_financials AS
SELECT
	name,
	date,
    type,
    amount,
    description
FROM horses h
JOIN financials r USING (horse_id)
ORDER BY 1;

-- Horse's Schedule
CREATE VIEW horse_schedule AS
SELECT
	horse_id,
    name,
    show_id,
    city,
    country,
	start_date,
    end_date
FROM schedule sc
JOIN shows s USING (show_id)
JOIN horses h USING (horse_id)
ORDER BY 1;

-- Barn's Capacity
CREATE VIEW barns_capacity AS
SELECT
	b.name AS 'barn_name',
    h.name AS 'horse_name',
    city,
    country,
    capacity,
    available
FROM barns b
JOIN horses h USING (barn_id)
ORDER BY 1;


/* Step 4: Stored Procedures */
DELIMITER $$

/* Procedure 1: view_financials */
CREATE PROCEDURE view_financials(IN p_name VARCHAR(255))
BEGIN
	DECLARE v_horse_exists BOOLEAN;
    
    SELECT EXISTS(SELECT horse_id FROM horses WHERE name = p_name) INTO v_horse_exists;
    
    IF v_horse_exists THEN
		SELECT * 
        FROM horse_financials 
        WHERE name = p_name
        ORDER BY date;
	ELSE
		SELECT 'Error: Horse does not exist.' AS message;
    END IF;
END $$

/* Procedure 2: view_schedule */
CREATE PROCEDURE view_schedule(IN p_name VARCHAR(255))
BEGIN
	DECLARE v_horse_exists BOOLEAN;
    
    SELECT EXISTS(SELECT horse_id FROM horses WHERE name = p_name) INTO v_horse_exists;
    
    IF v_horse_exists THEN
		SELECT * 
        FROM horse_schedule 
        WHERE name = p_name
        ORDER BY start_date;
	ELSE
		SELECT 'Error: Horse does not exist.' AS message;
    END IF;
END $$

/* Procedure 3: view_barn */
CREATE PROCEDURE view_barn(IN p_name VARCHAR(255))
BEGIN
    DECLARE v_barn_exists BOOLEAN;
    
    SELECT EXISTS(SELECT barn_id FROM barns WHERE name = p_name) INTO v_barn_exists;
    
    IF v_barn_exists THEN
		SELECT * FROM barns_capacity WHERE barn_name = p_name;
	ELSE
		SELECT 'Error: Barn does not exist.' AS message;
    END IF;
END $$

/* Procedure 4: cancel_show */
CREATE PROCEDURE cancel_show(IN p_id VARCHAR(255))
BEGIN
	DECLARE v_show_exists BOOLEAN;
    
    SELECT EXISTS(SELECT show_id FROM shows WHERE show_id = p_id) INTO v_show_exists;
    
    IF v_show_exists THEN
		DELETE FROM shows WHERE show_id = p_id;
	ELSE
		SELECT 'Error: Show does not exist.' AS message;
    END IF;
END $$

/* Procedure 5: update_horse_status */
CREATE PROCEDURE update_horse_status(IN p_horse_name VARCHAR(255), IN p_horse_status VARCHAR(255))
BEGIN
	DECLARE v_horse_exists BOOLEAN;
    
    SELECT EXISTS(SELECT horse_id FROM horses WHERE name = p_horse_name) INTO v_horse_exists;
    
    IF v_horse_exists THEN
		UPDATE horses SET status = p_horse_status WHERE name = p_horse_name;
	ELSE
		SELECT 'Error: Horse does not exist.' AS message;
    END IF;
END $$

/* Procedure 6: add_transaction */
CREATE PROCEDURE add_transaction(
	IN p_horse_name VARCHAR(255), 
    IN p_type VARCHAR(255), 
	IN p_amount DECIMAL(12,2), 
    IN p_description VARCHAR(255))
BEGIN
	DECLARE v_horse_id VARCHAR(255);
    DECLARE v_horse_exists BOOLEAN;
    
    SELECT horse_id INTO v_horse_id FROM horses WHERE name = p_horse_name;
    SELECT EXISTS(SELECT horse_id FROM horses WHERE name = p_horse_name) INTO v_horse_exists;
    
    IF v_horse_exists THEN
		IF p_type NOT IN ('spending', 'earning') THEN SELECT 'Type has to be either spending or earning.' AS message;
		ELSE
			INSERT INTO financials (horse_id, type, amount, description) 
				VALUES (v_horse_id, p_type, p_amount, p_description);
			IF p_type = 'spending' THEN
				UPDATE horses SET spendings = spendings + p_amount WHERE horse_id = v_horse_id;
			ELSEIF p_type = 'earning' THEN UPDATE horses SET spendings = spendings - p_amount WHERE horse_id = v_horse_id;
			END IF;
		END IF;
	ELSE
		SELECT 'Error: Horse does not exist.' AS message;
    END IF;
END $$

/* Procedure 7: sell_horse */
CREATE PROCEDURE sell_horse (IN p_horse_name VARCHAR(255), IN p_amount DECIMAL(12,2))
BEGIN
	DECLARE v_barn_id VARCHAR(255);
    DECLARE v_horse_exists BOOLEAN;

    SELECT EXISTS(SELECT horse_id FROM horses WHERE name = p_horse_name) INTO v_horse_exists;
    
    IF v_horse_exists THEN
		CALL update_horse_status(p_horse_name, 'Sold');
		
		CALL add_transaction (p_horse_name, 'Earning', p_amount, 'Sale');
		
		SELECT barn_id INTO v_barn_id FROM horses WHERE name = p_horse_name;
		
		UPDATE barns SET available = available + 1 WHERE barn_id = v_barn_id;
		
		UPDATE horses SET barn_id = 0 WHERE name = p_horse_name;
	ELSE
		SELECT 'Error: Horse does not exist.' AS message;
    END IF;
END $$

/* Procedure 8: buy_horse */
CREATE PROCEDURE buy_horse(
	IN p_horse_id VARCHAR(255),
    IN p_horse_name VARCHAR(255),
    IN p_gender VARCHAR(255),
    IN p_birth_year NUMERIC,
    IN p_status VARCHAR(255),
    IN p_horse_price DECIMAL(12, 2),
    IN p_barn_id INT)
BEGIN
	DECLARE v_barn_available BOOLEAN;
    
    SELECT available > 0 INTO v_barn_available FROM barns WHERE barn_id = p_barn_id;
    
    IF v_barn_available THEN
		INSERT INTO horses (horse_id, name, gender, birth_year, status, barn_id) VALUES 
			(p_horse_id, p_horse_name, p_gender, p_birth_year, p_status, p_barn_id);
		
		CALL add_transaction (p_horse_name, 'Spending', p_horse_price, 'Purchase');
		
		UPDATE barns SET available = available - 1 WHERE barn_id = p_barn_id;
	ELSE
		SELECT 'Error: Barn does not exist or has no available space.' AS message;
    END IF;
END$$

/* Procedure 9: transfer_horse */
CREATE PROCEDURE transfer_horse (IN p_horse_name VARCHAR(255), IN p_new_barn_name VARCHAR(255))
BEGIN
    DECLARE v_barn_id INT;
    DECLARE v_new_barn_id INT;
    DECLARE v_horse_exists BOOLEAN;
    DECLARE v_barn_exists BOOLEAN;
    DECLARE v_new_barn_available BOOLEAN;

    SELECT EXISTS(SELECT horse_id FROM horses WHERE name = p_horse_name) INTO v_horse_exists;

    SELECT EXISTS(SELECT barn_id FROM barns WHERE name = p_new_barn_name) INTO v_barn_exists;

    SELECT available > 0 INTO v_new_barn_available FROM barns WHERE name = p_new_barn_name;

    IF v_horse_exists AND v_barn_exists AND v_new_barn_available THEN

        SELECT barn_id INTO v_barn_id FROM horses WHERE name = p_horse_name;
        SELECT barn_id INTO v_new_barn_id FROM barns WHERE name = p_new_barn_name;
        
        UPDATE barns SET available = available + 1 WHERE barn_id = v_barn_id;
        UPDATE barns SET available = available - 1 WHERE barn_id = v_new_barn_id;
        
        UPDATE horses SET barn_id = v_new_barn_id WHERE name = p_horse_name;
    ELSE
        SELECT 'Error: Horse does not exist, barn does not exist, or new barn has no available space.' AS message;
    END IF;
END$$

/*	Procedure 10: show_entry */
CREATE PROCEDURE show_entry (IN p_horse_name VARCHAR(255), IN p_show_id VARCHAR(255), IN p_total_classes INT)
BEGIN
	DECLARE v_availability BOOLEAN;
    DECLARE v_start_date DATE;
    DECLARE v_end_date DATE;
    DECLARE v_horse_id VARCHAR(255);
    DECLARE v_horse_exists BOOLEAN;
    
    SELECT start_date INTO v_start_date FROM shows WHERE show_id = p_show_id;
    SELECT end_date INTO v_end_date FROM shows WHERE show_id = p_show_id;
	SELECT horse_id INTO v_horse_id FROM horses WHERE name = p_horse_name;
    SELECT EXISTS(SELECT horse_id FROM horses WHERE name = p_horse_name) INTO v_horse_exists;
    
	SELECT NOT EXISTS (
		SELECT name
		FROM horse_schedule
		WHERE horse_id = v_horse_id
		AND ( (start_date BETWEEN v_start_date AND v_end_date) OR (end_date BETWEEN v_start_date AND v_end_date))
	) INTO v_availability;

	IF v_horse_exists THEN
		IF v_availability THEN
			INSERT INTO schedule (horse_id, show_id, total_classes) 
			VALUES (v_horse_id, p_show_id, p_total_classes);
		ELSE
			SELECT 'Horse is not available for the selected dates.' AS message;
		END IF;
	ELSE
		SELECT 'Error: Horse does not exist.' AS message;
    END IF;
END$$

/* Procedure 11: deceased_horse */
CREATE PROCEDURE deceased_horse (IN p_horse_name VARCHAR(255))
BEGIN
	DECLARE v_barn_id VARCHAR(255);
    DECLARE v_horse_exists BOOLEAN;

    SELECT EXISTS(SELECT horse_id FROM horses WHERE name = p_horse_name) INTO v_horse_exists;
    
    IF v_horse_exists THEN
		CALL update_horse_status(p_horse_name, 'Deceased');
		
		SELECT barn_id INTO v_barn_id FROM horses WHERE name = p_horse_name;
		
		UPDATE barns SET available = available + 1 WHERE barn_id = v_barn_id;
		
		UPDATE horses SET barn_id = 0 WHERE name = p_horse_name;
	ELSE
		SELECT 'Error: Horse does not exist.' AS message;
    END IF;
END $$
DELIMITER ;

-- Add Financials with add_tansaction
CALL add_transaction ('Bubalu VDL', 'Spending', 120000, 'Purchase');
CALL add_transaction ('HH Azur', 'Spending', 1200000, 'Purchase');
CALL add_transaction ('Corelli de Mies', 'Spending', 220000, 'Purchase');
CALL add_transaction ('Vivant', 'Spending', 20000, 'Purchase');
CALL add_transaction ('Charlie', 'Spending', 350000, 'Purchase');
CALL add_transaction ('Acalix', 'Spending', 600000, 'Purchase');
CALL add_transaction ('Freedom', 'Spending', 75000, 'Purchase');
CALL add_transaction ('HH Azur', 'Earning', 10000, 'Prize Money');
CALL add_transaction ('Charlie', 'Earning', 1000, 'Prize Money');
CALL add_transaction ('Corelli de Mies', 'Earning', 500000, 'Prize Money');
CALL add_transaction ('Prince', 'Earning', 15000, 'Breeding');
CALL add_transaction ('Freedom', 'Spending', 7500, 'Board');
CALL add_transaction ('Freedom', 'Spending', 3500, 'Training');
CALL add_transaction ('Freedom', 'Spending', 4023.56, 'Vet');

