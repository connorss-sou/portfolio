/*
Created by Zixu Liang and Sean Connors
Full SQL script for f21_catchOfTheDay certain table and view/trigger/function/procedure.
Also populate the tables with some data.
Tables: contrib, contrib_group, location, catch_record, fishery, technique, and fish
View: Researcher View, Contributor View
Trigger: Data Validation before insert, Log for joining and leaving group
Function: Find the total amount of fish caught at a given location, Best place to catch a fish
Procedure: Find the top three locations for a contributor, Largest fish caught location

*/

-- Set to use f21_catchOfTheDay
use f21_catchOfTheDay;

-- Create table for group
Drop table if exists contrib_group;
	Create Table contrib_group (
		id_group int primary key,
        group_name varchar(20)
	);

-- Create table for contributor
Drop table if exists contributor;
	Create Table contributor (
         id_contrib int,
         contrib_name varchar(20) not null,
         dob date,
         phone varchar(20),
         id_group int
    );
    
-- Create primary key for contributor
    Alter Table contributor
   Add Constraint contributor_pk
   Primary Key (id_contrib);
   
-- Create foreign key for contributor
	Alter Table contributor
   Add Constraint contributor_fk
   Foreign Key (id_group)
   References contrib_group(id_group);
   
/* Populate contrib_group table with data */  
Insert Into contrib_group (id_group, group_name) Values (1, 'Researcher');
Insert Into contrib_group (id_group, group_name) Values (2, 'Oregon');
Insert Into contrib_group (id_group, group_name) Values (3, 'Rhode Island');
Insert Into contrib_group (id_group, group_name) Values (4, 'Alaska');
Insert Into contrib_group (id_group, group_name) Values (5, 'Saltwater');

 
-- Turn off foreign key checks, so we can input employees in any order. 
SET FOREIGN_KEY_CHECKS = 0;

/* Populate contributor table with data */
Insert Into contributor (id_contrib, contrib_name, dob, phone, id_group) Values (1, 'Sean Connors', '2000-09-09', null, 2);
Insert Into contributor (id_contrib, contrib_name, dob, phone, id_group) Values (2, 'Zixu Liang', '1995-07-07', null, 3);
Insert Into contributor (id_contrib, contrib_name, dob, phone, id_group) Values (3, 'Anthony Wu', '1996-05-05', null, 3);
Insert Into contributor (id_contrib, contrib_name, dob, phone, id_group) Values (4, 'Bob Fisher', '1990-06-06', '792-424-7123', 1);
Insert Into contributor (id_contrib, contrib_name, dob, phone, id_group) Values (5, 'Patrick Fish', '2005-04-04', '541-555-4343', 4);
Insert Into contributor (id_contrib, contrib_name, dob, phone, id_group) Values (6, 'Peter Nordquist', '2005-10-10', '541-222-2222', 2);


-- Create table for location
Drop table if exists location;
	Create Table location (
		id_location int primary key,
        location_name varchar(20) not null,
        water_type enum('River', 'Lake', 'Saltwater')
	);

-- Create table for catch_record
Drop table if exists catch_record;
	Create Table catch_record (
         id_record int,
         id_location int,
         id_person int,
         id_fish int not null,
         id_technique int not null,
         weight int,
         catch_date date not null,
         primary key(id_record, id_location, id_person)
    );
    
-- Create Table for fishery
Drop table if exists fishery;
	Create Table fishery (
		id_fish int,
        id_location int,
        all_year bool not null,
        summer bool not null,
        winter bool not null,
        spring bool not null,
        fall bool not null,
        primary key (id_fish, id_location)
	);
    
/* Alter and add primary key for catch_record for id_record (This was a later change) */
Alter Table catch_record
Add primary key (id_record);

