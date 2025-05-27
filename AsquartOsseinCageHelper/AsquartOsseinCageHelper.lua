OCH = OCH or {}
local OCH = OCH

OCH.name     = "AsquartOsseinCageHelper"
OCH.version  = "1.5"
OCH.author   = "|c24abfe@Asquart|r & |cbb00ff@Margorius|r"
OCH.active   = false

OCH.status = {
  verbose = false,
  currentBoss = "",
  is_Hall_of_Fleshcraft = false,
  is_hm_boss = false,
  is_normal_boss = false,
  is_jynorah_and_skorkhif = false,
  is_Gedna_Relvel = false,
  is_kazpian = false,
  is_Tortured_Ranyu = false,
  is_Blood_Drinker_Thisa = false,
  is_trash = true,
  inCombat = false,
  combat_start_time = 0,
  cast_alert_ids = {},
  abductor_cast_data = {},
  carrion_stacks_data = {},
  carrion_shield_blocked = false,
  carrion_stacks_num = 0,
  origQueueMessage = nil,

  -- Trash
  trash_numbers_enabled = false,
  trash_stacks_enabled = false,
  trash_slayers_enabled = false,
  trash_number_icons = {},
  trash_stacks_icons = {},
  trash_slayer_icons = {},
  abductor_spawned = false,
  abductor_notification_played = false,
  life_drain_alert_id = nil,
  corvid_swarm_alert_id = nil,

  -- Mini bosses
  mini_bosses_markers_enabled = false,
  mini_boss_icons = {},
  witch_last_phantasms_time = 0,
  witch_is_first_countdown = true,
  phantasmal_barrage_alert_playing = false,
  ranyu_last_jump_time = 0,
  ranyu_has_jumped = false,

  -- Hall of Fleshcraft
  fleshcraft_stacks_enabled = false,
  fleshcraft_add_markers_enabled = false,
  fleshcraft_slayers_enabled = false,
  fleshcraft_stack_icons = {},
  fleshcraft_slayer_icons = {},
  fleshcraft_add_icons = {},
  spawned_daedroths = {},
  fleshspawns_alive = {},
  channelers_alive = {},
  shapers_of_flesh = {},
  fleshcraft_portal_percent = 1,
  fleshcraft_portal_UI_hidden = false,
  initial_channeler_dead = false,
  current_channeler_max_hp = 2425644,
  current_channeler_hp = 2425644,
  harvesterAlertPlaying = false,
  num_fleshspawn = 0,
  channeler_immune = false,

  -- Jynorah and Skorkhif
  jynorah_next_portal = 0,
  jynorah_next_curse = 30,
  jynorah_stacks_enabled = false,
  jynorah_curse_markers_enabled = false,
  jynorah_titanic_clash_ongoing = false,
  jynorah_titanic_clash_just_started = false,
  jynorah_titanic_clash_just_ended = false,
  jynorah_curse_ongoing = false,
  jynorah_got_blazing_enfeeblement = false,
  jynorah_got_sparking_enfeeblement = false,
  enfeeblement_swapped_while_dead = false,
  reflective_scales_valneer_playing = false,
  reflective_scales_myrinax_playing = false,
  blazing_atronachs_alive = {},
  sparking_atronachs_alive = {},
  jynorah_blazing_surge_stacks = 0,
  jynorah_sparking_surge_stacks = 0,
  current_myrinax_hp = 100000000,
  current_valneer_hp = 100000000,
  titan_max_hp = 100000000,
  jynorah_stacks_icons = {},
  jynorah_curse_icons = {},
  valneer_id = nil,
  myrinax_id = nil,

  -- Overfiend Kazpian
  kazpian_entrance_stacks_enabled = false,
  kazpian_low_warden_stacks_enabled = false,
  kazpian_molag_kena_stacks_enabled = false,
  kazpian_krogo_stacks_enabled = false,
  kazpian_entrance_slayers_enabled = false,
  kazpian_low_warden_slayers_enabled = false,
  kazpian_molag_kena_slayers_enabled = false,
  kazpian_krogo_slayers_enabled = false,
  kazpian_entrance_stack_icons = {},
  kazpian_low_warden_stack_icons = {},
  kazpian_molag_kena_stack_icons = {},
  kazpian_krogo_stack_icons = {},
  kazpian_entrance_slayer_icons = {},
  kazpian_low_warden_slayer_icons = {},
  kazpian_molag_kena_slayer_icons = {},
  kazpian_krogo_slayer_icons = {},
  kazpian_next_portal = 0, -- Kazpian portal
  kazpian_portal_ongoing = false,
  got_link = false,
  kazpian_bombs_spawned = false,
  kazpian_curse_spawned = false,
  kazpian_new_arena_starting = false,
  kazpian_frenzy_alert_playing = false,
  kazpian_frenzy_alert_queued = false,
  kazpian_frenzy_alert_start = 0,
  is_kazpian_start_arena = true,
  is_low_warden_arena = false,
  is_molag_kena_arena = false,
  is_krogo_arena = false,
}

