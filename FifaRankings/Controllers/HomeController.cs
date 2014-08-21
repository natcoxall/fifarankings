using FifaRankings.Repository;
using FifaRankings.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FifaRankings.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult Rankings()
        {
            ViewBag.Message = "The latest rankings are below.";
            using (var db = new FifaRankingsContext())
            {
                ViewBag.RankingsLeaderboard = db.RankingLeaderboards.OrderByDescending(p => p.RankingPoints).ToList();
            }
            return View();
        }

        public ActionResult LogMatch()
        {
            ViewBag.Message = "Enter the details of the match result below";
            var model = new LogMatchViewModel();
            model.MatchStatuses = FifaRankingsRepo.MatchStatusesSelectList();
            model.Players = FifaRankingsRepo.PlayersSelectList();
            return View(model);
        }

        [HttpPost]
        public ActionResult LogMatch(LogMatchViewModel model)
        {
            if (ModelState.IsValid)
            {
                MatchResultLog matchResult = new MatchResultLog();
                matchResult.Date = model.MatchDate;
                matchResult.MatchStatusId = int.Parse(model.MatchStatusId);
                matchResult.HomePlayerId = int.Parse(model.HomePlayerId);
                matchResult.HomeScore = int.Parse(model.HomeScore);
                matchResult.AwayPlayerId = int.Parse(model.AwayPlayerId);
                matchResult.AwayScore = int.Parse(model.AwayScore);
                if (model.WentToPenalties)
                {
                    matchResult.Penalties = true;
                    matchResult.HomePenaltyScore = int.Parse(model.HomePenaltyScore);
                    matchResult.AwayPenaltyScore = int.Parse(model.AwayPenaltyScore);
                }
                FifaRankingsRepo.LogMatchResult(matchResult);

                RankingScoreLog homeRankingScore = new RankingScoreLog();
                homeRankingScore.MatchId = matchResult.Id;
                homeRankingScore.PlayerId = int.Parse(model.HomePlayerId);
                homeRankingScore.ResultOptionId = FifaRankingsRepo.GetResultOption(model.CalculateResult(true)).Id;
                homeRankingScore.MatchStatusId = int.Parse(model.MatchStatusId);
                homeRankingScore.OppositionPlayerId = int.Parse(model.AwayPlayerId);
                homeRankingScore.OppositionPlayerRanking = 0;
                FifaRankingsRepo.LogRankingScore(homeRankingScore);

                RankingScoreLog awayRankingScore = new RankingScoreLog();
                awayRankingScore.MatchId = matchResult.Id;
                awayRankingScore.PlayerId = int.Parse(model.AwayPlayerId);
                awayRankingScore.ResultOptionId = FifaRankingsRepo.GetResultOption(model.CalculateResult(false)).Id;
                awayRankingScore.MatchStatusId = int.Parse(model.MatchStatusId);
                awayRankingScore.OppositionPlayerId = int.Parse(model.HomePlayerId);
                awayRankingScore.OppositionPlayerRanking = 0;
                FifaRankingsRepo.LogRankingScore(awayRankingScore);

                model = new LogMatchViewModel();
                ViewBag.Message = "Match logged successfully";
            }
            model.MatchStatuses = FifaRankingsRepo.MatchStatusesSelectList();
            model.Players = FifaRankingsRepo.PlayersSelectList();
            return View(model);
        }
    }
}