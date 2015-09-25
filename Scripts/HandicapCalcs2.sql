--    SELECT	p.Firstname + ' ' + p.Lastname AS Player
--            ,rl.RankingPoints
--            ,rl.PotentialPoints
--            ,rl.HandicapDenominator
--            ,ROUND(RankingPoints / HandicapDenominator, 2) AS RawPerformanceIndicator
--            ,(SELECT TOP 1 Stars FROM HandicapThresholds
--                WHERE ROUND(RankingPoints / HandicapDenominator, 2) BETWEEN Low AND High) AS Handicap
--            ,rl.MatchesPlayed
--            ,rl.NoobModifier
--            ,ROUND(RankingPoints / HandicapDenominator, 2) * rl.NoobModifier AS ModifiedPerformanceIndicator
--            ,(SELECT TOP 1 Stars FROM HandicapThresholds
--                WHERE ROUND(RankingPoints / HandicapDenominator, 2) * rl.NoobModifier BETWEEN Low AND High) AS ModifiedHandicap
--    FROM	dbo.Player AS p 
--            INNER JOIN dbo.RankingLeaderboard rl ON p.Id = rl.PlayerId
--    WHERE	p.IsActive = 1
--    ORDER BY rl.MatchesPlayed DESC

--/********************************************************************************************************************************/
--SELECT		p.Id AS PlayerId
--            ,p.Firstname + ' ' + p.Lastname AS PlayerName
--            ,COUNT(m.Id) AS MatchesPlayed
--            ,CASE WHEN COUNT(m.Id) < 10 
--                THEN CAST(0.50 + (0.5 * COUNT(m.Id) / 10) AS numeric(2,2))
--                ELSE 1 
--                END AS NoobModifier
--            ,SUM(ro.Points * ms.Multiplier) AS RankingPoints
--            ,SUM(3 * ms.Multiplier) AS PotentialPoints
--            ,CASE WHEN SUM(3 * ms.Multiplier) > 60 THEN SUM(3 * ms.Multiplier) ELSE 60 END AS HandicapDenominator
--FROM            dbo.Player AS p INNER JOIN
--                        dbo.RankingScoreLog AS r ON p.Id = r.PlayerId INNER JOIN
--                        dbo.MatchResultLog AS m ON r.MatchId = m.Id INNER JOIN
--                        dbo.ResultOption AS ro ON r.ResultOptionId = ro.Id INNER JOIN
--                        dbo.MatchStatus AS ms ON r.MatchStatusId = ms.Id INNER JOIN
--                        dbo.Player AS op ON r.OppositionPlayerId = op.Id
--WHERE p.IsActive = 1
--GROUP BY p.Id, p.Firstname, p.Lastname
--ORDER BY MatchesPlayed

--SELECT * FROM MatchResults WHERE HomePlayer = 'Grant Carroll' OR AwayPlayer = 'Grant Carroll' ORDER BY MatchDate

--SELECT *
--        ,RankingPoints / PotentialPoints AS OldPI
--        ,RankingPoints * NoobModifier AS ModifiedRankingPoints 
--        ,(RankingPoints * NoobModifier) / PotentialPoints AS ModifiedPI
--FROM RankingLeaderboard ORDER BY MatchesPlayed

--SELECT PlayerId, Player, SUM(RankingPoints) AS TotalPoints , SUM(PotentialPoints) AS TotalPotentialPoints
--FROM RankingPoints 
--GROUP BY PlayerId, Player

--SELECT * FROM Handicaps ORDER BY Handicap

--/***************************************************************************************************************/
--SELECT ph.Firstname + ' ' + ph.Lastname AS HomePlayer
--    ,pa.Firstname + ' ' + pa.Lastname AS AwayPlayer
--FROM MatchResultLog ml
--    JOIN Player ph ON ml.HomePlayerId = ph.Id
--    JOIN Player pa ON ml.AwayPlayerId = pa.Id

--SELECT p.Firstname + ' ' + p.Lastname AS Player
--    ,ml.Date
--    ,s.StatusName AS MatchType
--    ,ro.Name AS Result
--    ,ro.Points AS ResultBasePoints
--    ,s.Multiplier AS MatchTypeMultiplier
--    ,ro.Points * s.Multiplier AS MatchPoints
--FROM RankingScoreLog l
--    JOIN Player p ON l.PlayerId = p.Id
--    JOIN ResultOption ro ON l.ResultOptionId = ro.Id
--    JOIN MatchStatus s ON l.MatchStatusId = s.Id
--    JOIN MatchResultLog ml ON l.MatchId = ml.Id
--ORDER BY p.Firstname, ml.Date DESC


SELECT		p.Id AS PlayerId
            ,p.Firstname + ' ' + p.Lastname AS PlayerName
            ,COUNT(m.Id) AS MatchesPlayed
            ,CASE WHEN COUNT(m.Id) < 15 
                THEN CAST(0.40 + (0.04 * COUNT(m.Id)) AS numeric(2,2))
                ELSE 1 
                END AS NoobModifier
            ,ROUND(COUNT(m.Id) / 15.00, 2) AS Part2
            ,ROUND(0.04 * COUNT(m.Id), 2) AS Part2B
            ,SUM(ro.Points * ms.Multiplier) AS RankingPoints
            ,SUM(3 * ms.Multiplier) AS PotentialPoints
            ,CASE WHEN SUM(3 * ms.Multiplier) > 60 THEN SUM(3 * ms.Multiplier) ELSE 60 END AS HandicapDenominator
FROM            dbo.Player AS p INNER JOIN
                dbo.RankingScoreLog AS r ON p.Id = r.PlayerId INNER JOIN
                dbo.MatchResultLog AS m ON r.MatchId = m.Id INNER JOIN
                dbo.ResultOption AS ro ON r.ResultOptionId = ro.Id INNER JOIN
                dbo.MatchStatus AS ms ON r.MatchStatusId = ms.Id INNER JOIN
                dbo.Player AS op ON r.OppositionPlayerId = op.Id
WHERE p.IsActive = 1
GROUP BY p.Id, p.Firstname, p.Lastname
ORDER BY COUNT(m.Id)