-- Default settings.
OCH.settings = {
  -- Trash
  show_boss_carrion_stacks = true,
  block_carrion_synergy = true,
  carrion_synergy_block_time = 5700,
  hide_addon_version = false,

  show_trash_pack_icons = false,
  show_trash_stack_positions = true,
  show_trash_slayer_positions = false,
  show_deadraiser_spike_cage = true,
  show_deadraiser_cursed_terrain = true,
  show_deadraiser_spectral_revenant = true,
  show_osteon_archer_taking_aim = true,
  show_soul_devourer_detonate_soul = true,
  show_soul_devourer_life_drain = true,
  show_carrion_reaper_corvid_swarm = true,
  show_channeler_heavy_alert = true,
  show_abduct_cast_alert = true,

  -- Mini bosses
  show_abductor_spawn = true,
  show_mini_boss_markers = false,
  show_witch_summon_phantasms_timer = true,
  show_witch_barrage_alert = true,
  show_ranyu_jump_timer = true,

  -- Hall of Fleshcraft
  show_effluvial_expellant_block = true,
  show_hall_of_flesh_stack_positions = false,
  show_hall_of_flesh_add_positions = true,
  show_hall_of_flesh_slayer_positions = false,
  show_hall_of_flesh_arcanist_positions = false,
  show_fleshspawn_counter = true,
  show_harvester_aggro = true,
  show_fleshcraft_portal_percent = true,
  show_daedroth_spawn = true,

  -- Jynorah and Skorkhif
  show_curse_countdown = true,
  show_jynorah_boss_positions = true,
  show_jynorah_curse_positions = true,
  show_jynorah_portal_countdown = true,
  show_jynorah_surge = true,
  show_jynorah_boss_hp = true,
  show_jynorah_titan_hp = true,
  show_jynorah_curse_timer = true,
  show_jynorah_heatray = true,
  show_jynorah_target_boss = true,
  show_reflective_scales_alert = true,
  show_jynorah_enfeeblement_swap = true,
  show_jynorah_seeking_surge_alert = true,

  -- Overfiend Kazpian
  show_kazpian_stack_positions = false,
  show_kazpian_slayer_positions = false,
  show_kazpian_bomb_positions = false,
  show_kazpian_frenzy_alert = true,
  show_kazpian_frenzy_timer = true,
  show_kazpian_portal_countdown = true,
  show_kazpian_chains = true,
  show_kazpian_bombs = true,
  show_kazpian_curse_alert = true,
  show_kazpian_curse_alert_only_player = true,
}

OCH.units = {}
OCH.unitsTag = {}
OCH.data    = {
  trifecta_achievement_id = 4272,

  carrion_shield_synergy_name = GetString(OCH_CarrionShield),
  carrion_shield_synergy_icon = "/esoui/art/icons/u46_tri_bp_refresh.dds",

  -- Colossus
  colossus_bone_saw = 245273,

  -- Deadraised
  deadraiser_spike_cage = 236477,
  deadraiser_cursed_terrain = 236386,
  deadraiser_cursed_terrain_debuff_id = 236571,

  spectral_revenant_toxic_ire = 160007,
  spectral_revenge_id = 236569,
  spectral_revenant_name = GetString(OCH_SpectralRevenant),

  -- Osteon Skeletal Archer
  osteon_archer_taking_aim = 239158,
  skeletal_archer_taking_aim = 239158,

  -- Tormented Soul Devourer
  soul_devourer_detonate_soul_debuff = 236778,
  soul_devourer_life_drain_debuff = 236751,

  -- Tormented Carrion Reaper
  carrion_reaper_corvid_swarm_debuff = 236947,
  carrion_reaper_corvid_swarm_cast = 236940,

  -- Dreadful abductor
  dreadful_abductor_name = GetString(OCH_Abductor),
  abduct_cast_id = 233762,
  abduct_cast_end_id = 236178,

  -- Red Witch Gedna Relvel
  gedna_relvel_name = GetString(OCH_GednaRelvel),
  phantasmal_barrage_id = 238800,
  summon_phantasms_id = 238806,
  witch_summon_phantasms_initial_countdown = 15,
  witch_summon_phantasms_consecutive_countdown = 30,

  carrion_shield_cast_ids = 
  {
    [237744] = true,
    [232748] = true,
    [232750] = true,
  },
  caustic_carrion_ids =
  {
    [240708] = true,
    [241089] = true,
  },

  -- Hall of Fleshcraft
  hall_of_fleshcraft_name = GetString(OCH_ShaperOfFlesh),
	shaper_of_flesh_effluvial_expellant = 232397,
  shaper_of_flesh_shield_id = 232511,
  fleshspawn_name = GetString(OCH_Fleshspawn),
  fleshspawn_fleshiplasm_buff_id = 231915,
  abomination_spawn_buff = 231977,
  daedroth_name = GetString(OCH_Daedroth),
  harvester_name = GetString(OCH_Harvester),
  channeler_name = GetString(OCH_Channeler),
  channeler_heavy_id = 240984,
  harvester_ethereal_burst_1 = 236466,
  harvester_ethereal_burst_2 = 236458, -- Heavy !
  channeler_hp_hm = 2425644,
  channeler_hp_vet = 1940515,
  channeler_hp_nrm = 1056203,
  fleshspawn_hp_vet = 970258,
  fleshspawn_hp_nrm = 603546,
  channeler_id = 125666,
  sinewshot_true_shot = 236381, -- small archer one-shot channeled
  channeler_coldfire_barrage = 241037,
  caustic_carrion = 240708,
  colony_collapse = 236403,

  -- Tortured Ranyu
  tortured_ranyu_name = GetString(OCH_TorturedRanyu),
  ranyu_jump_countdown = 15,
  ranyu_jump_id = 239694,

  -- Jynorah and Skorkhif
  jynorah_name = GetString(OCH_Jynorah),
  skorknif_name = GetString(OCH_Skorknif),
  valneer_name = GetString(OCH_Valneer),
  myrinax_name = GetString(OCH_Myrinax),
  jynorah_curse_initial_countdown = 30,
  jynorah_curse_initial_countdown_hm = 15,
  jynorah_curse_consecutive_countdown = 50,
  jynorah_curse_duration = 5,
  jynorah_curse_cast_id = 234000,
  skorknif_curse_cast_id = 234276,
  jynorah_searing_blaze_damage_id = 234277,
  jynorah_searing_sparks_damage_id = 234277,
  jynorah_titans_jump_hm_countdown = 5,
  jynorah_titans_jump_countdown = 10,
  jynorah_titanic_clash_id = 232516,
  skorknif_titanic_clash_id = 232517,
  jynorah_coldflame_surge = 234321, -- channeling flame breath to a furhest person
  skorknif_brimstone_surge = 234330, -- channeling flame breath to a furhest person
  jyrohan_titan_hp_nrm = 35445864,
  jyrohan_titan_hp_vet = 151360288,
  jyrohan_titan_hp_hm = 242176464,
  jynorah_clash_end_effect_id = 235868,
  jynorah_blazing_enfeeblement = 233692,
  jynorah_sparkling_enfeeblement = 233644,
  reflective_scales_valneer = 233330,
  reflective_scales_myrinax = 233321,
  jynorah_sparking_heat_ray_cast_id = 234076,
  jynorah_blazing_heat_ray_cast_id = 234150,
  jynorah_seeking_spark_surge_debuff_id = 234574,
  jynorah_seeking_forge_fire_debuff_id = 234596,
  jynorah_blazing_atronach_name = GetString(OCH_BlazingAtronach),
  jynorah_sparking_atronach_name = GetString(OCH_SparkingAtronach),

  -- Blood Drinker Thisa
  blood_drinker_thisa_name = GetString(OCH_BloodDrkinerThisa),

  -- Overfiend Kazpian
  overfiend_kazpian_name = GetString(OCH_Kazpian),
  kazpian_chains_cast = 232772,
  kazpian_chains_debuff_1 = 232773,
  kazpian_chains_debuff_2 = 232775,
  kazpian_frenzy_debuff_timer = 25,
  kazpian_frenzy_cast = 232722,
  agonizer_bomb_id = 128479,
  agonizer_bomb_name = GetString(OCH_AgonizerBomb),
  agonizing_burden_debuff_id = 237163,
  agonizing_burden_timer = 6,
  agonizer_bomb_expiration_timer = 10,
  agonizer_bomb_targeting_id = 244769,
  agonizer_bomb_spawn_cast_id = 237149,
  kazpian_curse_cast_ids =
  { 
    [246009] = true,
    [235365] = true,
  },
  low_warden_teleport_hm_timer = 20,
  low_warden_teleport_timer = 50,
  molag_kena_hm_wipe_timer = 28,
  kazpian_portal_phase_buff_id = 233591,

  hpDamageActionResults =
  {
    [ACTION_RESULT_BLOCKED_DAMAGE] = true,
    [ACTION_RESULT_PRECISE_DAMAGE] = true,
    [ACTION_RESULT_WRECKING_DAMAGE] = true,
    [ACTION_RESULT_FALL_DAMAGE] = true,
    [ACTION_RESULT_DAMAGE] = true,
    [ACTION_RESULT_CRITICAL_DAMAGE] = true,
    [ACTION_RESULT_DOT_TICK] = true,
    [ACTION_RESULT_DOT_TICK_CRITICAL] = true,
  },

  dodgeDuration = GetAbilityDuration(28549),
  maxDuration = 4000,
  ossein_cage_id = 1548,
}

