using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(FifaRankings.Startup))]
namespace FifaRankings
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