/* Altering the table to include foreign key (Running this after inserting all the data for the tables) */
-- Create foreign key for catch_record
	Alter Table catch_record
   Add Constraint catch_record_loc_fk
   Foreign Key (id_location)
   References location(id_location);
   
	Alter Table catch_record
   Add Constraint catch_record_per_fk
   Foreign Key (id_person)
   References contributor(id_contrib);
   
	Alter Table catch_record
   Add Constraint catch_record_fish_fk
   Foreign Key (id_fish)
   References fish(id_fish);
   
	Alter Table catch_record
   Add Constraint catch_record_technique_fk
   Foreign Key (id_technique)
   References technique(id_technique);
   
/* Altering the table to include foreign key (Running this after inserting all the data for the tables) */
-- Create foreign key for fishery
	Alter Table fishery
   Add Constraint fishery_loc_fk
   Foreign Key (id_location)
   References location(id_location);
   
	Alter Table fishery
   Add Constraint fishery_fish_fk
   Foreign Key (id_fish)
   References fish(id_fish);
    
/* Populate location table with data */  
Insert Into location (id_location, location_name, water_type) Values (1, 'Misquamicut Beach', 'Saltwater');
Insert Into location (id_location, location_name, water_type) Values (2, 'Kanektok River', 'River');
Insert Into location (id_location, location_name, water_type) Values (3, 'Rogue River', 'River');
Insert Into location (id_location, location_name, water_type) Values (4, 'Illinois River', 'River');
Insert Into location (id_location, location_name, water_type) Values (5, 'Elk River', 'River');
Insert Into location (id_location, location_name, water_type) Values (6, 'Applegate River', 'River');
Insert Into location (id_location, location_name, water_type) Values (7, 'Rogue Lake', 'Lake');
Insert Into location (id_location, location_name, water_type) Values (8, 'Galesville Reservoir', 'Lake');
Insert Into location (id_location, location_name, water_type) Values (9, 'Lost Creek Lake', 'Lake');
Insert Into location (id_location, location_name, water_type) Values (10, 'Lake Selmac', 'Lake');
Insert Into location (id_location, location_name, water_type) Values (11, 'Depot Bay', 'Saltwater');
Insert Into location (id_location, location_name, water_type) Values (12, 'Sunset Bay', 'Saltwater');
Insert Into location (id_location, location_name, water_type) Values (13, 'Port Orford', 'Saltwater');
Insert Into location (id_location, location_name, water_type) Values (14, 'Brookings', 'Saltwater');

-- My fish caught in Rhode Island
Insert Into fish values (12, 'Sand Shark', 'Saltwater', 25);
Insert Into fish values (13, 'Porgy', 'Saltwater', 10);

/* Populate Fishery table with data */
Insert Into fishery (id_fish, id_location, all_year, summer, winter, spring, fall) Values (1, 4, false, false, true, true, false);
Insert Into fishery (id_fish, id_location, all_year, summer, winter, spring, fall) Values (2, 3, false, true, false, true, true);
Insert Into fishery (id_fish, id_location, all_year, summer, winter, spring, fall) Values (4, 9, true, true, true, true, true);
Insert Into fishery (id_fish, id_location, all_year, summer, winter, spring, fall) Values (9, 13, false, false, true, true, false);
Insert Into fishery (id_fish, id_location, all_year, summer, winter, spring, fall) Values (7, 12, true, true, true, true, true);
Insert Into fishery (id_fish, id_location, all_year, summer, winter, spring, fall) Values (3, 3, false, false, false, false, true);
Insert Into fishery (id_fish, id_location, all_year, summer, winter, spring, fall) Values (5, 10, true, true, true, true, true);
Insert Into fishery (id_fish, id_location, all_year, summer, winter, spring, fall) Values (2, 5, false, false, true, false, true);
Insert Into fishery (id_fish, id_location, all_year, summer, winter, spring, fall) Values (1, 3, true, true, true, true, true);
Insert Into fishery (id_fish, id_location, all_year, summer, winter, spring, fall) Values (12, 1, true, true, true, true, true);
Insert Into fishery (id_fish, id_location, all_year, summer, winter, spring, fall) Values (13, 1, true, true, true, true, true);