function OCH.IdentifyUnit(unitTag, unitName, unitId )
  --

	if not OCH.units[unitId] then
    if (string.sub(unitTag, 1, 5) == "group" or string.sub(unitTag, 1, 6) == "player") then
      OCH.units[unitId] = {
        tag = unitTag,
        name = GetUnitDisplayName(unitTag) or unitName,
      }
      OCH.unitsTag[unitTag] = {
        id = unitId,
        name = GetUnitDisplayName(unitTag) or unitName,
      }
    end
  end

  if string.match(unitName, OCH.data.dreadful_abductor_name) then ---------- collect Abductor tag
    OCH.status.abductor_spawned = true
  end
end

-- [!] adjust label scale and draw order
function OCH.AdjustLabelForIcon(icon)
    local order = icon.ctrl:GetDrawLevel() + 1
    icon.myLabel:SetDrawLevel( order )
end

-- check if osi is active and it supports positional icons
function OCH.hasOSI()
  return OSI and OSI.CreatePositionIcon
end

function OCH.hasLC()
  return LC
end

function OCH.GetDist(x1, y1, z1, x2, y2, z2)
  local dx = x1 - x2
  local dy = y1 - y2
  local dz = z1 - z2
  return dx*dx + dy*dy + dz*dz
end

function OCH.GetChannelerHP()
  if OCH.status.is_hm_boss then
    return OCH.data.channeler_hp_hm
  elseif OCH.status.is_normal_boss then
    return OCH.data.channeler_hp_nrm
  else
    return OCH.data.channeler_hp_vet
  end
end

function OCH.GetFleshspawnHP()
  if OCH.status.is_normal_boss then
    return OCH.data.fleshspawn_hp_nrm
  else
    return OCH.data.fleshspawn_hp_vet
  end
end

function OCH.GetTitanHP()
  if OCH.status.is_hm_boss then
    return OCH.data.jyrohan_titan_hp_hm
  elseif OCH.status.is_normal_boss then
    return OCH.data.jyrohan_titan_hp_nrm
  else
    return OCH.data.jyrohan_titan_hp_vet
  end
end

