--	Question 1
Select Max(age) "Max Age", Min(age) "Min Age", Stddev(age) from Users

--	Question 2
Select username, Count(followedusername) "Followers" from Users u
join Following f on followedusername = username
group by username
having Count(followedusername) in (
	Select max(c) "Followers" from (
		Select Count(*) c from Users u
		join Following f on username = followedusername
		group by username
	)
)

--	Question 3
Select * from (
	Select username, Count(followedusername) "Followers" from Users u
	join FOllowing f on followedusername = username
	group by username
	having Count(followedusername) not in (
		Select max(c) from (
			Select Count(*) c from Users u
			join Following f on username = followedusername
			group by username
		)
	)
)
Limit 1;

--	Question 4
Select username from Users 
where username not in (
	Select username from Tweets
)

--	Question 5
Select hashtag, u.username, count(*) "NoOfMentions" from Hashtags h
join Tweets t on t.text ilike '%'||h.hashtag||'%'
join Users u on u.username = t.username
group by u.username, hashtag

--	Question 6
Select distinct username from Users 
where username not in (
	Select username from Tweets where text ilike '%#Census%'
)

--	Question 7
Select username from Users where username not in (Select followedusername from Following)

--	Question 8
SELECT username 
FROM Users u 
WHERE NOT EXISTS (
    SELECT 1 
    FROM Following f 
    WHERE f.FollowedUserName = u.UserName
);

--	Question 9
Select description, Count(*) "Count" from Interests i
join userinterests ui on ui.interestid = i.interestid
group by i.interestid
order by count(*) desc

--	Question 10
Select country, Count(*) from Users u
join Tweets t on u.username = t.username
group by u.country
order by u.country 

--	Question 11
select T.UserName, T.NumTweets from 
(select UserName, count(*) as NumTweets
from Tweets
group by UserName) as T
JOIN 
(select AVG(NumTweets) as AvgTweets
from (select count(*) as NumTweets
from Tweets
group by UserName) as Sub) as Avg on T.NumTweets > Avg.AvgTweets

--	Question 12
Select distinct followedusername from Following f
join Users u on username = followerusername
where country = 'Pakistan'

--	Question 13
Select description, Count(*) "Count" from Interests i
join userinterests ui on ui.interestid = i.interestid
group by i.interestid
order by count(*) desc
Limit 1;