/* Populate catch_record table with data */
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(1, 4, 1, 1, 1, 15, '2021-02-15');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(2, 13, 2, 7, 2, 5, '2021-01-15');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(3, 3, 5, 3, 2, 10, '2021-11-10');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(4, 8, 3, 4, 3, 3, '2021-08-10');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(5, 5, 4, 2, 1, 13, '2021-11-05');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(6, 10, 1, 6, 1, 2, '2021-09-15');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(7, 3, 1, 1, 1, 5, '2021-09-02');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(8, 1, 2, 12, 3, 7, '2016-11-14');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(9, 1, 2, 13, 3, 4, '2016-06-08');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(10, 3, 6, 3, 2, 10, '2021-06-28');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(11, 3, 6, 2, 2, 13, '2021-08-05');
    
/* Added records into the table to provide a better test */
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(12, 4, 6, 1, 2, 13, '2021-02-06');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(13, 4, 6, 1, 2, 11, '2021-02-06');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(14, 4, 6, 1, 2, 16, '2021-02-06');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(15, 4, 6, 1, 2, 6, '2021-02-06');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(16, 1, 6, 13, 2, 15, '2021-02-06');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(17, 1, 6, 12, 2, 6, '2021-02-06');
Insert Into catch_record (id_record, id_location, id_person, id_fish, id_technique, weight, catch_date) Values
	(18, 1, 6, 12, 2, 9, '2021-02-06');
    
-- Fish (ID_location, fish_name, water_type, possible_weight)
-- Technique (ID_technique, technique_name, difficulty)

CREATE TABLE fish(
-- This table is for fish, and contains the id of the fish, the fish name, 
-- the water type, and the possible weight the fish can reach
	id_fish INT(2) NOT NULL,
	fish_name VARCHAR(14),
	water_type VARCHAR(14),
    possible_weight INT(2)
);

CREATE TABLE technique(
-- This table is for the technique used to catch the fish.
-- It contains the id of the technique, the name, and the difficulty
	id_technique INT(2) NOT NULL,
	technique_name VARCHAR(14),
	difficulty VARCHAR(14)
);

ALTER TABLE fish
-- This lists the primary key of the fish table to be the id of the fish.
   ADD CONSTRAINT fish_pk
   PRIMARY KEY (id_fish);

ALTER TABLE technique
-- This lists the technique primary key as the id of the technique
   ADD CONSTRAINT technique_pk
   PRIMARY KEY (id_technique);
   
-- Inserts valies into the fish table   
INSERT INTO fish VALUES (01, 'Steelhead', 'River', 25);
INSERT INTO fish VALUES (02, 'Chinook Salmon', 'River', 99);
INSERT INTO fish VALUES (03, 'Coho Salmon', 'River', 25);
INSERT INTO fish VALUES (04, 'Bass', 'Lake', 10);
INSERT INTO fish VALUES (05, 'Bluegill', 'Lake', 3);
INSERT INTO fish VALUES (06, 'Crappie', 'Lake', 4);
INSERT INTO fish VALUES (07, 'Black Rockfish', 'Saltwater', 10);
INSERT INTO fish VALUES (08, 'Blue Rockfish', 'Saltwater', 10);
INSERT INTO fish VALUES (09, 'Lingcod', 'Saltwater', 30);
INSERT INTO fish VALUES (10, 'Cabizon', 'Saltwater', 20);
INSERT INTO fish VALUES (11, 'Greenling', 'Saltwater', 10);

-- Inserts valies into the technique table   
INSERT INTO technique VALUES (01, 'Fly Fishing', 'Hard');
INSERT INTO technique VALUES (02, 'Lure', 'Medium');
INSERT INTO technique VALUES (03, 'Bait', 'Easy');
INSERT INTO technique VALUES (04, 'Live Bait', 'Easy');
INSERT INTO technique VALUES (05, 'Trolling', 'Easy');
INSERT INTO technique VALUES (06, 'Top Water', 'Hard');

