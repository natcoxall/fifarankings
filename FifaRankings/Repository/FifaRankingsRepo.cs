using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FifaRankings.Repository
{
    public class FifaRankingsRepo
    {
        public static IEnumerable<SelectListItem> MatchStatusesSelectList()
        {
            using (var db = new FifaRankingsContext())
            {
                return db.MatchStatus.OrderBy(x => x.StatusName).ToList().
                    Select(x => new SelectListItem()
                    {
                        Text = x.StatusName,
                        Value = x.Id.ToString()
                    });
            }
        }

        public static IEnumerable<SelectListItem> PlayersSelectList()
        {
            using (var db = new FifaRankingsContext())
            {
                return db.Players.OrderBy(p => p.Firstname).ThenBy(p => p.Lastname).ToList().
                    Select(p => new SelectListItem()
                    {
                        Text = string.Format("{0} {1}", p.Firstname, p.Lastname),
                        Value = p.Id.ToString()
                    });
            }
        }

        public static void LogMatchResult(MatchResultLog matchResult)
        {
            using (var db = new FifaRankingsContext())
            {
                db.MatchResultLogs.Add(matchResult);
                db.SaveChanges();
            }
        }

        internal static ResultOption GetResultOption(MatchResultEnum matchResultEnum)
        {
            using (var db = new FifaRankingsContext())
            {
                return db.ResultOptions.First(x => x.Id == (int)matchResultEnum);
            }
        }

        internal static void LogRankingScore(RankingScoreLog homeRankingScore)
        {
            using (var db = new FifaRankingsContext())
            {
                db.RankingScoreLogs.Add(homeRankingScore);
                db.SaveChanges();
            }
        }
    }
}