function OCH.DeathState(event, unitTag, isDead)

  if unitTag == "player" and not isDead and not (IsUnitInCombat("boss1") or IsUnitInCombat("boss2") or IsUnitInCombat("boss3") or IsUnitInCombat("boss4") or IsUnitInCombat("boss5") or IsUnitInCombat("boss6")) then
    OCH.ClearUIOutOfCombat()
  end
end

function OCH.UpdateFleshspawnCounter()
  local txtNumFleshspawn = tostring(OCH.status.num_fleshspawn)
  OCHStatusFleshSpawnCounterLabelValue:SetText(txtNumFleshspawn)
  if OCH.status.num_fleshspawn == 0 then
    OCHStatusFleshSpawnCounterLabelValue:SetColor(0.125, 0.788, 0.078)
  elseif OCH.status.num_fleshspawn < 3 then
    OCHStatusFleshSpawnCounterLabelValue:SetColor(0.78, 0.513, 0.086)
  else
    OCHStatusFleshSpawnCounterLabelValue:SetColor(0.768, 0.086, 0.086)
  end
end

function OCH.CombatState(eventCode, inCombat)
  local _, maxTargetHP, _ = GetUnitPower("boss1", POWERTYPE_HEALTH)
  -- Do not change combat state if you are dead, or the boss is not full.

  -- Do not do anything outside of boss fights.
  if maxTargetHP == 0 or maxTargetHP == nil then
    -- TODO: TEST, this may break:
    OCH.ClearUIOutOfCombat()
    return
  end

  if inCombat then
    OCH.status.inCombat = true
    OCH.status.combat_start_time = GetGameTimeSeconds()

    OCHStatus:SetHidden(false)
    
    --------------------------- Gedna Relvel
    if OCH.status.is_Gedna_Relvel then
      OCH.status.witch_is_first_countdown = true
      OCH.status.witch_last_phantasms_time = OCH.status.combat_start_time
    end

    if OCH.status.is_Tortured_Ranyu then
      OCH.status.ranyu_last_jump_time = OCH.status.combat_start_time
      OCH.status.ranyu_has_jumped = false
    end

    --------------------------- Hall of Fleshcraft
    if OCH.status.is_Hall_of_Fleshcraft then
      OCH.status.fleshcraft_portal_UI_hidden = true
      OCH.status.initial_channeler_dead = false
      OCH.status.current_channeler_max_hp = OCH.GetChannelerHP()
      OCH.status.current_channeler_hp = OCH.GetChannelerHP()
      OCH.status.fleshcraft_portal_percent = 1
      OCH.status.num_fleshspawn = 0
      OCH.UpdateFleshspawnCounter()
      OCH.status.spawned_daedroths = {}
      OCH.status.fleshspawns_alive = {}
      OCH.status.channeler_immune = false
    end

    if OCH.status.is_jynorah_and_skorkhif then
      ----- Idk why buy it seems that OnBossesChanged doesn't set this up properly - so duplicate here
      local _, maxTargetHP, _ = GetUnitPower("boss1", POWERTYPE_HEALTH)
      if maxTargetHP > 37500000 then
        OCH.status.is_hm_boss = true
      elseif maxTargetHP < 37250000 then
        OCH.status.is_normal_boss = true
      end
      -- start curse timer
      if OCH.status.is_hm_boss then
        OCH.status.jynorah_next_curse = OCH.status.combat_start_time + OCH.data.jynorah_curse_initial_countdown_hm
      else
        OCH.status.jynorah_next_curse = OCH.status.combat_start_time + OCH.data.jynorah_curse_initial_countdown
      end
      OCH.status.jynorah_titanic_clash_ongoing = false
      OCH.status.jynorah_curse_ongoing = false
      OCH.status.jynorah_titanic_clash_just_started = false
      OCH.status.jynorah_titanic_clash_just_ended = false
      OCH.status.jynorah_got_blazing_enfeeblement = false
      OCH.status.jynorah_got_sparking_enfeeblement = false
      OCH.status.enfeeblement_swapped_while_dead = false
      OCH.status.reflective_scales_myrinax_playing = false
      OCH.status.reflective_scales_valneer_playing = false
      OCH.status.blazing_atronachs_alive = {}
      OCH.status.sparking_atronachs_alive = {}
      OCH.status.jynorah_blazing_surge_stacks = 0
      OCH.status.jynorah_sparking_surge_stacks = 0
      OCH.status.valneer_id = nil
      OCH.status.myrinax_id = nil
  
      OCH.status.titan_max_hp = OCH.GetTitanHP()
      OCH.status.current_myrinax_hp = OCH.status.titan_max_hp
      OCH.status.current_valneer_hp = OCH.status.titan_max_hp
      OCH.status.current_jyronah_percent = 1
      OCH.status.current_skorknif_percent = 1
      
    end

    if OCH.status.is_kazpian then
      OCH.status.kazpian_bombs_spawned = false
      OCH.status.kazpian_curse_spawned = false
      OCH.status.kazpian_new_arena_starting = false
      OCH.status.kazpian_portal_ongoing = false
      OCH.status.kazpian_frenzy_alert_queued = false
      OCH.status.kazpian_frenzy_alert_playing = false
    end
    
  else
    OCH.ClearUIOutOfCombat()
    OCH.status.abductor_spawned = false
    if OCH.status.life_drain_alert_id ~= nil then
      CombatAlerts.DisableBanner(OCH.status.life_drain_alert_id)
    end
    OCH.status.corvid_swarm_alert_id = nil
    OCH.status.life_drain_alert_id = nil
    OCH.status.abductor_notification_played = false
    OCH.status.cast_alert_ids = {}
    OCH.status.fleshspawns_alive = {}
    OCH.status.carrion_stacks_data = {}
    OCH.status.carrion_stacks_num = 0
    OCH.status.block_carrion_synergy = false
    OCH.status.inCombat = false
    OCH.status.num_fleshspawn = 0
    OCH.UpdateFleshspawnCounter()
  end
