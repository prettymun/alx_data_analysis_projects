USE md_water_services;
SHOW TABLES;

-- location table
SELECT *
FROM md_water_services.location
LIMIT  10;

-- visits table
SELECT *
FROM md_water_services.visits
LIMIT  10;


-- water_source table
SELECT *
FROM md_water_services.water_source
LIMIT  10;

-- unique type of water source
SELECT
	DISTINCT (type_of_water_source)
FROM md_water_services.water_source;

-- records when time in queue wasmore than 500 minutes or 8 hours
SELECT *
FROM md_water_services.visits
WHERE time_in_queue > 500;

-- Assessing the quality of water source 10 being highest ie taps in homes and 1 being the least. Areas with 1 visit count means the place has good quality of water while  more than  1 means several visits

SELECT *
FROM water_quality
WHERE subjective_quality_score = 10 AND visit_count = 2;

-- Investigating pollution data
SELECT *
FROM well_pollution
LIMIT 10;

SELECT *
FROM well_pollution
WHERE results = 'Clean' AND biological > 0.01;

-- to identify the records that mistakenly have the word Clean in the description. ie they are labelled as Clean in the description column with biological > 0.01
SELECT *
FROM well_pollution
WHERE description LIKE 'Clean %';

-- correcting the mistake 
-- All records that mistakenly have Clean Bacteria: E. coli should updated to Bacteria: E. coli
-- All records that mistakenly have Clean Bacteria: Giardia Lamblia should updated to Bacteria: Giardia Lamblia
SET SQL_SAFE_UPDATES = 0;

UPDATE 
	well_pollution
SET 
	description = 'Bacteria: E. coli'
WHERE
	description = 'Clean Bacteria: E. coli';


UPDATE 
	well_pollution
SET 
	description = 'Bacteria: Giardia Lamblia'
WHERE
	description = 'Clean Bacteria: Giardia Lamblia';
    
-- Checking if the updates are functional or done.. so WWE INPUT A COPY TABLE TO CONFIRM
CREATE TABLE
md_water_services.well_pollution_copy
AS (
SELECT *
FROM
	md_water_services.well_pollution);

-- Testing the well_pollution copy table
UPDATE
well_pollution_copy
SET
description = 'Bacteria:E. coli'

WHERE
description = 'Clean Bacteria:E. coli';

UPDATE
well_pollution_copy
SET
description = 'Bacteria: Giardia Lamblia'

WHERE
description = 'Clean Bacteria: Giardia Lamblia';

UPDATE
well_pollution_copy
SET
results = 'Contaminated: Biological'

WHERE
biological > 0.01 AND results = 'Clean';

-- Checking for errors in our well_pollution_copy table

SELECT *
FROM
well_pollution_copy
WHERE
description LIKE "Clean_%"
OR (results = "Clean" AND biological > 0.01);

-- Now we are sure it works so we can put the code into well_pollution and drop the well_pollution_copy table
UPDATE
well_pollution_copy
SET
description = 'Bacteria:E. coli'

WHERE
description = 'Clean Bacteria:E. coli';

UPDATE
well_pollution_copy
SET
description = 'Bacteria: Giardia Lamblia'

WHERE
description = 'Clean Bacteria: Giardia Lamblia';

UPDATE
well_pollution_copy
SET
results = 'Contaminated: Biological'

WHERE
biological > 0.01 AND results = 'Clean';

DROP TABLE
md_water_services.well_pollution_copy;
