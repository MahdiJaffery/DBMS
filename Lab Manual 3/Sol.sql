--	Question 1
SELECT 
    ct.name AS card_type,
    COUNT(DISTINCT uc.userID) AS unique_users
FROM 
    Card c
JOIN 
    CardType ct ON c.cardTypeID = ct.cardTypeID
JOIN 
    UserCard uc ON c.cardNum = uc.cardNum
GROUP BY 
    ct.name;

--	Question 2
Select name, uc.cardnum from Users u
join usercard uc on uc.userid = u.userid
join card c on uc.cardnum = c.cardnum
where balance between 2000 and 4000

--	Question 3
	--	a
	Select * from Users
		where userid not in
			(Select u.userid from Users u
			join UserCard uc on u.userid = uc.userid)
	--	b
	Select * from Users
	Except
	Select u.userid, name, phonenum, city from Users u
	join UserCard uc on u.userid = uc.userid
	
--	Question 4
	--	a
		SELECT uc.cardnum AS "Card ID", 
       	u.name AS "Owner", 
       	ct.name AS "Card Type"
		FROM UserCard uc
		JOIN Users u ON u.userid = uc.userid
		JOIN Card c ON c.cardnum = uc.cardnum
		JOIN CardType ct ON ct.cardtypeid = c.cardtypeid
		WHERE uc.cardnum 
		  IN (
		    SELECT uc.cardnum
		    FROM UserCard uc
		    JOIN Users u ON u.userid = uc.userid
		    JOIN Card c ON c.cardnum = uc.cardnum
		    JOIN CardType ct ON ct.cardtypeid = c.cardtypeid
		    EXCEPT
		    SELECT t.cardnum
		    FROM Transactions t
		    WHERE EXTRACT(YEAR FROM t.transdate) = EXTRACT(YEAR FROM CURRENT_DATE)
		  );

	
	--	b
		Select uc.cardnum "Card ID", u.name "Owner", ct.name "card Type" from Transactions t
		join Card c on c.cardnum = t.cardnum
		join CardType ct on ct.cardtypeid = c.cardtypeid
		join UserCard uc on uc.cardnum = t.cardnum
		join Users u on u.userid = uc.userid
		where uc.cardnum
		not in
			(Select distinct t.cardnum
			from Transactions t
			where Extract(Year from t.transdate) = Extract(Year from current_timestamp))

--	Question 5
Select ct.name, Count(distinct c.cardnum) "Count" from Transactions t
join Card c on c.cardnum = t.cardnum
join CardType ct on ct.cardtypeid = c.cardtypeid
group by ct.name, t.amount
having Sum(t.amount) >= 6000

--	Question 6
Select u.userid, u.name, phonenum, city from Users u
join UserCard uc on uc.userid = u.userid
join Card c on c.cardnum = uc.cardnum
where 
Extract(Month from expiredate) between Extract(Month from current_timestamp) and Extract(Month from current_timestamp)
and Extract(Year from expiredate) = Extract(Year from current_timestamp)

--	Question 7
Select u.userid, u.name from Users u
join UserCard uc on uc.userid = u.userid
join Card c on uc.cardnum = c.cardnum
group by u.userid
having Sum(balance) >= 5000

--	Question 8
SELECT c1.cardnum AS "Card 1", 
       c2.cardnum AS "Card 2", 
       EXTRACT(YEAR FROM c1.expiredate) AS "Expire Year"
FROM Card c1
JOIN Card c2 ON EXTRACT(YEAR FROM c1.expiredate) = EXTRACT(YEAR FROM c2.expiredate)
WHERE c1.cardnum <> c2.cardnum;

--	Question 9
Select u1.name "User 1", u2.name "User 2"
from Users u1
join Users u2 on u2.userid <> u1.userid
where Left(u1.name, 1) = Left(u2.name, 1)

--	Question 10
Select distinct u.userid, u.name from Users u
join UserCard uc on uc.userid = uc.userid
join Card c on c.cardnum = uc.cardnum
join cardtype ct on ct.cardtypeid = c.cardtypeid
group by u.userid, ct.name

--	Question 11
Select distinct city, Sum(Balance) from Users u
join usercard uc on uc.userid = u.userid
join card c on c.cardnum = uc.cardnum
group by city