end

function OCH.ClearUIOutOfCombat()
  OCH.HideAllUI(true)
end

function OCH.HideAllUI(hide)
  OCHPurpleAlert:SetHidden(hide)
  OCHRedAlert:SetHidden(hide)
  OCHYellowAlert:SetHidden(hide)
  OCHPurpleAlertLabel:SetHidden(hide)
  OCHRedAlertLabel:SetHidden(hide)
  OCHYellowAlertLabel:SetHidden(hide)
  OCHSwapAlert:SetHidden(hide)
  OCHSwapAlertLabel:SetHidden(hide)
  OCHStatus:SetHidden(hide)
  -- Boss enrage
  OCHStatusRedWarningLabel1:SetHidden(hide)
  -- Mini enrage
  OCHStatusRedWarningLabel2:SetHidden(hide)
  -- Witch Phantasms Timer
  OCHStatusGednaRelvelTimerLabel:SetHidden(hide)
  OCHStatusGednaRelvelTimerLabelValue:SetHidden(hide)
  -- Fleshspawn counter
  OCHStatusFleshSpawnCounterLabel:SetHidden(hide)
  OCHStatusFleshSpawnCounterLabelValue:SetHidden(hide)

  -- Jynorah HP counter
  OCHStatusJynorahHpCounterLabel:SetHidden(hide)

  -- Skorknif HP counter
  OCHStatusSkorknifHpCounterLabel:SetHidden(hide)

  OCHStatusValneerHpCounterLabel:SetHidden(hide)
  OCHStatusMyrinaxHpCounterLabel:SetHidden(hide)

  -- Jynorah curse timer
  OCHStatusJynorahCurseTimerLabel:SetHidden(hide)
  OCHStatusJynorahCurseTimerLabelValue:SetHidden(hide)

  -- Boss Carrion tracker
  OCHStatusBossCarrionTrackerLabel:SetHidden(hide)
  OCHStatusBossCarrionTrackerLabelValue:SetHidden(hide)
end

