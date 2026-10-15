## Parent-Child Resilience SQL (Group) Project

Objective:
This code dissects a snippet of data collected from a senior seminar research project. The study looked at the relationship between parent-child relationships and college students' outcomes. The codes shown will dissect demographics (gender, race, extracurriculars, date of survey), parent-child relationship scores, and resilience scores. Although most statistical analyses are conducted in Jamovi for senior seminar projects, many researchers use coding to analyze collected data. 

________________________________________________________________________________________________________

Data:
TABLES:
  - Demographics
  - Resilience
  - Exploratory Testing
*Each table had at least 3 columns and at least 1 primary and/or foreign key

VIEW 1: Updated extracurricular hours
VIEW 2: Update test_date

PROCEDURE 1: Updated any extracurricular hours less than 15 by 2, and resilience by 0.1
PROCEDURE 2: Searching race by demographics_id
PROCEDURE 3: Sum of total hours by gender

FUNCTION 1: Calculating how much resilience should be reduced based on old vs new extracurricular hours
FUNCTION 2: Search function, which returns the average resilience per demographic
FUNCTION 3: Search function to find the resilience mean associated with a specific ID number

TRIGGER 1: This trigger tracks when a row in pcr_exp was last changed
TRIGGER 2: This trigger flags any low social interaction scores
TRIGGER 3: This trigger auto-inserts a pcr_resil row when a row in demographics is added

QUERY 1: This query finds the highest resilience mean from the pcr_resil table
QUERY 2: This query finds extracurricular hours for IDs with resilience means between 3 and 4
QUERY 3: This query finds the PCR mean for test dates before 2026/02/01

SUMMARY QUERY 1: This summary query finds the highest and lowest PCR means by demographic ID
SUMMARY QUERY 2: This summary query finds the average extracurricular hours by gender
SUMMARY QUERY 3: This summary query finds the highest social interaction mean by gender
_________________________________________________________________________________________________________

Key Takeaways:
This project gave me insight into what SQL in the real world would look like. I was not knowledgeable about Psychology or the role resilience plays in Parent-Child relationships, so this assignment showed me how to quickly learn a dataset and understand the relationships between tables, enabling me to perform meaningful analyses.
________________________________________________________________________________________________________

TOOLS USED:
MySQLWorkbench
