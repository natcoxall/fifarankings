using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FifaRankings.ViewModels
{
    public class LogMatchViewModel
    {
        [Required(ErrorMessage = "The match date is required.")]
        [Display(Name = "Match date")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime MatchDate { get; set; }

        [Required(ErrorMessage = "The match status is required.")]
        [Display(Name = "Match status")]
        public string MatchStatusId { get; set; }

        [Required(ErrorMessage = "The home player is required.")]
        [Display(Name=  "Home player")]
        public string HomePlayerId { get; set; }

        [Required(ErrorMessage = "The home score is required.")]
        [Display(Name = "Home player's score")]
        public string HomeScore { get; set; }

        [Required(ErrorMessage = "The away player is required.")]
        [Display(Name = "Away player")]
        public string AwayPlayerId { get; set; }

        [Required(ErrorMessage = "The away score is required.")]
        [Display(Name = "Away player's score")]
        public string AwayScore { get; set; }

        [Display(Name = "Went to penalties?")]
        public bool WentToPenalties { get; set; }

        [Display(Name = "Home player's penalty score")]
        public string HomePenaltyScore { get; set; }
        
        [Display(Name = "Away player's penalty score")]
        public string AwayPenaltyScore { get; set; }

        public IEnumerable<SelectListItem> MatchStatuses { get; set; }
        public IEnumerable<SelectListItem> Players { get; set; }
        public MatchResultEnum CalculateResult(bool isHomePlayer)
        {
            if (this.WentToPenalties)
            {
                if (int.Parse(HomePenaltyScore) > int.Parse(AwayPenaltyScore))
                {
                    return isHomePlayer ? MatchResultEnum.WinOnPenalties : MatchResultEnum.LossOnPenalties;
                }
                else
                {
                    return isHomePlayer ? MatchResultEnum.LossOnPenalties : MatchResultEnum.LossOnPenalties;
                }
            }
            else
            {
                if (int.Parse(HomeScore) == int.Parse(AwayScore))
                {
                    return MatchResultEnum.Draw;
                }
                else if (int.Parse(HomeScore) > int.Parse(AwayScore))
                {
                    return isHomePlayer ? MatchResultEnum.Win : MatchResultEnum.Loss;
                }
                else
                {
                    return isHomePlayer ? MatchResultEnum.Loss : MatchResultEnum.Win;
                }
            }
        }

        public LogMatchViewModel()
        {
            this.MatchDate = DateTime.Now.Date;
        }
    }
}