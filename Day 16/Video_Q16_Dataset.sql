-- Given table contains reported covid cases in 2020. 
-- Calculate the percentage increase in covid cases each month versus cumulative cases as of the prior month.
-- Return the month number, and the percentage increase rounded to one decimal. Order the result by the month.

drop table if exists covid_cases;
create table covid_cases
(
	cases_reported	int,
	dates			date	
);
insert into covid_cases values(20124,to_date('10/01/2020','DD/MM/YYYY'));
insert into covid_cases values(40133,to_date('15/01/2020','DD/MM/YYYY'));
insert into covid_cases values(65005,to_date('20/01/2020','DD/MM/YYYY'));
insert into covid_cases values(30005,to_date('08/02/2020','DD/MM/YYYY'));
insert into covid_cases values(35015,to_date('19/02/2020','DD/MM/YYYY'));
insert into covid_cases values(15015,to_date('03/03/2020','DD/MM/YYYY'));
insert into covid_cases values(35035,to_date('10/03/2020','DD/MM/YYYY'));
insert into covid_cases values(49099,to_date('14/03/2020','DD/MM/YYYY'));
insert into covid_cases values(84045,to_date('20/03/2020','DD/MM/YYYY'));
insert into covid_cases values(100106,to_date('31/03/2020','DD/MM/YYYY'));
insert into covid_cases values(17015,to_date('04/04/2020','DD/MM/YYYY'));
insert into covid_cases values(36035,to_date('11/04/2020','DD/MM/YYYY'));
insert into covid_cases values(50099,to_date('13/04/2020','DD/MM/YYYY'));
insert into covid_cases values(87045,to_date('22/04/2020','DD/MM/YYYY'));
insert into covid_cases values(101101,to_date('30/04/2020','DD/MM/YYYY'));
insert into covid_cases values(40015,to_date('01/05/2020','DD/MM/YYYY'));
insert into covid_cases values(54035,to_date('09/05/2020','DD/MM/YYYY'));
insert into covid_cases values(71099,to_date('14/05/2020','DD/MM/YYYY'));
insert into covid_cases values(82045,to_date('21/05/2020','DD/MM/YYYY'));
insert into covid_cases values(90103,to_date('25/05/2020','DD/MM/YYYY'));
insert into covid_cases values(99103,to_date('31/05/2020','DD/MM/YYYY'));
insert into covid_cases values(11015,to_date('03/06/2020','DD/MM/YYYY'));
insert into covid_cases values(28035,to_date('10/06/2020','DD/MM/YYYY'));
insert into covid_cases values(38099,to_date('14/06/2020','DD/MM/YYYY'));
insert into covid_cases values(45045,to_date('20/06/2020','DD/MM/YYYY'));
insert into covid_cases values(36033,to_date('09/07/2020','DD/MM/YYYY'));
insert into covid_cases values(40011,to_date('23/07/2020','DD/MM/YYYY'));	
insert into covid_cases values(25001,to_date('12/08/2020','DD/MM/YYYY'));
insert into covid_cases values(29990,to_date('26/08/2020','DD/MM/YYYY'));	
insert into covid_cases values(20112,to_date('04/09/2020','DD/MM/YYYY'));	
insert into covid_cases values(43991,to_date('18/09/2020','DD/MM/YYYY'));	
insert into covid_cases values(51002,to_date('29/09/2020','DD/MM/YYYY'));	
insert into covid_cases values(26587,to_date('25/10/2020','DD/MM/YYYY'));	
insert into covid_cases values(11000,to_date('07/11/2020','DD/MM/YYYY'));	
insert into covid_cases values(35002,to_date('16/11/2020','DD/MM/YYYY'));	
insert into covid_cases values(56010,to_date('28/11/2020','DD/MM/YYYY'));	
insert into covid_cases values(15099,to_date('02/12/2020','DD/MM/YYYY'));	
insert into covid_cases values(38042,to_date('11/12/2020','DD/MM/YYYY'));	
insert into covid_cases values(73030,to_date('26/12/2020','DD/MM/YYYY'));	


select * from covid_cases;