-- Researcher View
Drop View researcher_view;
-- A view with location name, the number of fish at that location for the researcher
Create view researcher_view as
	Select location_name as "Location", count(id_fish) as "Fish_Caught" from catch_record c join location l on c.id_location = l.id_location group by location_name;

-- Contributor view declaration
CREATE VIEW contributor_view
AS
-- This gives all of the information the contributor might need.
-- On top of this, the group id is provided.
-- This way in html/php a group may be selected from the view to furfill the contributor part of the view.
SELECT location_name, contrib_name, fish_name, technique_name, weight, catch_date, id_group
FROM catch_record
-- The catch record is joined with all of these to provied the names of each point of interest rather than just the id's.
JOIN location ON catch_record.id_location = location.id_location
JOIN contributor ON catch_record.id_person = contributor.id_contrib
JOIN fish ON catch_record.id_fish = fish.id_fish
JOIN technique ON catch_record.id_technique = technique.id_technique;

-- Trigger for data validation
Delimiter //
create trigger f21_catchOfTheDay.catch_record_BEFORE_INSERT
before insert on catch_record 
for each row
begin
	-- Declare variables for use
    Declare season_check bool;
    Declare location_check int;
    
    -- Check to see if there is a record for the given location and fish id
    Select count(id_location) into location_check from fishery where New.id_Fish = id_fish and New.id_location = id_location;
    
    -- Season check, if between June through August, it is considered Summer
    -- March through May is spring, September through November is Fall
    -- Otherwise it should be Winter
	IF month(NEW.catch_date) > 5 and month(NEW.catch_date) < 9 then
		-- Check to see if the given fish and location have that season set as true
        Select summer into season_check from fishery where New.id_fish = id_fish and New.id_location = id_location;
	ELSEIF month(NEW.catch_date) > 2 and month(NEW.catch_date) < 6 then
		Select spring into season_check from fishery where New.id_fish = id_fish and New.id_location = id_location;
	Elseif month(New.catch_date) > 8 and month(New.catch_date) < 12 then
		Select fall into season_check from fishery where New.id_fish = id_fish and New.id_location = id_location;
	Else
		Select winter into season_check from fishery where New.id_fish = id_fish and New.id_location = id_location;
	End if;
    
    -- Check if there is an entry for the given location and fish id
    If location_check = 0 then		
		-- raise SIGNAL with descriptive error message text, which prevents insertion from happening
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Location mismatach!';
	Elseif season_check = False then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Season mismatach!';
	END IF;
END; //
Delimiter ;

Delimiter //
CREATE DEFINER=current_user TRIGGER `f21_catchOfTheDay`.`update_group_trigger` AFTER UPDATE ON `contributor` FOR EACH ROW
BEGIN
    -- This trigger first tests to see if the new id for the group is NULL
    -- This would tell us that the contributor is being removed from the group.
    IF NEW.id_group IS NULL THEN
        -- If the user is being removed from the group we write in the log the corresponding details.
        -- The boolean for a deletion is selected, and null is given in place for the new group id.
        -- We also provide the date of the change.
        INSERT INTO contrib_group_log
        VALUES (false, true, NEW.id_contrib, NULL, NOW());
    -- Next we test if the id for the group is not equal assuming it is NOT NULL.
    -- This would imply that contributor is being moved to another group.
    -- We record the corresponding information just like above but with the boolean for a change selected.
    ELSEIF NEW.id_group != OLD.id_group THEN
        INSERT INTO contrib_group_log
        VALUES (true, false, NEW.id_contrib, NEW.id_group, NOW());
    -- If there is no difference in the id of the group from before or after, then an error will be issued.
    -- This error is to tell the user that the contributor already exists in the group.
    ELSE
        SIGNAL sqlstate '45000' SET message_text = 'This group already contains this contributor.';
    END IF;
END; //
Delimiter ;