function OCH.BossesChanged()

  if OCH.status.is_Hall_of_Fleshcraft then
    for i = 1, 6 do 
      local fleshBossName = GetUnitName("boss" .. tostring(i))
      if fleshBossName == OCH.status.currentBoss then
        return
      end
    end
  end

  local bossName = GetUnitName("boss1")

  if bossName ~= OCH.status.currentBoss then
    OCH.status.currentBoss = bossName
  else
    return
  end

  if OCH.data.is_jynorah_and_skorkhif then
    local secondBossName = GetUnitName("boss2")
    if secondBossName == OCH.data.skorknif_name then
      return
    end
  end

  OCH.status.is_trash = true
  OCHStatus:SetHidden(true)
  
  OCH.status.is_Gedna_Relvel = false
  OCH.status.is_Hall_of_Fleshcraft = false
  OCH.status.is_Tortured_Ranyu = false
  OCH.status.is_jynorah_and_skorkhif = false
  OCH.status.is_Blood_Drinker_Thisa = false
  OCH.status.is_kazpian = false

  OCH.status.is_normal_boss = false
  OCH.status.is_hm_boss = false

  OCH.status.carrion_stacks_data = {}
  OCH.status.carrion_stacks_num = 0
  OCH.status.block_carrion_synergy = false
  
  if string.match(bossName, OCH.data.gedna_relvel_name) then
    OCH.status.is_Gedna_Relvel = true
    OCH.status.is_trash = false
    
    OCH.SetGlobalMiniBossIcons()
    OCHStatus:SetHidden(false)
    OCHStatusGednaRelvelTimerLabel:SetHidden(false)
    OCHStatusGednaRelvelTimerLabelValue:SetHidden(false)
  end
  if string.match(bossName, OCH.data.hall_of_fleshcraft_name) then
    OCH.status.is_Hall_of_Fleshcraft = true
    local _ , maxTargetHP, _ = GetUnitPower("boss1", POWERTYPE_HEALTH)
    if maxTargetHP > 6800000 then
      OCH.status.is_hm_boss = true
    elseif maxTargetHP < 6700000 then
      OCH.status.is_normal_boss = true
    end
    OCH.status.is_trash = false
    OCH.status.initial_channeler_dead = false
    OCH.status.channeler_immune = false
    OCH.status.current_channeler_hp = OCH.GetChannelerHP()
    OCH.status.current_channeler_max_hp = OCH.GetChannelerHP()
    
    OCHStatus:SetHidden(false)
    OCHStatusFleshSpawnCounterLabel:SetHidden(not OCH.savedVariables.show_fleshspawn_counter)
    OCHStatusFleshSpawnCounterLabelValue:SetHidden(not OCH.savedVariables.show_fleshspawn_counter)
    OCH.SetHallOfFleshcraftIcons()
  end
  if string.match(bossName, OCH.data.tortured_ranyu_name) then
    OCH.status.is_Tortured_Ranyu = true
    OCH.status.is_trash = false
    OCH.SetGlobalMiniBossIcons()
  end
  if string.match(bossName, OCH.data.jynorah_name) then
    OCH.status.is_jynorah_and_skorkhif = true
    local _, maxTargetHP, _ = GetUnitPower("boss1", POWERTYPE_HEALTH)
    if maxTargetHP > 37500000 then
      OCH.status.is_hm_boss = true
    elseif maxTargetHP < 37250000 then
      OCH.status.is_normal_boss = true
    end
    OCH.status.is_trash = false
    OCHStatus:SetHidden(false)
      -- Jynorah HP counter
    OCHStatusJynorahHpCounterLabel:SetHidden(not OCH.savedVariables.show_jynorah_boss_hp)
    -- Skorknif HP counter
    OCHStatusSkorknifHpCounterLabel:SetHidden(not OCH.savedVariables.show_jynorah_boss_hp)
    -- Valneer HP counter
    OCHStatusValneerHpCounterLabel:SetHidden(not OCH.savedVariables.show_jynorah_titan_hp or OCH.status.is_normal_boss)
    -- Skorknif HP counter
    OCHStatusMyrinaxHpCounterLabel:SetHidden(not OCH.savedVariables.show_jynorah_titan_hp or OCH.status.is_normal_boss)
    -- Reset curse countdows text
    OCHStatusJynorahCurseTimerLabelValue:SetText("Pending")

    OCH.status.jynorah_titanic_clash_ongoing = false
    OCH.status.jynorah_curse_ongoing = false
    OCH.status.titan_max_hp = OCH.GetTitanHP()
    OCH.status.current_myrinax_hp = OCH.status.titan_max_hp
    OCH.status.current_valneer_hp = OCH.status.titan_max_hp
    OCH.status.jynorah_titanic_clash_just_started = false
    OCH.status.jynorah_titanic_clash_just_ended = false
    OCH.status.reflective_scales_myrinax_playing = false
    OCH.status.reflective_scales_valneer_playing = false
    OCH.status.jynorah_got_blazing_enfeeblement = false
    OCH.status.jynorah_got_sparking_enfeeblement = false
    OCH.status.enfeeblement_swapped_while_dead = false
    OCH.status.blazing_atronachs_alive = {}
    OCH.status.sparking_atronachs_alive = {}
    OCH.status.jynorah_blazing_surge_stacks = 0
    OCH.status.jynorah_sparking_surge_stacks = 0
    OCH.status.valneer_id = nil
    OCH.status.myrinax_id = nil

    OCHStatusJynorahCurseTimerLabelValue:SetHidden(not OCH.savedVariables.show_jynorah_curse_timer)
    OCHStatusJynorahCurseTimerLabel:SetHidden(not OCH.savedVariables.show_jynorah_curse_timer)
    OCH.SetJynorahIcons()
  end
  if string.match(bossName, OCH.data.blood_drinker_thisa_name) then
    OCH.status.is_Blood_Drinker_Thisa = true
    OCH.status.is_trash = false
    OCH.SetGlobalMiniBossIcons()
    OCHStatus:SetHidden(false)
    return
  end
  if string.match(bossName, OCH.data.overfiend_kazpian_name) then
    OCH.status.is_kazpian = true
    OCH.status.is_kazpian_start_arena = true
    OCH.status.is_low_warden_arena = false
    OCH.status.is_molag_kena_arena = false
    OCH.status.is_krogo_arena = false
    OCH.status.kazpian_bombs_spawned = false
    OCH.status.kazpian_curse_spawned = false
    OCH.status.kazpian_new_arena_starting = false
    OCH.status.kazpian_portal_ongoing = false
    OCH.status.kazpian_frenzy_alert_playing = false
    OCH.status.kazpian_frenzy_alert_queued = false
    local _, maxTargetHP, _ = GetUnitPower("boss1", POWERTYPE_HEALTH)
    if maxTargetHP > 78000000 then
      OCH.status.is_hm_boss = true
    end
    OCH.status.is_trash = false
    OCHStatus:SetHidden(false)
    OCH.SetKazpianIcons()
  end

  OCH.SetTrashIcons()
end

function OCH.SetupSynergiesHook()
  ZO_PreHook(SYNERGY, 'OnSynergyAbilityChanged', function()
		local name, _ = GetSynergyInfo()
		if name == OCH.data.carrion_shield_synergy_name then
      local bHidden = OCH.savedVariables.block_carrion_synergy and (OCH.status.carrion_shield_blocked or OCH.status.carrion_stacks_num < 2)
      SHARED_INFORMATION_AREA:SetHidden(SYNERGY, bHidden)
      return true
		end
	end)
end

function OCH.OnOCHPurpleAlertMove()
  OCH.savedVariables.purpleAlertLeft = OCHPurpleAlert:GetLeft()
  OCH.savedVariables.purpleAlertTop = OCHPurpleAlert:GetTop()
end

function OCH.OnOCHRedAlertMove()
  OCH.savedVariables.redAlertLeft = OCHRedAlert:GetLeft()
  OCH.savedVariables.redAlertTop = OCHRedAlert:GetTop()
end

function OCH.OnOCHYellowAlertMove()
  OCH.savedVariables.yellowAlertLeft = OCHYellowAlert:GetLeft()
  OCH.savedVariables.yellowAlertTop = OCHYellowAlert:GetTop()
end

function OCH.OnOCHSwapAlertMove()
  OCH.savedVariables.swapAlertLeft = OCHSwapAlert:GetLeft()
  OCH.savedVariables.swapAlertTop = OCHSwapAlert:GetTop()
end

function OCH.OnOCHStatusMove()
  OCH.savedVariables.statusLeft = OCHStatus:GetLeft()
  OCH.savedVariables.statusTop = OCHStatus:GetTop()
end

function OCH.DefaultPosition()
  OCH.savedVariables.purpleAlertLeft = nil
  OCH.savedVariables.purpleAlertTop = nil
  OCH.savedVariables.redAlertLeft = nil
  OCH.savedVariables.redAlertTop = nil
  OCH.savedVariables.yellowAlertLeft = nil
  OCH.savedVariables.yellowAlertTop = nil
  OCH.savedVariables.swapAlertLeft = nil
  OCH.savedVariables.swapAlertTop = nil
  OCH.savedVariables.statusLeft = nil
  OCH.savedVariables.statusTop = nil
