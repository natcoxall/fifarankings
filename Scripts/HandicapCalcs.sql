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

SELECT Player
	--,ROUND(Handicap * 2, 0) / 2 AS RoundedHandicap
	--,ROUND(Handicap, 0, 1) AS RoundedWhole
	--,Handicap - ROUND(Handicap, 0, 1) AS RemainingDecimal
	--,CASE WHEN (Handicap - ROUND(Handicap, 0, 1)) >= 0.5 THEN 0.5 ELSE 0.0 END AS RoundedDecimal
	,(ROUND(Handicap, 0, 1)) + (CASE WHEN (Handicap - ROUND(Handicap, 0, 1)) >= 0.5 THEN 0.5 ELSE 0.0 END) AS FinalRoundedHandicap
FROM Handicaps
ORDER BY Handicap DESC