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
    
    public partial class Handicap
    {
        public string Player { get; set; }
        public Nullable<int> MatchesPlayed { get; set; }
        public Nullable<decimal> RawRankingPoints { get; set; }
        public Nullable<decimal> MatchesPlayedModifier { get; set; }
        public Nullable<decimal> RankingPointsAdjusted { get; set; }
        public Nullable<decimal> TotalPotentialPoints { get; set; }
        public Nullable<decimal> OldPerformanceIndicator { get; set; }
        public Nullable<decimal> PerformanceIndicator { get; set; }
        public string OldHandicap { get; set; }
        public string Handicap1 { get; set; }
    }
}
