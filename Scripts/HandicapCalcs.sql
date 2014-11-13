--SELECT        p.Firstname + ' ' + p.Lastname AS Player, ms.StatusName AS MatchStatus, ro.Name AS Result, ro.Points, 
--                         op.Firstname + ' ' + op.Lastname AS OppositionPlayer, ro.Points * ms.Multiplier AS RankingPoints,
--						 3 * ms.Multiplier AS AvailablePoints
--FROM            dbo.Player AS p INNER JOIN
--                         dbo.RankingScoreLog AS r ON p.Id = r.PlayerId INNER JOIN
--                         dbo.MatchResultLog AS m ON r.MatchId = m.Id INNER JOIN
--                         dbo.ResultOption AS ro ON r.ResultOptionId = ro.Id INNER JOIN
--                         dbo.MatchStatus AS ms ON r.MatchStatusId = ms.Id INNER JOIN
--                         dbo.Player AS op ON r.OppositionPlayerId = op.Id

/***********************************************************************************************************************/

--SELECT        p.Firstname + ' ' + p.Lastname AS Player, SUM(ro.Points * ms.Multiplier) AS RankingPoints
--						,SUM(3 * ms.Multiplier) AS AvailablePoints
--						,(((SUM(3 * ms.Multiplier) - SUM(ro.Points * ms.Multiplier)) / SUM(3 * ms.Multiplier)) * 3) + 2 AS Handicap
--						,
--FROM            dbo.Player AS p INNER JOIN
--                         dbo.RankingScoreLog AS r ON p.Id = r.PlayerId INNER JOIN
--                         dbo.MatchResultLog AS m ON r.MatchId = m.Id INNER JOIN
--                         dbo.ResultOption AS ro ON r.ResultOptionId = ro.Id INNER JOIN
--                         dbo.MatchStatus AS ms ON r.MatchStatusId = ms.Id INNER JOIN
--                         dbo.Player AS op ON r.OppositionPlayerId = op.Id
--GROUP BY p.Firstname, p.Lastname
--ORDER BY Handicap DESC

--SELECT * FROM ResultOption

DECLARE @Handicaps TABLE(Stars decimal(18,1), Low decimal(18,2), High decimal(18,2))
INSERT INTO @Handicaps(Stars, Low, High) SELECT 5.0, 0.00, 0.14 --14
INSERT INTO @Handicaps(Stars, Low, High) SELECT 4.5, 0.15, 0.28 --13
INSERT INTO @Handicaps(Stars, Low, High) SELECT 4.0, 0.29, 0.41 --12
INSERT INTO @Handicaps(Stars, Low, High) SELECT 3.5, 0.42, 0.52 --10
INSERT INTO @Handicaps(Stars, Low, High) SELECT 3.0, 0.54, 0.63 --9
INSERT INTO @Handicaps(Stars, Low, High) SELECT 2.5, 0.64, 0.72 --8
INSERT INTO @Handicaps(Stars, Low, High) SELECT 2.0, 0.73, 0.80 --7
INSERT INTO @Handicaps(Stars, Low, High) SELECT 1.5, 0.81, 0.87 --6
INSERT INTO @Handicaps(Stars, Low, High) SELECT 1.0, 0.88, 0.94 --6
INSERT INTO @Handicaps(Stars, Low, High) SELECT 0.5, 0.95, 1.00 --5

SELECT	p.Firstname + ' ' + p.Lastname AS Player
		,rl.RankingPoints
		,rl.PotentialPoints
		,rl.HandicapDenominator
		,ROUND(RankingPoints / HandicapDenominator, 2) AS PerformanceIndicator
		,(SELECT TOP 1 Stars FROM @Handicaps 
			WHERE ROUND(RankingPoints / HandicapDenominator, 2) BETWEEN Low AND High) AS Handicap
FROM	dbo.Player AS p 
		INNER JOIN dbo.RankingLeaderboard rl ON p.Id = rl.PlayerId
WHERE	p.IsActive = 1
ORDER BY PerformanceIndicator DESC

/*
PerformanceIndicator: the percentage of potential points won
	i.e. ActualPoints / PotentialPoints
This doesn't work well for players with a few games logged
	e.g. 3 / 3

In this scenario we need to contextualise it by marking it out of 10 games instead
	e.g 3 / 30
Therefore, we need PotentialPoints to be have a minimum threshold of 10 friendly games.
	i.e. (10 * WinGamePoints * FriendlyGameMultiplier)
This would mean the following formula will work:
	PI = AP / MAX(PP, HMT)

Examples
	Sam		63/78 = 0.81 = 1.5 star
	Omar	42/60 = 0.70 = 2.0 star
	Nat		27/60 = 0.45 = 3.5 star
	Rob		32/78 = 0.41 = 3.5 star
	Dave	25/69 = 0.36 = 4.0 star
	Chris	20/60 = 0.33 = 4.0 star
	Ieuan	18/60 = 0.30 = 4.0 star
	Ned		10/60 = 0.17 = 4.5 star
	Martyn	04/60 = 0.07 = 5.0 star
	Lyle	00/60 = 0.00 = 5.0 star

PI = Performance Indicator
AP = Actual Points
PP = Potential Points
HMT = Handicap Minimum Threshold

Star thresholds:
	5.0: 0.00 - 0.14
	4.5: 0.15 - 0.27
	4.0: 0.28 - 0.39
	3.5: 0.40 - 0.50
	3.0: 0.51 - 0.60
	2.5: 0.61 - 0.69
	2.0: 0.70 - 0.77
	1.5: 0.78 - 0.84
	1.0: 0.85 - 0.90
	0.5: 0.91 - 1.00
*/
	