end

function OCH.RestorePosition()
  if OCH.savedVariables.purpleAlertLeft ~= nil then
    OCHPurpleAlert:ClearAnchors()
    OCHPurpleAlert:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,
                       OCH.savedVariables.purpleAlertLeft,
                       OCH.savedVariables.purpleAlertop)
  end

  if OCH.savedVariables.redAlertLeft ~= nil then
    OCHRedAlert:ClearAnchors()
    OCHRedAlert:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,
                       OCH.savedVariables.redAlertLeft,
                       OCH.savedVariables.redAlertTop)
  end

  if OCH.savedVariables.yellowAlertLeft ~= nil then
    OCHYellowAlert:ClearAnchors()
    OCHYellowAlert:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,
                        OCH.savedVariables.yellowAlertLeft,
                        OCH.savedVariables.yellowAlertTop)
  end
  if OCH.savedVariables.swapAlertLeft ~= nil then
    OCHSwapAlert:ClearAnchors()
    OCHSwapAlert:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,
                        OCH.savedVariables.swapAlertLeft,
                        OCH.savedVariables.swapAlertTop)
  end
  if OCH.savedVariables.statusLeft ~= nil then
    OCHStatus:ClearAnchors()
    OCHStatus:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,
                       OCH.savedVariables.statusLeft,
                       OCH.savedVariables.statusTop)
  end
end

function OCH.UnlockUI(unlock)
  OCH.HideAllUI(not unlock)
  OCHPurpleAlert:SetMouseEnabled(unlock)
  OCHRedAlert:SetMouseEnabled(unlock)
  OCHYellowAlert:SetMouseEnabled(unlock)
  OCHStatus:SetMouseEnabled(unlock)
  
  OCHPurpleAlert:SetMovable(unlock)
  OCHRedAlert:SetMovable(unlock)
  OCHYellowAlert:SetMovable(unlock)
  OCHSwapAlert:SetMovable(unlock)
  OCHStatus:SetMovable(unlock)
end

function OCH.AchievementAwarded(_, _, _, id, _)
  if id == OCH.data.trifecta_achievement_id then
    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.LEVEL_UP)
    messageParams:SetQueuedOrder(10)
    messageParams:SetText(GetString(OCH_Tri1))
    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_POI_DISCOVERED)
    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)

    messageParams:SetQueuedOrder(11)
    messageParams:SetText(GetString(OCH_Tri2))
    messageParams:SetSound(SOUNDS.ENLIGHTENED_STATE_GAINED)
    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)

    messageParams:SetQueuedOrder(12)
    messageParams:SetText(GetString(OCH_Tri3))
    messageParams:SetSound(SOUNDS.ENLIGHTENED_STATE_LOST)
    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
  end
end

function OCH.OnDifficultyChanged()
  local _ , maxTargetHP, _ = GetUnitPower("boss1", POWERTYPE_HEALTH)
  if OCH.status.is_Hall_of_Fleshcraft then
    if maxTargetHP > 6800000 then
      OCH.status.is_hm_boss = true
    elseif maxTargetHP < 6700000 then
      OCH.status.is_normal_boss = true
    end
    OCH.status.current_channeler_hp = OCH.GetChannelerHP()
    OCH.status.current_channeler_max_hp = OCH.GetChannelerHP()
  end

  if OCH.status.is_jynorah_and_skorkhif then
    if maxTargetHP > 37500000 then
      OCH.status.is_hm_boss = true
      OCH.SetJynorahIcons()
    elseif maxTargetHP < 37250000 then
      OCH.status.is_normal_boss = true
    else
      OCH.status.is_hm_boss = false
      OCH.HideJynorahCurseIcons()
    end
    OCH.status.titan_max_hp = OCH.GetTitanHP()
    OCH.status.current_myrinax_hp = OCH.status.titan_max_hp
    OCH.status.current_valneer_hp = OCH.status.titan_max_hp
  end

  if OCH.status.is_kazpian then
    if maxTargetHP > 78000000 then
      OCH.status.is_hm_boss = true
    end
  end
end

function OCH.OnResurrectResult(eventCode, targetCharacterName, result, targetDisplayName)
  -- Show alert which boss to move to on being ressurected
  if not OCH.status.is_jynorah_and_skorkhif or not OCH.status.is_hm_boss or not OCH.status.inCombat then
    return
  end
  local isPlayer = targetDisplayName == GetDisplayName()
  local isDPS, _, _ = GetPlayerRoles()
  if isPlayer then
    -- Reset enfeeblement swap while dead functionality 
    OCH.status.enfeeblement_swapped_while_dead = false

    if not OCH.status.jynorah_titanic_clash_ongoing and isDPS and OCH.savedVariables.show_jynorah_enfeeblement_swap and result == RESURRECT_RESULT_SUCCESS then
    if OCH.status.jynorah_got_blazing_enfeeblement then
      CombatAlerts.Alert("", "Go to Blue Boss", 0x03AFFF, SOUNDS.CHAMPION_POINTS_COMMITTED, 3000)
    elseif OCH.status.jynorah_got_sparking_enfeeblement then
      CombatAlerts.Alert("", "Go to Red Boss", 0xCC3B0E, SOUNDS.CHAMPION_POINTS_COMMITTED, 3000)
    end
  end
  end
end

