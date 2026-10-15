-- PCR Resilence Group Project
-- 04/15/2026 - 05/01/2026
-- Mame Diarra N'daw, Abby McDaniel, Gracie Reagan


-- Creating the Database:
drop database if exists pcr;
create database pcr;
use pcr;


-- Table 1: Demographics
drop table if exists demographics;
create table demographics (
	demographics_id int primary key auto_increment,
	date date,
    age int,
    race varchar(35),
    extracurriculars int,
    gender varchar(10)
);


-- Table 2: Pcr_resil
drop table if exists pcr_resil; 
create table pcr_resil ( 
    pcr_resil_id int primary key auto_increment, 
    demographics_id int,
    test_date date, 
    pcr_mean decimal(3,1), 
    resilience decimal(3,1), 
    age int, 
	foreign key (demographics_id) references demographics(demographics_id) 
); 


-- Table 3: Pcr_exploritory
drop table if exists pcr_exp; 
create table pcr_exp ( 
    pcr_exp_id int primary key auto_increment, 
    pcr_resil_id int,
    pcr decimal(3,1), 
    resilience decimal(3,1), 
    pac decimal(3,1), 
    social_int decimal(3,1),
    foreign key (pcr_resil_id) references pcr_resil(pcr_resil_id)
	on delete cascade
);


-- Inserting Data into the Demographics Table
insert into demographics (date, age, race, extracurriculars, gender) values
	('2026-01-01',20, 'White', 10, 'Male'),
    ('2026-01-02',23, 'Black/African American', 10, 'Female'),
    ('2026-03-02',18, 'White', 12, 'Female'),
    ('2026-02-19',18, 'White', 20, 'Female'),
    ('2026-01-02',18, 'White', 15, 'Female'),
    ('2026-02-01',19, 'White', 35, 'Male'),
    ('2026-02-02',24, 'White', 20, 'Female'),
    ('2026-02-01',22, 'White', 10, 'Female'),
    ('2026-02-02',20, 'Hispanic/Latinx', 10, 'Male'),
    ('2026-02-04',21, 'White', 15, 'Female');
select * from demographics;


-- Inserting data into the PCR Resil Table
insert into pcr_resil (demographics_id, test_date, pcr_mean, resilience, age) values 
	(1,'2026-01-01', 3.6, 3.6, 20), 
	(2,'2026-01-02', 3.6, 3.6, 23), 
	(3,'2026-03-02', 2.4, 3.4, 18), 
	(4,'2026-02-19', 3.2, 3.2, 18), 
	(5,'2026-01-02', 4.2, 4.4, 19), 
	(6, '2026-02-01', 4.2, 4.0, 19), 
	(7,'2026-02-01', 3.0, 2.8, 24), 
	(8,'2026-02-02', 2.6, 2.6, 20), 
	(9,'2026-02-03', 3.6, 3.6, 20), 
	(10,'2026-02-04', 4.2, 3.0, 21); 
select * from pcr_resil; 


-- Inserting data into the PCR Exp Table
insert into pcr_exp (pcr_resil_id, pcr, resilience, pac, social_int) values 
	(1, 3.6, 2.3, 4.2, 5.2), 
	(2, 3.6, 2.8, 3.4, 4.0), 
	(3, 2.4, 2.7, 4.0, 4.0), 
	(4, 3.2, 3.6, 3.8, 5.5), 
	(5, 4.2, 4.6, 4.0, 5.8), 
	(6, 4.2, 5.1, 4.6, 6.8), 
	(7, 3.0, 5.0, 3.6, 3.7), 
	(8, 2.6, 5.3, 2.0, 4.2), 
	(9, 3.6, 6.3, 3.0, 4.2), 
	(10, 4.2, 7.1, 4.4, 4.2); 
select * from pcr_exp; 


-- Creating and Using Views #1: MAME DIARRA
# update extracurricular hours
drop view if exists ec_hours_update;
create view ec_hours_update as
select demographics_id, extracurriculars
from demographics; 

update ec_hours_update
set extracurriculars = '17'
where demographics_id = 10;

select * from ec_hours_update;


