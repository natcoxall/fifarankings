using FifaRankings.Data;
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
            ViewBag.Message = "The latest rankings are below.";
            using (var db = new FifaRankingsEntities())
            {
                ViewBag.RankingsLeaderboard = db.RankingLeaderboards.OrderByDescending(p => p.RankingPoints).ToList();
                ViewBag.PlayerHandicaps = db.HandicapsRoundeds.OrderBy(p => p.FinalRoundedHandicap).ToList();
            }
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
            using (var db = new FifaRankingsEntities())
            {
                ViewBag.RankingsLeaderboard = db.RankingLeaderboards.OrderByDescending(p => p.RankingPoints).ToList();
            }
            return View();
        }
    }
}