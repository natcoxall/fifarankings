//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace FifaRankings.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class RankingScoreLog
    {
        public int Id { get; set; }
        public int MatchId { get; set; }
        public int PlayerId { get; set; }
        public int ResultOptionId { get; set; }
        public int MatchStatusId { get; set; }
        public int OppositionPlayerId { get; set; }
        public int OppositionPlayerRanking { get; set; }
    
        public virtual MatchResultLog MatchResultLog { get; set; }
        public virtual MatchStatu MatchStatu { get; set; }
        public virtual Player Player { get; set; }
        public virtual Player Player1 { get; set; }
        public virtual ResultOption ResultOption { get; set; }
    }
}