-- Creating and Using Views #2: MAME DIARRA
drop view if exists v_pcr_update;
create view v_pcr_update as
select pcr_resil_id, test_date
from pcr_resil; 

update v_pcr_update
set test_date = '2025-05-01'
where pcr_resil_id = 10;

select * from v_pcr_update;


-- Creating and Using Procedures #1: ABBY
# update procedure C2 session 6 (update extracur and resilience)
select  
    d.demographics_id, 
    d.extracurriculars, 
    r.resilience 
from demographics d 
join pcr_resil r  
    on d.demographics_id = r.demographics_id 
order by d.demographics_id; 

drop procedure if exists UpdateBoth; 
delimiter // 
create procedure UpdateBoth(in ResIncrease decimal(3,1), in ExtraIncrease int) 
begin 
    update demographics 
    set extracurriculars = extracurriculars + ExtraIncrease 
    where extracurriculars < 15; 

    update pcr_resil r 
    join demographics d on r.demographics_id = d.demographics_id 
    set r.resilience = r.resilience + ResIncrease 
    where d.extracurriculars < 15; 
end // 
delimiter ; 
call UpdateBoth(0.1, 2); 


-- Creating and Using Procedures #2: ABBY
# search procedure C3 session 6 (search for ID and Race)
drop procedure if exists SearchIDRace; 
delimiter // 
create procedure SearchIDRace(in personID int) 
begin 
    select demographics_id, race 
    from demographics 
    where demographics_id = personID; 
end // 
delimiter ; 
call SearchIDRace(3); 
call SearchIDRace (9); 


-- Creating and Using Procedures #3: ABBY
# total extracur hours by gender
drop procedure if exists SearchHoursByGender; 
delimiter // 
create procedure SearchHoursByGender() 
begin 
    select gender, sum(extracurriculars) as total_hours 
    from demographics 
    group by gender; 
end // 
delimiter ; 
call SearchHoursByGender(); 


-- Creating and Using Functions #1: MAME DIARRA
#how much resilience should be reduced based on old vs new extracurricular hours
delimiter //
create function reduceResilience(old_hours INT, new_hours INT)
returns int
deterministic
begin
	declare reduction int;
    
    -- only reduce if extracurricular hours increase
    set reduction = new_hours - old_hours;
    
    if reduction < 0 then
		set reduction = 0;
	end if;
    
    return reduction;
end//
delimiter ;

update pcr_resil p
join demographics d
	on p.demographics_id = d.demographics_id
set p.resilience = p.resilience - reduceResilience (2,9)
where d.demographics_id = 4;

select * from pcr_resil;


-- Creating and Using Functions #2: MAME DIARRA
# search function which returns avg resilience per demographic
delimiter //
create function avgResilienceByRace(race_name varchar(50))
returns decimal(5,2)
deterministic
begin
	declare avg_val decimal(4,2);
    
    select avg(p.resilience)
    into avg_val
    from demographics d
    join pcr_resil p
		on d.demographics_id = p.demographics_id
    where d.race = race_name;
    
    return avg_val;
end//
delimiter ; 

select 'White' as race,
	avgResilienceByRace('White') as avg_resilienceByRace;


-- Creating and Using Functions #3: MAME DIARRA
# search function to find resilience mean for a specific id number
delimiter //
create function avgResilienceById(demo_id int)
returns decimal(5,2)
deterministic
begin
	declare avg_val decimal(5,2);
    
    select avg(p.resilience)
    into avg_val
    from pcr_resil p
    join demographics d
    on p.demographics_id = d.demographics_id
    where d.demographics_id = demo_id;
    
    return avg_val;
end//
delimiter ;

select 7 as demographics_id, avgResilienceById(2);


-- Creating and Using Triggers #1: MAME DIARRA
#how to track when a row in pcr_exp was last changed using a trigger

alter table pcr_exp
add column last_modified timestamp null;

DELIMITER //
create trigger update_pcrExp_timestamp
before update on pcr_exp
for each row
begin
    set NEW.last_modified = NOW();
end//
delimiter ;

update pcr_exp
set pac = 4.9
where pcr_exp_id = 1;

