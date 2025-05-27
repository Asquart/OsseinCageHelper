OCH = OCH or {}
local OCH = OCH

function OCH.AddonMenu()
	local menuOptions = {
		type				 = "panel",
		name				 = "Asquart's Ossein Cage Helper",
		displayName	 = "|c24abfeAsquart's Ossein Cage Helper|r",
		author			 = OCH.author,
		version			 = OCH.version,
		slashCommand = "/och",
		registerForRefresh	= true,
		registerForDefaults = true,
	}

	local dataTable = {
		{
			type = "description",
			text = "Trial timers, alerts and indicators for Ossein Cage.",
		},
		{
			type = "divider",
		},
    {
			type = "description",
			text = "For any stack/slayer/2nd boss positions markers, install |cff0000OdySupportIcons|r (optional dependency)",
		},
		{
			type = "divider",
		},
		{
			type    = "checkbox",
			name    = "Unlock UI (to move it)",
			default = false,
			getFunc = function() return OCH.unlockedUI end,
			setFunc = function( newValue ) OCH.UnlockUI(newValue) end,
		},
    {
			type    = "button",
			name    = "Reset to default position",
			func = function() OCH.DefaultPosition()  end,
      		warning = "Requires /reloadui for the position to reset",
		},
	{
			type    = "checkbox",
			name    = "Hide addon version display",
			default = false,
			getFunc = function() return OCH.savedVariables.hide_addon_version end,
			setFunc = function( newValue )
							OCH.savedVariables.hide_addon_version = newValue
							OCHStatusDivider:SetHidden(newValue)
							OCHStatusLabelAddonName:SetHidden(newValue)
						end,
		},
    {
			type    = "checkbox",
			name    = "Hide welcome text on chat",
			default = false,
			getFunc = function() return OCH.savedVariables.hideWelcome end,
			setFunc = function( newValue ) OCH.savedVariables.hideWelcome = newValue end,
		},
    {
			type = "divider",
		},
	{
		type = "header",
		name = "Caustic Carrion",
		reference = "CausticCarrionHeader"
		},
		{
			type    = "checkbox",
			name    = "Block Carrion Shield synergy after use",
			default = false,
			getFunc = function() return OCH.savedVariables.block_carrion_synergy end,
			setFunc = function( newValue ) OCH.savedVariables.block_carrion_synergy = newValue end,
			tooltip = "Will block Carrion Shield synergy for you for ~5.7 seconds(by default) after anyone in the group uses it or when noone has more than one Caustic Carrion stack"
		},
	{
		type = "slider",
		name = "Synergy block time ms",
		getFunc = function() return OCH.savedVariables.carrion_synergy_block_time end,
		setFunc = function(value) OCH.savedVariables.carrion_synergy_block_time = value end,
		min = 1000,
		max = 8000,
		default = 5700,
		step = 100,
		width = "half",
		disabled = function() return not OCH.savedVariables.block_carrion_synergy end
		},
	{
		type    = "checkbox",
		name    = "Show Carrion stacks during boss fights",
		default = false,
		getFunc = function() return OCH.savedVariables.show_boss_carrion_stacks end,
		setFunc = function( newValue ) OCH.savedVariables.show_boss_carrion_stacks = newValue end,
		},
    {
      type = "header",
      name = "Trash",
      reference = "TrashHeader"
    },
    {
			type    = "checkbox",
			name    = "Show Trash pack numbers",
			default = true,
			getFunc = function() return OCH.savedVariables.show_trash_pack_icons end,
			setFunc = function(newValue)
					OCH.savedVariables.show_trash_pack_icons = newValue
					if not newValue then
						OCH.HideTrashNumberIcons()
					end
				end,
		},
    {
			type    = "checkbox",
			name    = "Show trash stack positions",
			default = true,
			getFunc = function() return OCH.savedVariables.show_trash_stack_positions end,
			setFunc = function(newValue)
				OCH.savedVariables.show_trash_stack_positions = newValue
				if not newValue then
					OCH.HideTrashStackIcons()
				end
			end,
		},
    {
			type    = "checkbox",
			name    = "Show trash slayer stack positions",
			default = true,
			getFunc = function() return OCH.savedVariables.show_trash_slayer_positions   end,
			setFunc = function(newValue)
				OCH.savedVariables.show_trash_slayer_positions = newValue 
				if not newValue then
					OCH.HideTrashSlayerIcons()
				end
			end,
		},
    {
			type    = "checkbox",
			name    = "Show Deadraiser Spike Cage alert",
			default = true,
			getFunc = function() return OCH.savedVariables.show_deadraiser_spike_cage  end,
			setFunc = function(newValue) OCH.savedVariables.show_deadraiser_spike_cage  = newValue end,
			tooltip = "Shows alert when Spike Cage is being cast on you or a group member near you"
		},
    {
			type    = "checkbox",
			name    = "Show Deadraiser Cursed Terrain alert",
			default = true,
			getFunc = function() return OCH.savedVariables.show_deadraiser_cursed_terrain  end,
			setFunc = function(newValue) OCH.savedVariables.show_deadraiser_cursed_terrain  = newValue  end,
			tooltip = "Spams alert with sound when you step on Cursed Ground"
		},
    {
			type    = "checkbox",
			name    = "Show Deadraiser Spectral Revenant alert",
			default = true,
			getFunc = function() return OCH.savedVariables.show_deadraiser_spectral_revenant  end,
			setFunc = function(newValue) OCH.savedVariables.show_deadraiser_spectral_revenant  = newValue  end,
			tooltip = "Shows alert when Revenant is targets you"
		},
	{
		type    = "checkbox",
		name    = "Archers Taking Aim alert",
		default = true,
		getFunc = function() return OCH.savedVariables.show_osteon_archer_taking_aim  end,
		setFunc = function(newValue) OCH.savedVariables.show_osteon_archer_taking_aim  = newValue  end,
		warning = "Requires /reloadui for changes to be applied"
		},
	{
		type    = "checkbox",
		name    = "Channeler Heavy Strike alert",
		default = true,
		getFunc = function() return OCH.savedVariables.show_channeler_heavy_alert  end,
		setFunc = function(newValue) OCH.savedVariables.show_channeler_heavy_alert  = newValue  end,
		},
	{
		type    = "checkbox",
		name    = "Show Dreadful Abductor Abduct alert",
		default = true,
		getFunc = function() return OCH.savedVariables.show_abduct_cast_alert end,
		setFunc = function(newValue) OCH.savedVariables.show_abduct_cast_alert = newValue end,
		tooltip = "Shows a status panel notification when Abductor is trying to adbuct a group member or you"
		},
	{
		type    = "checkbox",
		name    = "Show Soul Devourer Detonate Soul alert",
		default = true,
		getFunc = function() return OCH.savedVariables.show_soul_devourer_detonate_soul  end,
		setFunc = function(newValue) OCH.savedVariables.show_soul_devourer_detonate_soul  = newValue  end,
		tooltip = "Shows alert when you get Detonate Soul AOE"
		},
	{
		type    = "checkbox",
		name    = "Show Soul Devourer Life Drain alert",
		default = true,
		getFunc = function() return OCH.savedVariables.show_soul_devourer_life_drain  end,
		setFunc = function(newValue) OCH.savedVariables.show_soul_devourer_life_drain  = newValue  end,
		tooltip = "Shows alert when you get Detonate Soul AOE"
		},
	{
		type    = "checkbox",
		name    = "Show Carrion Reaper Corvid Swarm alert",
		default = true,
		getFunc = function() return OCH.savedVariables.show_carrion_reaper_corvid_swarm  end,
		setFunc = function(newValue) OCH.savedVariables.show_carrion_reaper_corvid_swarm  = newValue  end,
		tooltip = "Shows alert when you step into Corvid Swarm AOE"
		},
	{
	type = "header",
	name = "Mini Bosses",
	reference = "MiniBossesHeader"
	},
	{
		type    = "checkbox",
		name    = "Show Dreadful Abductor spawn alert in trash fights",
		default = true,
		getFunc = function() return OCH.savedVariables.show_abductor_spawn end,
		setFunc = function(newValue) OCH.savedVariables.show_abductor_spawn = newValue end,
		tooltip = "Shows alert when Abductor spawns during a trash pull"
	    },
	{
			type    = "checkbox",
			name    = "Show mini boss markers",
			default = true,
			getFunc = function() return OCH.savedVariables.show_mini_boss_markers end,
			setFunc = function(newValue)
				OCH.savedVariables.show_mini_boss_markers = newValue
				if not newValue then
					OCH.HideMiniBossIcons()
				end
			end,
		},
	{
			type    = "checkbox",
			name    = "Show Gedna Relvel split countdown",
			default = true,
			getFunc = function() return OCH.savedVariables.show_witch_summon_phantasms_timer end,
			setFunc = function(newValue)
				OCH.savedVariables.show_witch_summon_phantasms_timer = newValue
				if not newValue then
					OCHStatusGednaRelvelTimerLabel:SetHidden(true)
					OCHStatusGednaRelvelTimerLabelValue:SetHidden(true)
				end
			end,
			tooltip = "Shows a status panel timer until next witch phantasm split phase"
		},
		{
			type    = "checkbox",
			name    = "Show Gedna Relvel barrage alert",
			default = true,
			getFunc = function() return OCH.savedVariables.show_witch_barrage_alert end,
			setFunc = function(newValue)
				OCH.savedVariables.show_witch_barrage_alert = newValue end,
			tooltip = "Shows when to dodge phanstasms' barrage"
		},
		{
			type    = "checkbox",
			name    = "Show Tortured Ranyu jump countdown",
			default = true,
			getFunc = function() return OCH.savedVariables.show_witch_summon_phantasms_timer end,
			setFunc = function(newValue)
				OCH.savedVariables.show_witch_summon_phantasms_timera = newValue
				if not newValue then
					OCHStatusGednaRelvelTimerLabel:SetHidden(true)
					OCHStatusGednaRelvelTimerLabelValue:SetHidden(true)
				end
			end,
			tooltip = "Shows an approximate status panel timer until next Amakos jump. Might be inaccurate"
		},
    {
      type = "header",
      name = "Hall of Fleshcraft",
      reference = "HallOfFleshcraftHeader"
    },
	{
			type    = "checkbox",
			name    = "Show Harvester spawn positions",
			default = true,
			getFunc = function() return OCH.savedVariables.show_hall_of_flesh_add_positions   end,
			setFunc = function(newValue)
				OCH.savedVariables.show_hall_of_flesh_add_positions   = newValue
				if not newValue then
					OCH.HideFleshcraftAddIcons()
				end
			end,
		},
    {
			type    = "checkbox",
			name    = "Show Abo/Harvester stack positions during the fight",
			default = true,
			getFunc = function() return OCH.savedVariables.show_hall_of_flesh_stack_positions   end,
			setFunc = function(newValue)
				OCH.savedVariables.show_hall_of_flesh_stack_positions   = newValue
				if not newValue then
					OCH.HideFleshcraftStackIcons()
				end
			end,
		},
		{
			type    = "checkbox",
			name    = "Show slayer stack positions",
			default = true,
			getFunc = function() return OCH.savedVariables.show_hall_of_flesh_slayer_positions   end,
			setFunc = function(newValue)
				OCH.savedVariables.show_hall_of_flesh_slayer_positions   = newValue
				if not newValue then
					OCH.HideFleshcraftSlayerIcons()
				end
			end,
		},
		{
			type    = "checkbox",
			name    = string.format("|u40:0::%s|u", "Use markers for Arcanist group comp"),
			default = true,
			getFunc = function() return OCH.savedVariables.show_hall_of_flesh_arcanist_positions   end,
			setFunc = function(newValue)
				OCH.savedVariables.show_hall_of_flesh_arcanist_positions   = newValue
				if OCH.savedVariables.show_hall_of_flesh_stack_positions then
					OCH.HideFleshcraftStackIcons()
					OCH.SetFleshcraftStackIcons()
				end
				if OCH.savedVariables.show_hall_of_flesh_slayer_positions then
					OCH.HideFleshcraftSlayerIcons()
					OCH.SetFleshcraftSlayerIcons()
				end
			end,
			disabled = function() return not (OCH.savedVariables.show_hall_of_flesh_slayer_positions or OCH.savedVariables.show_hall_of_flesh_stack_positions) end
		},
		{
			type    = "checkbox",
			name    = "Show Effuval Expellant block notification",
			default = true,
			getFunc = function() return OCH.savedVariables.show_effluvial_expellant_block   end,
			setFunc = function(newValue) OCH.savedVariables.show_effluvial_expellant_block   = newValue end,
			tooltip = "That nasty big meatball explosion"
		},
		{
			type    = "checkbox",
			name    = "Show Fleshspawn counter",
			default = true,
			getFunc = function() return OCH.savedVariables.show_fleshspawn_counter   end,
			setFunc = function(newValue) OCH.savedVariables.show_fleshspawn_counter   = newValue end,
			tooltip = "Shows how many fleshspawns are currently present on the arena. Might not work properly if getting pulled into ongoing fight or reloading UI mid fight"
		},
		{
			type    = "checkbox",
			name    = "Show alert when harvester targets you(if not a tank)",
			default = true,
			getFunc = function() return OCH.savedVariables.show_harvester_aggro   end,
			setFunc = function(newValue) OCH.savedVariables.show_harvester_aggro   = newValue end,
		},
		{
			type    = "checkbox",
			name    = "Show portal completion percent counter",
			default = true,
			getFunc = function() return OCH.savedVariables.show_fleshcraft_portal_percent   end,
			setFunc = function(newValue) OCH.savedVariables.show_fleshcraft_portal_percent   = newValue end,
		},
		{
			type    = "checkbox",
			name    = "Show Daedroth spawn alert(for tanks)",
			default = true,
			getFunc = function() return OCH.savedVariables.show_daedroth_spawn   end,
			setFunc = function(newValue) OCH.savedVariables.show_daedroth_spawn   = newValue end,
		},
	{
	  type = "header",
	  name = "Jynorah and Skorknif",
	  reference = "JynorahAndSkorknifHeader"
	},
		{
			type    = "checkbox",
			name    = "Show boss stack positions",
			default = true,
			getFunc = function() return OCH.savedVariables.show_jynorah_boss_positions   end,
			setFunc = function(newValue)
				OCH.savedVariables.show_jynorah_boss_positions   = newValue
				if not newValue then
					OCH.HideJynorahStackIcons()
				end
			end,
			},
		{
			type    = "checkbox",
			name    = "Show curse positions (HM)",
			default = true,
			getFunc = function() return OCH.savedVariables.show_jynorah_curse_positions   end,
			setFunc = function(newValue)
				OCH.savedVariables.show_jynorah_curse_positions   = newValue
				if not newValue then
					OCH.HideJynorahCurseIcons()
				end
			end,
		},
			{
				type    = "checkbox",
				name    = "Show percent countdown for Titanic Clash",
				default = true,
				getFunc = function() return OCH.savedVariables.show_jynorah_portal_countdown   end,
				setFunc = function(newValue) OCH.savedVariables.show_jynorah_portal_countdown   = newValue end,
			},
			{
				type    = "checkbox",
				name    = "Show Jynorah and Skorknif hp counters",
				default = true,
				getFunc = function() return OCH.savedVariables.show_jynorah_boss_hp   end,
				setFunc = function(newValue) OCH.savedVariables.show_jynorah_boss_hp   = newValue end,
			},
			{
				type    = "checkbox",
				name    = "Show titan hp counters",
				default = true,
				getFunc = function() return OCH.savedVariables.show_jynorah_titan_hp   end,
				setFunc = function(newValue) OCH.savedVariables.show_jynorah_titan_hp   = newValue end,
				warning = "WILL NOT work correctly if reloading UI or getting pulled into the fight after titans take any damage"
			},
			{
				type    = "checkbox",
				name    = "Show surge(kite) mechanic alert",
				default = true,
				getFunc = function() return OCH.savedVariables.show_jynorah_surge   end,
				setFunc = function(newValue) OCH.savedVariables.show_jynorah_surge   = newValue end,
				tooltip = "Shows alert when you get the kite mechanic"
			},
			{
				type    = "checkbox",
				name    = "Show boss swap alert after curse (HM)",
				default = true,
				getFunc = function() return OCH.savedVariables.show_jynorah_enfeeblement_swap   end,
				setFunc = function(newValue) OCH.savedVariables.show_jynorah_enfeeblement_swap   = newValue end,
				tooltip = "Shows alert for DDs what boss they should stack on after getting curse/being ressurected/after Titanic Clash ends",
				warning = "WILL NOT display swap alert if player is dead when the first curse ends"
			},
			{
				type    = "checkbox",
				name    = "Show Heat Ray start alert (HM)",
				default = true,
				getFunc = function() return OCH.savedVariables.show_jynorah_heatray   end,
				setFunc = function(newValue) OCH.savedVariables.show_jynorah_heatray   = newValue end,
				tooltip = "Shows alert for DDs and Healers to stack on a Heat Ray. Only visible to relevant people who have appropriate Enfeeblement color"
			},
			{
				type    = "checkbox",
				name    = "Show Seeking Flames alert (HM)",
				default = true,
				getFunc = function() return OCH.savedVariables.show_jynorah_seeking_surge_alert   end,
				setFunc = function(newValue) OCH.savedVariables.show_jynorah_seeking_surge_alert   = newValue end,
				tooltip = "Shows alert for DDs and Healers to go grab flame atronach Seeking Flame after it's death. Only visible to relevant people who have appropriate Enfeeblement color"
			},
    {
      type = "header",
      name = "Overfiend Kazpian",
      reference = "OverfiendKazpianHeader"
    },
    {
			type    = "checkbox",
			name    = "Show boss and add stack positions",
			default = true,
			getFunc = function() return OCH.savedVariables.show_kazpian_stack_positions  end,
			setFunc = function(newValue)
				OCH.savedVariables.show_kazpian_stack_positions  = newValue 
				if not newValue then
					OCH.HideKazpianIcons()
				end
			end,
		},
    {
			type    = "checkbox",
			name    = "Show slayer stack positions",
			default = true,
			getFunc = function() return OCH.savedVariables.show_kazpian_slayer_positions  end,
			setFunc = function(newValue)
				OCH.savedVariables.show_kazpian_slayer_positions = newValue 
				if not newValue then
					OCH.HideKazpianIcons()
				end
			end,
		},
	{
			type    = "checkbox",
			name    = "Show portal countdown",
			default = true,
			getFunc = function() return OCH.savedVariables.show_kazpian_portal_countdown   end,
			setFunc = function(newValue) OCH.savedVariables.show_kazpian_portal_countdown   = newValue  end,
		},
    {
			type    = "checkbox",
			name    = "Show Agonizer Bombs spawn alert",
			default = true,
			getFunc = function() return OCH.savedVariables.show_kazpian_bombs   end,
			setFunc = function(newValue) OCH.savedVariables.show_kazpian_bombs   = newValue  end,
		},
	{
			type    = "checkbox",
			name    = "Show Biting Blaze alert",
			default = true,
			getFunc = function() return OCH.savedVariables.show_kazpian_curse_alert   end,
			setFunc = function(newValue) OCH.savedVariables.show_kazpian_curse_alert   = newValue  end,
			tooltip = "Displays an alert 1-2 seconds before biting blaze AOEs appear for the whole group with a separate alert to stack for DDs who actually get the debuff"
		},
	{
			type    = "checkbox",
			name    = string.format("|u40:0::%s|u", "Only show Biting Blaze on you"),
			default = true,
			getFunc = function() return OCH.savedVariables.show_kazpian_curse_alert_only_player   end,
			setFunc = function(newValue) OCH.savedVariables.show_kazpian_curse_alert_only_player   = newValue  end,
			tooltip = "Only for DDs - other roles won't get the alert att all when this setting is enabled",
			disabled = function() return not OCH.savedVariables.show_kazpian_curse_alert end
		},
    {
			type    = "checkbox",
			name    = "Show chains mechanic alert",
			default = true,
			getFunc = function() return OCH.savedVariables.show_kazpian_chains   end,
			setFunc = function(newValue) OCH.savedVariables.show_kazpian_chains   = newValue  end,
			tooltip = "Shows alert for the whole group when tether mechanic starts, then shows 2nd alert if it is on you"
		},
	{
			type    = "checkbox",
			name    = "Show frenzy tank swap alert",
			default = true,
			getFunc = function() return OCH.savedVariables.show_kazpian_frenzy_alert   end,
			setFunc = function(newValue) OCH.savedVariables.show_kazpian_frenzy_alert   = newValue  end,
			tooltip = "An alert for tanks telling that they can now swap after Kazpian's Frenzy mechanic"
		},
	{
			type    = "checkbox",
			name    = "Show frenzy tank swap timer",
			default = true,
			getFunc = function() return OCH.savedVariables.show_kazpian_frenzy_timer   end,
			setFunc = function(newValue) OCH.savedVariables.show_kazpian_frenzy_timer   = newValue  end,
			tooltip = "A simple countdown for tanks after Kazpian's Frenzy mechanic to swap. Mostly suitable only for pug groups witch no voice communication",
			disabled = function() return not OCH.savedVariables.show_kazpian_frenzy_alert end
		},
	}

	LAM = LibAddonMenu2
	LAM:RegisterAddonPanel(OCH.name .. "Options", menuOptions )
	LAM:RegisterOptionControls(OCH.name .. "Options", dataTable )
end
