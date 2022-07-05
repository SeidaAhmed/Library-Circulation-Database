USE library_circulation;
-- Query 1
SELECT locate.branch 
	FROM locate INNER JOIN libraryitem LI On LI.BarCode = locate.item
	WHERE (LI.barcode = 122 AND LI.staCREATE DATABASE `library_circulation` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
tus = 'Available');
    
-- Query 2
SELECT patron.name, B.date_out, B.return_date, B.fines
	FROM borrow B INNER JOIN patron ON B.Patron = patron.member_id
    WHERE B.Item = 121;
    
-- Q3
SELECT locate.branch, rack.row, rack.section
	FROM locate INNER JOIN rack ON rack.RackID = locate.rack 
    WHERE locate.item = 123;

-- Q4
SELECT patron.name, sum(B.fines) AS 'total fines'
	FROM borrow B INNER JOIN patron ON patron.member_id = B.Patron
    GROUP BY B.Patron
	HAVING sum(B.fines) > 50;

-- Q5
SELECT P.name, RE.done, RE.CreationDate
FROM patron P INNER JOIN reserve RE ON P.member_id = RE.Card 
WHERE RE.Work = '811.54 BRA';

-- Q6
SELECT LI.BarCode, work.CallNum, work.MARC_ID 
FROM  work NATURAL JOIN libraryitem LI

-- Q7 
-- N.B. I don't think I understood Seida's RA query,so I've interpreted the query to mean 'for which reserved works is there already a copy in the branch requested as pickup location?'
SELECT RE.idReserve, LI.BarCode, RE.Work, locate.branch
FROM reserve RE INNER JOIN libraryitem LI ON RE.Work = LI.CallNum INNER JOIN locate ON locate.item = LI.BarCode
WHERE locate.branch = RE.pickup

-- Q8 
SELECT P.name, P.email, P.phone_num AS 'Phone Number',
CASE WHEN LC.Active = 1 THEN 'Active' ELSE 'Inactive' END AS 'library card status'
FROM library_card LC INNER JOIN patron P ON LC.member = P.member_id
WHERE LC.Active = 0

-- Q9
-- N.B. I'm not sure why this would require a join on Branch so I just haven't included one
SELECT RE.Work, RE.CreationDate, work.Marc_ID, RE.pickup
FROM reserve RE INNER JOIN work ON RE.work = work.CallNum 
WHERE RE.pickup = 'Robarts'


-- Q10
--  This is slightly modified from the RA Query. I'm imagining you scan a patron's card (so, given a card number), and want to find info about what they've borrowed. Otherwise there is no need for a join that implicates the patron.
SELECT LI.CallNum, B.date_out, B.return_date, B.fines
From borrow B INNER JOIN libraryitem LI ON B.Item = LI.BarCode INNER JOIN library_card ON library_card.member = B.Patron 
WHERE library_card.card_num = 3



