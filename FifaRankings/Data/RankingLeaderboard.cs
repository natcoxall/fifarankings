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
    
    public partial class RankingLeaderboard
    {
        public int PlayerId { get; set; }
        public string PlayerName { get; set; }
        public Nullable<int> MatchesPlayed { get; set; }
        public Nullable<decimal> NoobModifier { get; set; }
        public Nullable<decimal> RankingPoints { get; set; }
        public Nullable<decimal> PotentialPoints { get; set; }
        public Nullable<decimal> HandicapDenominator { get; set; }
    }
}
