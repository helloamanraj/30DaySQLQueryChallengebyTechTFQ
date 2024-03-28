/* -- Problem Statement: Find valid email id's
	A consumer electronics store in Warsaw, stores all the customer feedback in the feedback table. 
	The email id's mentioned by customers are then used by the store to contact customers to promote any upcoming sales.
	However, some of the customers while sharing feedback enter invalid email addresses.
	Write an SQL query to identify and return all the valid email address from the feedback table.

	A valid email address needs to have 3 parts:
		Part 1 is the username. A username can contain upper or lower case letters, numbers and special characters like underscore character "_", dot ".", hyphen "-". Username should always start with a letter. 
		Part 2 is the "@" symbol.
		Part 3 is the domain which needs to have 2 sub parts. First part contains upper or lower case letters followed by a dot symbol and then followed by 2 or 3 letters.
*/

drop table if exists feedback;
create table feedback
(
	feedback_id		int,
	cust_name		varchar(20),
	email			varchar(50),
	rating			float,
	remarks			varchar(200)
);
insert into feedback values(1, 'Zohan', 'zohan@2024@gmail.com', 4, 'good');
insert into feedback values(2, 'Keyaan', 'keyaan.TR@gmail.com', 5, 'very good');
insert into feedback values(3, 'Zayn', 'ZAYN...@gmail', 3, 'ok');
insert into feedback values(4, 'Emir', 'emir-#1@outlook.com', 4, 'ok');
insert into feedback values(5, 'Ashar', 'Ashar-@hotmail.DE', 4, 'nice');
insert into feedback values(6, 'Zoya', 'zoya@techTFQ.org', 4, 'great');
insert into feedback values(7, 'Kabir', 'kabir.com@-gmail.com', 2, 'bad');
insert into feedback values(8, 'Ayaan', 'ayaan123@company.net', 1, 'poor');
insert into feedback values(9, 'Meir', 'meir123@', 1.5, 'poor');
insert into feedback values(10, 'Noah', 'noah_.com@.com', 3.5, 'bad');
insert into feedback values(11, 'Idris', 'i@gmail.com', 5, 'excellent');
insert into feedback values(12, 'Arhaan', 'arhaan$gmail.com', 5, 'awesome');
insert into feedback values(13, 'Abrar', 'abrar123@gmail.comm', 5, 'awesome');


select * from feedback;


