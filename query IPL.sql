GO

SELECT city, venue
FROM ipl.matches
WHERE team1 = 'Royal Challengers Bangalore' OR team2='Royal Challengers Bangalore'

SELECT *
FROM ipl.matches


SELECT * 
FROM ipl.deliveries
GO

WITH best_batsman as (
SELECT batsman, sum(total_runs) as total_runs
	, count(DISTINCT match_id) as total_innings
FROM ipl.deliveries
GROUP BY batsman
) 
SELECT *
	, ROUND((CAST(total_runs AS FLOAT) / CAST(total_innings AS FLOAT)), 2) AS batting_avg
FROM best_batsman
ORDER BY total_runs DESC

GO
/*************************************************************************/


SELECT *
FROM ipl.deliveries
GO

WITH HC_batsman AS (
	SELECT SUM(total_runs) AS Runs, batsman, match_id
	FROM ipl.deliveries
	GROUP BY batsman, match_id
	HAVING SUM(total_runs) >= 100
)
SELECT batsman, COUNT(Runs) as hundreds
FROM HC_batsman
GROUP BY batsman
ORDER BY hundreds DESC



WITH HC_batsman AS (
	SELECT SUM(total_runs) AS Runs, batsman, match_id
	FROM ipl.deliveries
	GROUP BY batsman, match_id
	HAVING SUM(total_runs) >= 50 AND SUM(total_runs) <100
)
SELECT batsman, COUNT(Runs) as fifties
FROM HC_batsman
GROUP BY batsman
ORDER BY fifties DESC

GO

CREATE VIEW hund AS
WITH HC_batsman AS (
	SELECT SUM(total_runs) AS Runs, batsman, match_id
	FROM ipl.deliveries
	GROUP BY batsman, match_id
	HAVING SUM(total_runs) >= 100
)
SELECT batsman, COUNT(Runs) as hundreds
FROM HC_batsman
GROUP BY batsman


CREATE VIEW fift AS

	WITH HC_batsman AS (
		SELECT SUM(total_runs) AS Runs, batsman, match_id
		FROM ipl.deliveries
		GROUP BY batsman, match_id
		HAVING SUM(total_runs) >= 50 AND SUM(total_runs) <100
	)
	SELECT batsman, COUNT(Runs) as fifties
	FROM HC_batsman
	GROUP BY batsman




SELECT H.batsman, H.hundreds, F.fifties
FROM hund AS H
JOIN fift AS F ON H.batsman = F.batsman
ORDER BY hundreds DESC, fifties DESC

/*******************************/

WITH winner AS(
SELECT ROW_NUMBER() OVER (PARTITION BY season ORDER BY date DESC) AS RK, *
FROM ipl.matches
) SELECT season, winner FROM winner WHERE RK=1


/************************************/


Create view B_Runs As
	Select match_id, bowler, sum(total_runs) as total_runs from ipl.deliveries
	Group by match_id, bowler

Create view B_Wkts As
	Select match_id, bowler, count(player_dismissed) as wickets from ipl.deliveries
	Where LEN(ipl.deliveries.player_dismissed) >= 4
	Group by match_id, bowler

Create view bowler_avg As
	SELECT BR.match_id, BR.bowler, BW.wickets, BR.total_runs
	FROM B_Runs AS BR
	JOIN B_Wkts AS BW ON BR.match_id = BW.match_id AND BR.bowler = BW.bowler
	

Select del.season, del.city, del.venue, BA.bowler, (Convert(Varchar(64), BA.wickets) + '-' + Convert(Varchar(64), BA.total_runs)) AS best_figures
From bowler_avg AS BA
JOIN ipl.matches AS del ON BA.match_id = del.id
Order by wickets Desc, total_runs


/******************************************************************/

Create View 
Select season, winner, 
		CASE win_by_runs
			When 0 Then win_by_wickets*10
			else win_by_runs
		end as winning_type
		from ipl.matches