-- Function for getting total fish caught
Delimiter //
CREATE DEFINER=current_user 
FUNCTION `test_func`(id_loc int) 
RETURNS int(11)
    DETERMINISTIC
BEGIN
	-- Fish caught is the int for total fish caught at that location
	Declare fish_caught int;
    
    -- Get the data for total amount of fish record from catch record
    Select count(id_fish) into fish_caught from catch_record where id_loc = id_location;
    
RETURN fish_caught;
END; //
Delimiter ;

Delimiter //
CREATE DEFINER=current_user FUNCTION `find_likely_location`(in_id_fish int) RETURNS varchar(20) CHARSET latin1
BEGIN
-- This declares the variable to return to at the end of the function out_location_name
DECLARE out_location_name VARCHAR(20);
    -- Here we select the location name that is the result of the sorting below into the out parameter
    SELECT location_name INTO out_location_name
    FROM catch_record
    -- We join the catch record with the necessary tables in order to get the names 
    -- rather than just the ids that are provided in the catch record
    JOIN location ON catch_record.id_location = location.id_location
    JOIN fish ON catch_record.id_fish = fish.id_fish
    -- This is limiting the results to the fish of interest which comes from our IN parameter
    WHERE catch_record.id_fish = in_id_fish
    -- This groups the results by the location so that we can sort through the information.
    GROUP BY catch_record.id_location
    -- This is the most important line because it use the COUNT function in the ORDER BY.
    -- The result of this, is an ordered table based on the amount of times a location appears.
    -- Finally limiting by 1 to give us the location with the most catches of this species.
    ORDER BY COUNT(location_name) DESC LIMIT 1;
-- Returned to the OUTPUT parameter
RETURN out_location_name;
END; //
Delimiter ;

-- Procedure for finding the top three location for a user
Delimiter //
CREATE DEFINER=current_user 
PROCEDURE `contributor_top_locations`(id_contrib int)
BEGIN
	-- Fish count is the number of fish for a given location, loc_id is the location id being calculated
    Declare fish_count int;
    Declare loc_id int;
    Declare done bool default False;
    
    -- Use a cursor to iterate through the table with top three records in desc order
    Declare fish_cur cursor for
		Select count(id_record), id_location from catch_record where id_person = id_contrib group by id_location order by count(id_record) desc limit 3;
        
	Declare continue handler for not found set done = TRUE;
    
    -- Pass on the temp table to php
	Drop table if exists top_locations;
    Create temporary table if not exists top_locations (catch_count int, location_id int);
        
	-- Iterate through the cursor and add the data to the temp table
	Open fish_cur;
    for_each_entry: Loop
		Fetch fish_cur into fish_count, loc_id;
		If done= TRUE then
			Leave for_each_entry;
		End if;

        insert into top_locations VALUES (fish_count, loc_id);
    End Loop; 
    Close fish_cur;
    Set done = False;
END; //
Delimiter ;

Delimiter //
CREATE DEFINER=current_user PROCEDURE `location_largest_fish`(in_location_id INT)
BEGIN
-- The first step of this procedure is to select the required parts: the name, weight, and technique used.
-- This also gives the max weight that exists for this location, which gives the rest of the entry.
    SELECT fish_name AS 'largest_fish', weight AS 'weight', technique_name AS 'technique_used'
    -- This is all coming from the catch record table, but joins all of the necessary tables simply to get the names.
    -- This is convinient due to the fact that this way we can simply perform the logic with the catch record, 
    -- and then after this is done, list the names with the associated id's.
    FROM catch_record
    JOIN location ON catch_record.id_location = location.id_location
    JOIN fish ON catch_record.id_fish = fish.id_fish
    JOIN technique ON catch_record.id_technique = technique.id_technique
    -- This is the where clause where we only return entries from the entered location.
    WHERE catch_record.id_location = in_location_id
    ORDER BY catch_record.weight DESC LIMIT 1;
    
END; //
Delimiter ;

-- Turn back on foreign key check to ensure reference is valid
Set FOREIGN_KEY_CHECKS = 1;