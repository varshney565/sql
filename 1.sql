-- create a database with name 'temp'
CREATE DATABASE temp;
CREATE DATABASE IF NOT EXISTS temp;

-- show the databases
SHOW databases;

-- use that database with name 'temp'
use temp;

-- delete a database
DROP DATABASE practice;



-- Diffeernt datatypes

	-- CHAR --> string(0-255)
	-- VARCHAR --> string(0-255)

		-- for the string "SQL" (3 characters) into both types:
    
		-- CHAR(10) stores: "SQL       " (3 characters + 7 trailing spaces).
		-- VARCHAR(10) stores: "SQL" (3 characters).
			-- It consumes only 5 bytes of space (3 bytes for the text + 2 bytes for the length prefix)
        
	-- TEXT --> string(0-65535)
    
    -- INT
		-- INT 4 bytes
        -- TINYINT 1 byte
        -- SMALLINT 2 byte
        -- MEDIUMINT 3 byte
        -- BIGINT 8 byte
	
    -- FLOAT decimal with precision to 23 digits
    -- DOUBLE decimal with precision 24 to 53 digits
    -- BOOLEAN 0/1
    -- ENUM one of the preset value
    -- DATE and DATETIME
    
    
    
    
		-- CREATE TABLE tickets (
		-- 	ticket_id INT AUTO_INCREMENT PRIMARY KEY,
		-- 	title VARCHAR(255) NOT NULL,
		-- 	priority ENUM('Low', 'Medium', 'High') NOT NULL,
		-- 	status ENUM('Open', 'In Progress', 'Resolved') DEFAULT 'Open',
		--  is_escalated BOOLEAN DEFAULT FALSE,
        --  due_date DATE,   
        --  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
		-- );
    
		
    
		-- INSERT INTO tickets (title, priority, is_escalated, due_date) 
		-- VALUES ('Server Outage', 'High', TRUE, '2026-12-25');

    
		-- SELECT * FROM tickets 
		-- WHERE priority = 'High';

		-- SELECT * FROM tickets 
		-- WHERE is_escalated = TRUE;


		-- Find tickets that are OVERDUE (due before today's date)
		-- SELECT * FROM tickets 
		-- WHERE due_date < CURRENT_DATE();

		-- Find tickets created in a specific date range
		-- SELECT * FROM tickets 
		-- WHERE created_at BETWEEN '2026-09-01 00:00:00' AND '2026-09-30 23:59:59';

    
    
    
