using System;
using System.Collections.Generic;
using System.Text;
using static ICE.Localization.L10n;

namespace ICE.Utilities.Cosmic_Helper;

public static unsafe partial class CosmicHelper
{
    public static string PlaylistOptionString(PlaylistOptions option)
    {
        if (CosmicMoonRegistry.TryGetMoonForMaxRelicOption(option, out var moon))
            return T("Max {0} Relic [Lv. {1}]", T(moon.DisplayName), moon.MaxRelicStage);

        return T(option switch
        {
            PlaylistOptions.None => "None",
            PlaylistOptions.SelectedRelicLv => "Selected Relic Level",
            PlaylistOptions.CreditAmount => "Credit Amount",
            PlaylistOptions.PlanetAmount => "Planetary Credit Amount",
            PlaylistOptions.DronebitAmount => "Planetary Dronebit Amount",
            PlaylistOptions.ClassLevel => "Class Level",
            PlaylistOptions.ClassScore => "Class Score",
            PlaylistOptions.GoldClassMissions => "All Missions Golded",
            PlaylistOptions.ToolMaxExp => "Max Tool Exp",
            _ => "???"
        });
    }
}