function OCH.AddToCCADodgeList()
  if CombatAlertsData == nil then
    return
  end
  CombatAlertsData.dodge.ids[OCH.data.colossus_bone_saw] = { -3, 1, false }
  if OCH.savedVariables.show_osteon_archer_taking_aim then
    CombatAlertsData.dodge.ids[OCH.data.sinewshot_true_shot] = { -3, 1, true }
    CombatAlertsData.dodge.ids[OCH.data.osteon_archer_taking_aim] = { -3, 1, true }
  end
end

function OCH.PlayerActivated()
  -- TODO: Check if the user reloaded in combat, and set it correctly.
  -- Disable all visible UI elements at startup.
  OCH.HideAllUI(true)
  OCH.UnlockUI(false)

  if GetZoneId(GetUnitZoneIndex("player")) ~= OCH.data.ossein_cage_id then
    return
  else
    OCH.units = {}
    OCH.unitsTag = {}
  end

  if not OCH.active and not OCH.savedVariables.hideWelcome then
    d(GetString(OCH_InitMSG))
    if not OCH.hasOSI() then
      d(GetString(OCH_OsiMSG))
    end
  end
  OCH.active = true
  OCHStatusLabelAddonName:SetText("Ossein Cage Helper " .. OCH.version)

  EVENT_MANAGER:UnregisterForEvent(OCH.name .. "CombatEvent", EVENT_COMBAT_EVENT )
  EVENT_MANAGER:RegisterForEvent(OCH.name .. "CombatEvent", EVENT_COMBAT_EVENT, OCH.CombatEvent )
  
  -- Bufs/debuffs
  EVENT_MANAGER:UnregisterForEvent(OCH.name .. "Buffs", EVENT_EFFECT_CHANGED )
  EVENT_MANAGER:RegisterForEvent(OCH.name .. "Buffs", EVENT_EFFECT_CHANGED, OCH.EffectChanged)
  
  -- Boss change
  EVENT_MANAGER:UnregisterForEvent(OCH.name .. "BossChange", EVENT_BOSSES_CHANGED, OCH.BossesChanged)
  EVENT_MANAGER:RegisterForEvent(OCH.name .. "BossChange", EVENT_BOSSES_CHANGED, OCH.BossesChanged)
  
  -- Combat state
  EVENT_MANAGER:UnregisterForEvent(OCH.name .. "CombatState", EVENT_PLAYER_COMBAT_STATE , OCH.CombatState)
  EVENT_MANAGER:RegisterForEvent(OCH.name .. "CombatState", EVENT_PLAYER_COMBAT_STATE , OCH.CombatState)
  
  -- Death state
  EVENT_MANAGER:UnregisterForEvent(OCH.name .. "DeathState", EVENT_UNIT_DEATH_STATE_CHANGED , OCH.DeathState)
  EVENT_MANAGER:RegisterForEvent(OCH.name .. "DeathState", EVENT_UNIT_DEATH_STATE_CHANGED , OCH.DeathState)

  -- Achievement awarded
  EVENT_MANAGER:UnregisterForEvent(OCH.name .. "AchievementAwarded", EVENT_ACHIEVEMENT_AWARDED , OCH.AchievementAwarded)
  EVENT_MANAGER:RegisterForEvent(OCH.name .. "AchievementAwarded", EVENT_ACHIEVEMENT_AWARDED , OCH.AchievementAwarded)

  -- Ressurect result
  EVENT_MANAGER:UnregisterForEvent(OCH.name .. "RessurectResult", EVENT_RESURRECT_RESULT , OCH.OnResurrectResult)
  EVENT_MANAGER:RegisterForEvent(OCH.name .. "RessurectResult", EVENT_RESURRECT_RESULT, OCH.OnResurrectResult)

    -- Hook into CSA display to get difficulty changed event
  OCH.status.origQueueMessage = CENTER_SCREEN_ANNOUNCE.QueueMessage
  CENTER_SCREEN_ANNOUNCE.QueueMessage = function(s, messageParams)
      -- Call this a second later, because sometimes the health hasn't changed yet
      EVENT_MANAGER:RegisterForUpdate(OCH.name .. "OnDificultyChanged", 1000,
                                    function()
                                      EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "OnDificultyChanged")
                                      OCH.OnDifficultyChanged()
                                    end)
      return OCH.status.origQueueMessage(s, messageParams)
  end

  -- Trigger initial "changes," in case a reload was done while at Lokk
  OCH.BossesChanged()
  OCH.OnDifficultyChanged()

  -- Ticks
  EVENT_MANAGER:RegisterForUpdate(OCH.name.."UpdateTick", 
    1000/10, function(gameTimeMs) OCH.UpdateTick(gameTimeMs) end)
end

function OCH.OnAddonLoaded( event, addonName )
	if addonName ~= OCH.name then
		return
	end

  OCH.savedVariables = ZO_SavedVars:NewAccountWide("AsquartOsseinCageHelperSavedVariables", 1, nil, OCH.settings)
  OCH.RestorePosition()
  OCH.AddonMenu()

  OCH.AddToCCADodgeList()

  OCH.SetupSynergiesHook()

  OCHStatusLabelAddonName:SetHidden(OCH.savedVariables.hide_addon_version)
  OCHStatusDivider:SetHidden(OCH.savedVariables.hide_addon_version)

	EVENT_MANAGER:UnregisterForEvent( OCH.name, EVENT_ADD_ON_LOADED )
	EVENT_MANAGER:RegisterForEvent(OCH.name .. "PlayerActive", EVENT_PLAYER_ACTIVATED,
    OCH.PlayerActivated)
end

EVENT_MANAGER:RegisterForEvent( OCH.name, EVENT_ADD_ON_LOADED, OCH.OnAddonLoaded )