select pcr_exp_id, last_modified
from pcr_exp
where pcr_exp_id = 1;

select * from pcr_exp;

-- Creating and Using Triggers #2: MAME DIARRA
#flag low social interaction scores
alter table pcr_exp
add column low_social_interaction_flag TINYINT(1);

delimiter $$
create trigger flag_low_social_interaction_before_insert
before insert on pcr_exp
for each row
begin
    if NEW.social_int < 2.5 then
        set NEW.low_social_interaction_flag = 1;
    else
        set NEW.low_social_interaction_flag = 0;
    end if;
end$$
delimiter ;

 -- testing if social int is below threshold:
insert into pcr_resil (resilience)
values (3.4);

insert into pcr_exp (pcr_resil_id, pcr, resilience, pac, social_int)
values (11, 1.8, 3.4, 7.6, 1.2);


select pcr_exp_id, social_int, low_social_interaction_flag
from pcr_exp
where pcr_exp_id = 11;


 -- testing if social int is above threshold:
insert into pcr_resil (resilience)
values (8.6);

insert into pcr_exp (pcr_resil_id, pcr, resilience, pac, social_int)
values (12, 4.5, 8.6, 3.4, 90);

select pcr_exp_id, social_int, low_social_interaction_flag
from pcr_exp
where pcr_exp_id = 12;

select * from pcr_exp; 


-- Creating and Using Triggers #3: MAME DIARRA
# auto-insert a pcr_resil row when a row in demographics is added
delimiter //
create trigger auto_create_resil_after_demo_insert
after insert on demographics
for each row
begin
	insert into pcr_resil( 	
        demographics_id,
        resilience
	)
    values(
		NEW.demographics_id,
		null);
end//
delimiter ;

insert into demographics (age, race, gender)
values (22, 'Black/African American', 'Male');

select last_insert_id();

select * from pcr_resil where demographics_id = last_insert_id();

select * from pcr_resil;
select * from demographics;


-- Creating and Using Queries #1: GRACIE
# find the highest resilience mean
SELECT AVG(resilience) AS highest_resilience_mean 
FROM pcr_resil; 

-- Creating and Using Queries #2: ABBY
# find extracur hours for ids with resilience means between 3 and 4 
select
    d.demographics_id, 
    d.extracurriculars, 
    r.pcr_mean 
from demographics d 
join pcr_resil r  
    on d.demographics_id = r.demographics_id 
where r.pcr_mean between 3 and 4; 

-- Creating and Using Queries #3: GRACIE
# find the pcr mean for test dates before 2026/02/01
SELECT AVG(resilience) AS pcr_mean_before_2026 
FROM pcr_resil 
WHERE test_date < '2026-02-01'; 

-- Creating and Using Summary Queries USING GROUP BY #1: GRACIE
# find the highest and lowest pcr mean by demographic
WITH means AS ( 

    SELECT  
        demographics_id, 
        AVG(resilience) AS pcr_mean 
    FROM pcr_resil 
    GROUP BY demographics_id 
), 
ranked AS ( 
    SELECT  
        demographics_id, 
        pcr_mean, 
        RANK() OVER (ORDER BY pcr_mean DESC) AS highest_rank, 
        RANK() OVER (ORDER BY pcr_mean ASC) AS lowest_rank 
    FROM means 
) 

SELECT * 
FROM ranked 
WHERE highest_rank = 1 OR lowest_rank = 1; 

-- Creating and Using Summary Queries USING GROUP BY #2: GRACIE
# find average extracur hours by gender
SELECT  
   gender, 
    AVG(extracurriculars) AS avg_extracurr_hours 
FROM demographics 
GROUP BY gender 
ORDER BY gender;


-- Creating and Using Summary Queries USING GROUP BY #3: ABBY
# find the highest social interaction mean by gender
select  
    d.gender, 
    max(e.social_int) as highest_social_interaction 
from demographics d 
join pcr_resil r  
    on d.demographics_id = r.demographics_id 
join pcr_exp e 
    on r.pcr_resil_id = e.pcr_resil_id 
group by d.gender; 





