OCH = OCH or {}
local OCH = OCH

function OCH.CombatEvent(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId, overflow)

  local isDPS, isHeal, isTank = GetPlayerRoles()
  
    -------------------- Caustic carrion purge
    if result == ACTION_RESULT_EFFECT_GAINED and OCH.data.carrion_shield_cast_ids[abilityId] then
      OCH.status.carrion_stacks_data = {}
      if OCH.savedVariables.block_carrion_synergy then
        OCH.status.carrion_shield_blocked = true
        EVENT_MANAGER:RegisterForUpdate(OCH.name .. "ResetCarrionBlock", OCH.savedVariables.carrion_synergy_block_time,
            function()
              EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "ResetCarrionBlock")
              OCH.status.carrion_shield_blocked = false
            end)
      end
    end

    --d(abilityName .. " " .. tostring(abilityId))

    -------------------- Remove dead people from carrion tracking
    if OCH.savedVariables.show_boss_carrion_stacks and (result == ACTION_RESULT_DIED or result == ACTION_RESULT_DIED_XP) and OCH.status.carrion_stacks_data[targetUnitId] ~= nil then
      OCH.status.carrion_stacks_data[targetUnitId] = nil
    end

  --------------- Trash alerts
  ---------------------------------- Spike Cage alert
  if result == ACTION_RESULT_BEGIN and abilityId == OCH.data.deadraiser_spike_cage and OCH.savedVariables.show_deadraiser_spike_cage then
    if targetUnitId ~= nil and OCH.units[targetUnitId] ~= nil then
      local unitTag = OCH.units[targetUnitId].tag
      local _, unitX, unitY, unitZ = GetUnitWorldPosition(unitTag)
      local _, playerX, playerY, playerZ = GetUnitRawWorldPosition("player")
      local distance = OCH.GetDist(unitX,unitY,unitZ,playerX,playerY,playerZ)
      if distance < 400 then
        CombatAlerts.Alert("", "Spike Cage !", 0xFF0000FF, SOUNDS.DUEL_START, 3000)
      end
    end
  end

  if string.match(sourceName, OCH.data.spectral_revenant_name) ~= nil and targetType == COMBAT_UNIT_TYPE_PLAYER and OCH.savedVariables.show_deadraiser_spectral_revenant then
    OCHStatus:SetHidden(false)
    OCHStatusRedWarningLabel2:SetText("REVENANT ON YOU!")
    OCHStatusRedWarningLabel2:SetHidden(false)
    EVENT_MANAGER:RegisterForUpdate(OCH.name .. "HideRevenantText", 3000,
                                    function()
                                      EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "HideRevenantText")
                                      OCHStatus:SetHidden(true)
                                      OCHStatusRedWarningLabel2:SetHidden(true)
                                    end)
  end

  if abilityId == OCH.data.spectral_revenge_id and result == ACTION_RESULT_BEGIN and targetType == COMBAT_UNIT_TYPE_PLAYER and OCH.savedVariables.show_deadraiser_spectral_revenant then
    OCHRedAlertLabel:SetText("DODGE REVENANT!")
    PlaySound(SOUNDS.DUEL_START)
    CombatAlerts.AlertCast(abilityId, "" , 1650, { -2, 2 } )
    OCHRedAlertLabel:SetHidden(false)
    OCHRedAlert:SetHidden(false)
    EVENT_MANAGER:RegisterForUpdate(OCH.name .. "HideRevenantDodgeText", 2000,
                                    function()
                                   EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "HideRevenantDodgeText")
                                   OCHRedAlertLabel:SetHidden(true)
                                   OCHRedAlert:SetHidden(true)
                                    end)
  end

  if abilityId == OCH.data.channeler_heavy_id and result == ACTION_RESULT_BEGIN and targetType == COMBAT_UNIT_TYPE_PLAYER and OCH.savedVariables.show_channeler_heavy_alert then
    if not isTank then
      PlaySound(SOUNDS.DUEL_START)
    end
    CombatAlerts.AlertCast(abilityId, "Heavy Strike" , 1400, { -2, 2 } )
  end

  ------------------------------- Abductor alerts
  if result == ACTION_RESULT_BEGIN and abilityId == OCH.data.abduct_cast_id and OCH.savedVariables.show_abduct_cast_alert then
    OCH.status.abductor_cast_data[sourceUnitId] = true
    OCHStatus:SetHidden(false)
    OCHStatusRedWarningLabel2:SetText("Bash Abductor!")
    OCHStatusRedWarningLabel2:SetHidden(false)
    PlaySound(SOUNDS.DUEL_START)
    EVENT_MANAGER:RegisterForUpdate(OCH.name .. "AbductEnded", 9000,
                                    function()
                                    EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "AbductEnded")
                                    if OCH.status.abductor_cast_data[sourceUnitId] ~= nil then
                                      OCH.status.abductor_cast_data[sourceUnitId] = nil
                                      OCHStatus:SetHidden(true)
                                      OCHStatusRedWarningLabel2:SetHidden(true)
                                    end
                                    end)
  end

  if result == ACTION_RESULT_DIED or result == ACTION_RESULT_STUNNED or result == ACTION_RESULT_INTERRUPT or result == ACTION_RESULT_DIED_XP then
    if OCH.status.abductor_cast_data[targetUnitId] ~= nil then
      OCHStatus:SetHidden(true)
      OCHStatusRedWarningLabel2:SetHidden(true)
      OCH.status.abductor_cast_data[targetUnitId] = nil
    end
  end

  -------------------------- Abducted
  if result == ACTION_RESULT_BEGIN and abilityId == OCH.data.abduct_cast_end_id then
    if OCH.status.abductor_cast_data[sourceUnitId] ~= nil then
      OCH.status.abductor_cast_data[sourceUnitId] = nil
      OCHStatus:SetHidden(true)
      OCHStatusRedWarningLabel2:SetHidden(true)
    end
  end

  ------------ TO REMOVE after making sure CCA dodgelist works properly
  -------------------------------- Archer Alerts
  -- if (abilityId == OCH.data.osteon_archer_taking_aim or abilityId == OCH.data.skeletal_archer_taking_aim) and targetType == COMBAT_UNIT_TYPE_PLAYER and result == ACTION_RESULT_BEGIN and OCH.savedVariables.show_osteon_archer_taking_aim then
  --   OCH.status.cast_alert_ids[sourceUnitId] = CombatAlerts.AlertCast(abilityId, "Taking Aim" , 9000, { -3, 1, true } )
  -- end

  -- if abilityId == OCH.data.sinewshot_true_shot and targetType == COMBAT_UNIT_TYPE_PLAYER and result == ACTION_RESULT_BEGIN and OCH.savedVariables.show_osteon_archer_taking_aim then
  --   OCH.status.cast_alert_ids[sourceUnitId] = CombatAlerts.AlertCast(abilityId, "True Shot" , 7000, { -3, 1, true } )
  -- end
  -------------------------------- Archer Alerts

  -------------------- Remove interrupted cast alerts
  if result == ACTION_RESULT_DIED or result == ACTION_RESULT_STUNNED or result == ACTION_RESULT_INTERRUPT or result == ACTION_RESULT_DIED_XP then
    if OCH.status.cast_alert_ids[targetUnitId] ~= nil then
      CombatAlerts.CastAlertsStop(OCH.status.cast_alert_ids[targetUnitId])
      OCH.status.cast_alert_ids[targetUnitId] = nil
    end
  end
  
  --------------- Gedna Relvel
  if OCH.status.is_Gedna_Relvel then
    ------------------ reset phantasms phase
    if result == ACTION_RESULT_EFFECT_FADED and abilityId == OCH.data.summon_phantasms_id then
      OCH.status.witch_is_first_countdown = false
      OCH.status.witch_last_phantasms_time = GetGameTimeSeconds()
    end

    --------------------------- barrage alert
    if result == ACTION_RESULT_BEGIN and abilityId == OCH.data.phantasmal_barrage_id then
      if not OCH.status.phantasmal_barrage_alert_playing then 
        OCH.status.phantasmal_barrage_alert_playing = true
        CombatAlerts.AlertCast(abilityId, "Phantasmal Barrage", 2000, { -3, 1, true })
        EVENT_MANAGER:RegisterForUpdate(OCH.name .. "PhantasmalBarrageEnded", 3000,
                                    function()
                                    EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "PhantasmalBarrageEnded")
                                    OCH.status.phantasmal_barrage_alert_playing = false
                                    end)
      end
    end
  end

  --------------- Tortured Ranyu
  if OCH.status.is_Tortured_Ranyu then
    ------------------ reset jump_timer
    if result == ACTION_RESULT_BEGIN and abilityId == OCH.data.ranyu_jump_id then
      OCH.status.ranyu_has_jumped = true
    end
  end

  ------------------------------------ Hall of Fleshcraft ----------------------------------------

  if OCH.status.is_Hall_of_Fleshcraft then

    --------------------------- Play Harvester alert
    if result == ACTION_RESULT_BEGIN and targetType == COMBAT_UNIT_TYPE_PLAYER and string.match(sourceName, OCH.data.harvester_name) ~= nil
      and (abilityId == OCH.data.harvester_ethereal_burst_1 or abilityId == OCH.data.harvester_ethereal_burst_2)
      and OCH.savedVariables.show_harvester_aggro
      and not OCH.status.harvesterAlertPlaying then

      if abilityId == OCH.data.harvester_ethereal_burst_2 then
        CombatAlerts.AlertCast(abilityId, "Potent Ethereal Burst" , 1500, { -3, 1, true} )
      end
      if isDPS or isHeal then
        OCH.status.harvesterAlertPlaying = true
        OCHRedAlertLabel:SetText("HARVESTER ATTACKS YOU!")
        OCHRedAlertLabel:SetHidden(false)
        OCHRedAlert:SetHidden(false)
        EVENT_MANAGER:RegisterForUpdate(OCH.name .. "HideHarvesterText", 2500,
                                        function()
                                        EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "HideHarvesterText")
                                        OCHRedAlertLabel:SetHidden(true)
                                        OCHRedAlert:SetHidden(true)
                                        OCH.status.harvesterAlertPlaying = false
                                        end)
      end
    end

    ------------- gather fleshspawns
    if OCH.status.show_fleshspawn_counter and string.match(targetName, OCH.data.fleshspawn_name) then
      if OCH.status.fleshspawns_alive[targetUnitId] == nil then
        OCH.status.fleshspawns_alive[targetUnitId] = true
      end
    end
    if OCH.status.show_fleshspawn_counter and string.match(sourceName, OCH.data.fleshspawn_name) then
      if OCH.status.fleshspawns_alive[sourceUnitId] == nil then
        OCH.status.fleshspawns_alive[sourceUnitId] = true
      end
    end

    ------------- gather channelers
    if OCH.savedVariables.show_fleshcraft_portal_percent and string.match(targetName, OCH.data.channeler_name) then
      if OCH.status.channelers_alive[targetUnitId] == nil then
        OCH.status.channelers_alive[targetUnitId] = OCH.GetChannelerHP()
      end
    end
    if OCH.savedVariables.show_fleshcraft_portal_percent and string.match(sourceName, OCH.data.channeler_name) then
      if OCH.status.channelers_alive[sourceUnitId] == nil then
        OCH.status.channelers_alive[sourceUnitId] = OCH.GetChannelerHP()
      end
    end
    
    ------------- gather daedroths
    if OCH.savedVariables.show_daedroth_spawn and string.match(sourceName, OCH.data.daedroth_name) ~= nil then
      if OCH.status.spawned_daedroths[sourceUnitId] == nil and isTank then
        OCH.status.spawned_daedroths[sourceUnitId] = true
        CombatAlerts.Alert("", "Daedroth Spawned !", 0xFF0000FF, SOUNDS.CHAMPION_POINTS_COMMITTED, 3000)
      end
    end

    if OCH.savedVariables.show_daedroth_spawn and isTank and string.match(targetName, OCH.data.daedroth_name) ~= nil then
      if OCH.status.spawned_daedroths[targetUnitId] == nil then
        OCH.status.spawned_daedroths[targetUnitId] = true
        CombatAlerts.Alert("", "Daedroth Spawned !", 0xFF0000FF, SOUNDS.CHAMPION_POINTS_COMMITTED, 3000)
      end
    end

    if OCH.savedVariables.show_fleshspawn_counter and result ~= ACTION_RESULT_EFFECT_GAINED and abilityId == OCH.data.abomination_spawn_buff then --------------- Abo spawned. Fires twice per abo spawn for some reason
      OCH.status.num_fleshspawn = OCH.status.num_fleshspawn - 1
      if OCH.status.num_fleshspawn < 0 then
        OCH.status.num_fleshspawn = 0
      end
      OCH.UpdateFleshspawnCounter()
    end

    if OCH.savedVariables.show_fleshspawn_counter and result == ACTION_RESULT_EFFECT_GAINED and abilityId == OCH.data.fleshspawn_fleshiplasm_buff_id then --------------- Fleshiplasm gained
    if OCH.status.fleshspawns_alive[targetUnitId] == nil then
        OCH.status.fleshspawns_alive[targetUnitId] = OCH.GetFleshspawnHP()
        OCH.status.num_fleshspawn = OCH.status.num_fleshspawn + 1
        OCH.UpdateFleshspawnCounter()
      end
    end

    if OCH.savedVariables.show_fleshspawn_counter and (result == ACTION_RESULT_DIED or result == ACTION_RESULT_DIED_XP) and OCH.status.fleshspawns_alive[targetUnitId] ~= nil then -------------- Fleshspawn died
      OCH.status.fleshspawns_alive[targetUnitId] = nil
      OCH.status.num_fleshspawn = OCH.status.num_fleshspawn - 1
      if OCH.status.num_fleshspawn < 0 then
        OCH.status.num_fleshspawn = 0
      end
      OCH.UpdateFleshspawnCounter()
    end
    

    ---------------------------- Accumulate Channeler damage
    if OCH.savedVariables.show_fleshcraft_portal_percent
      and not OCH.status.channeler_immune
      and OCH.status.channelers_alive[targetUnitId] ~= nil
      and OCH.data.hpDamageActionResults[result] ~= nil then

      OCH.status.channelers_alive[targetUnitId] = OCH.status.channelers_alive[targetUnitId] - hitValue
      OCH.status.fleshcraft_portal_percent = OCH.status.channelers_alive[targetUnitId] / OCH.status.current_channeler_max_hp

      if OCH.status.channelers_alive[targetUnitId] <= 0 then --------------- Channeler died

      end
    end

    if OCH.savedVariables.show_fleshcraft_portal_percent and (result == ACTION_RESULT_DIED or result == ACTION_RESULT_DIED_XP) and OCH.status.channelers_alive[targetUnitId] ~= nil then
      OCH.status.channelers_alive[targetUnitId] = nil
      if not OCH.status.initial_channeler_dead then
        OCH.status.initial_channeler_dead = true
        OCH.status.channeler_immune = true
        OCH.status.current_channeler_hp = OCH.GetChannelerHP()
        OCH.status.fleshcraft_portal_percent = 1
        OCH.status.channelers_alive[targetUnitId] = nil
        OCHStatusRedWarningLabel1:SetHidden(true)
        EVENT_MANAGER:RegisterForUpdate(OCH.name .. "RemoveChannelerImmune", 4000,
                                      function()
                                      EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "RemoveChannelerImmune")
                                      OCH.status.channeler_immune = false
                                      end)
      else
        OCHStatusRedWarningLabel1:SetHidden(true)
        OCH.status.fleshcraft_portal_UI_hidden = true
        OCH.status.channeler_immune = true
        OCH.status.current_channeler_hp = OCH.GetChannelerHP()
        OCH.status.fleshcraft_portal_percent = 1
        OCH.status.channelers_alive[targetUnitId] = nil
        OCHStatusRedWarningLabel2:SetHidden(false)
        OCHStatusRedWarningLabel2:SetText("Portal Done !")
        PlaySound(SOUNDS.OBJECTIVE_DISCOVERED)
        EVENT_MANAGER:RegisterForUpdate(OCH.name .. "RemovePortalDone", 4000,
                                      function()
                                      EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "RemovePortalDone")
                                      OCHStatusRedWarningLabel2:SetHidden(true)
                                      OCH.status.channeler_immune = false
                                      end)
        EVENT_MANAGER:RegisterForUpdate(OCH.name .. "RemoveChannelerImmune", 4000,
                                      function()
                                      EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "RemoveChannelerImmune")
                                      OCH.status.channeler_immune = false
                                      end)
      end
    end

    --------------------------- Play Expellant alert
    if OCH.savedVariables.show_effluvial_expellant_block and result == ACTION_RESULT_BEGIN and abilityId == OCH.data.shaper_of_flesh_effluvial_expellant then
      OCHPurpleAlert:SetHidden(false)
      OCHPurpleAlertLabel:SetHidden(false)
      OCHPurpleAlertLabel:SetText("Expellant Block!")
      PlaySound(SOUNDS.DUEL_START)
      EVENT_MANAGER:RegisterForUpdate(OCH.name .. "HideExpellantText", 2500,
                                        function()
                                        EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "HideExpellantText")
                                        OCHPurpleAlert:SetHidden(true)
                                        end)
    end

  end
  ------------------------------------ Hall of Fleshcraft ----------------------------------------

  ------------------------------------ Jynorah and Skorknif --------------------------------------
  if OCH.status.is_jynorah_and_skorkhif then

    ------------------------------ Curse Cast
    if (abilityId == OCH.data.jynorah_curse_cast_id or abilityId == OCH.data.skorknif_curse_cast_id) and not OCH.status.jynorah_curse_ongoing then
      OCH.status.jynorah_curse_ongoing = true
      OCH.status.jynorah_next_curse = GetGameTimeSeconds() + OCH.data.jynorah_curse_consecutive_countdown
      PlaySound(SOUNDS.DUEL_START)
      OCHRedAlertLabel:SetText("Curse !")
      OCHRedAlertLabel:SetHidden(false)
      OCHRedAlert:SetHidden(false)
      ---------------- remove alert
      EVENT_MANAGER:RegisterForUpdate(OCH.name .. "HideCurseAlert", 3000,
                                  function()
                                   EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "HideCurseAlert")
                                   OCHRedAlertLabel:SetHidden(true)
                                   OCHRedAlert:SetHidden(true)
                                  end)
      ------------------- set curse ongoing to false
      EVENT_MANAGER:RegisterForUpdate(OCH.name .. "SetCurseEnded", 9000,
                                  function()
                                   EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "SetCurseEnded")
                                   OCH.status.jynorah_curse_ongoing = false
                                  end)
    end

    ------------------------------ Titanic Clash start
    if (abilityId == OCH.data.jynorah_titanic_clash_id or abilityId == OCH.data.skorknif_titanic_clash_id) and not OCH.status.jynorah_titanic_clash_ongoing then
      OCH.status.jynorah_titanic_clash_ongoing = true
      OCH.status.jynorah_titanic_clash_just_started = true
      OCH.status.blazing_atronachs_alive = {}
      OCH.status.sparking_atronachs_alive = {}
      OCH.status.jynorah_blazing_surge_stacks = 0
      OCH.status.jynorah_sparking_surge_stacks = 0

      if OCH.savedVariables.show_boss_carrion_stacks then
        OCHStatusBossCarrionTrackerLabel:SetHidden(false)
        OCHStatusBossCarrionTrackerLabelValue:SetHidden(false)
      end

      OCHStatusJynorahCurseTimerLabel:SetHidden(true)
      OCHStatusJynorahCurseTimerLabelValue:SetHidden(true)

      ------------------- set curse ongoing to false
      EVENT_MANAGER:RegisterForUpdate(OCH.name .. "ResetTitanicClashStart", 10000,
            function()
              EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "ResetTitanicClashStart")
              OCH.status.jynorah_titanic_clash_just_started = false
            end)

      OCHYellowAlert:SetHidden(false)
      OCHYellowAlertLabel:SetHidden(false)
      if OCH.status.current_jyronah_percent > OCH.status.current_skorknif_percent then
        OCHYellowAlertLabel:SetColor(0.909,0.494,0.082,0.85)
        OCHYellowAlertLabel:SetText("Skorknif & Valneer lose")
      else
        OCHYellowAlertLabel:SetColor(0.141,0.141,0.788,0.85)
        OCHYellowAlertLabel:SetText("Jyronah & Myrinax lose")
      end
      EVENT_MANAGER:RegisterForUpdate(OCH.name .. "HideLoseAlert", 4000,
                                  function()
                                    EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "HideLoseAlert")
                                    OCHYellowAlertLabel:SetHidden(true)
                                    OCHYellowAlertLabel:SetColor(0.929,0.835,0.101,0.85)
                                  end)
    end

    --------------------------- Titanic Clash end ----------------- moved to EffectChanged()
    if OCH.status.jynorah_titanic_clash_ongoing
      and not OCH.status.jynorah_titanic_clash_just_started
      and OCH.data.hpDamageActionResults[result] ~= nil
      and (string.match(targetName, OCH.data.jynorah_name) ~= nil or string.match(targetName, OCH.data.skorknif_name) ~= nil) then

      OCH.status.jynorah_titanic_clash_ongoing = false

      -------- start curse countdows
      OCH.status.jynorah_next_curse = GetGameTimeSeconds() + OCH.data.jynorah_curse_initial_countdown
      -------- restore curse labels
      if OCH.savedVariables.show_jynorah_curse_timer then
        OCHStatusJynorahCurseTimerLabelValue:SetHidden(false)
        OCHStatusJynorahCurseTimerLabel:SetHidden(false)
      end
      
      OCHStatusBossCarrionTrackerLabel:SetHidden(true)
      OCHStatusBossCarrionTrackerLabelValue:SetHidden(true)
    end

    -------------------- Surge alert
    if targetType == COMBAT_UNIT_TYPE_PLAYER and result == ACTION_RESULT_BEGIN then
      if abilityId == OCH.data.jynorah_coldflame_surge then
        CombatAlerts.Alert("", "Surge, Kite !", 0x3399FFD9, SOUNDS.DUEL_START, 3000)
      elseif abilityId == OCH.data.skorknif_brimstone_surge then
        CombatAlerts.Alert("", "Surge, Kite !", 0xFF5733D9, SOUNDS.DUEL_START, 3000)
      end
    end

    if OCH.status.is_hm_boss then

      ----------------------- Reflective Scales alerts
      if not OCH.status.reflective_scales_valneer_playing and abilityId == OCH.data.reflective_scales_valneer and targetType == COMBAT_UNIT_TYPE_PLAYER then
        OCH.status.reflective_scales_valneer_playing = true
        CombatAlerts.Alert(nil, "Reflective Scales", 0xFF5733D9, nil, hitValue, 2500)
        LibCombatAlerts.PlaySounds("SCRYING_ACTIVATE_BOMB", 10, nil)
        EVENT_MANAGER:RegisterForUpdate(OCH.name .. "ResetReflectValneer", 2500,
                                    function()
                                      EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "ResetReflectValneer")
                                      OCH.status.reflective_scales_valneer_playing = false
                                    end)
      end
  
      if not OCH.status.reflective_scales_myrinax_playing and abilityId == OCH.data.reflective_scales_myrinax and targetType == COMBAT_UNIT_TYPE_PLAYER then
        OCH.status.reflective_scales_myrinax_playing = true
        CombatAlerts.Alert(nil, "Reflective Scales", 0x3399FFD9, nil, hitValue, 2500)
        LibCombatAlerts.PlaySounds("SCRYING_ACTIVATE_BOMB", 10, nil)
        EVENT_MANAGER:RegisterForUpdate(OCH.name .. "ResetReflectMyrinax", 2500,
                                    function()
                                      EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "ResetReflectMyrinax")
                                      OCH.status.reflective_scales_myrinax_playing = false
                                    end)
      end

      ------------------------------ Heatray Alerts
      if OCH.savedVariables.show_jynorah_heatray and abilityId == OCH.data.jynorah_blazing_heat_ray_cast_id and result == ACTION_RESULT_BEGIN and not isTank and not OCH.status.jynorah_got_blazing_enfeeblement then
        CombatAlerts.Alert(nil, "Heat Ray, Stack!", 0xCC3B0E, SOUNDS.CHAMPION_POINTS_COMMITTED, hitValue, 4000)
      end

      if OCH.savedVariables.show_jynorah_heatray and abilityId == OCH.data.jynorah_sparking_heat_ray_cast_id and result == ACTION_RESULT_BEGIN and not isTank and not OCH.status.jynorah_got_sparking_enfeeblement then
        CombatAlerts.Alert(nil, "Heat Ray, Stack!", 0x03AFFF, SOUNDS.CHAMPION_POINTS_COMMITTED, hitValue, 4000)
      end

      ------------------------------- Process atronachs and seeking surge
      if OCH.savedVariables.show_jynorah_seeking_surge_alert then
        
        if not OCH.status.jynorah_titanic_clash_ongoing then -------------- Only gather new atros outside of the titanic clash phase
          if string.match(sourceName, OCH.data.jynorah_blazing_atronach_name)  then
            if OCH.status.blazing_atronachs_alive[sourceUnitId] == nil then
              OCH.status.blazing_atronachs_alive[sourceUnitId] = true
            end
          end
          if string.match(targetName, OCH.data.jynorah_blazing_atronach_name)  then
            if OCH.status.blazing_atronachs_alive[targetUnitId] == nil then
              OCH.status.blazing_atronachs_alive[targetUnitId] = true
            end
          end
          if string.match(sourceName, OCH.data.jynorah_sparking_atronach_name)  then
            if OCH.status.sparking_atronachs_alive[sourceUnitId] == nil then
              OCH.status.sparking_atronachs_alive[sourceUnitId] = true
            end
          end
          if string.match(targetName, OCH.data.jynorah_sparking_atronach_name)  then
            if OCH.status.sparking_atronachs_alive[targetUnitId] == nil then
              OCH.status.sparking_atronachs_alive[targetUnitId] = true
            end
          end

          if (result == ACTION_RESULT_DIED or result == ACTION_RESULT_DIED_XP) -------------- Blazing atro died
            and OCH.status.blazing_atronachs_alive[targetUnitId] ~= nil then
            OCH.status.blazing_atronachs_alive[targetUnitId] = nil ------------- remove atro from table
            if not OCH.status.jynorah_got_blazing_enfeeblement and not isTank and OCH.status.jynorah_blazing_surge_stacks < 4 then ---------------- play alert if applicable
              CombatAlerts.Alert(nil, "Get Seeking Fire", 0xCC3B0E, SOUNDS.CHAMPION_POINTS_COMMITTED, hitValue, 2500)
            end
          end

          if (result == ACTION_RESULT_DIED or result == ACTION_RESULT_DIED_XP) -------------- Sparking atro died
            and OCH.status.sparking_atronachs_alive[targetUnitId] ~= nil then
            OCH.status.sparking_atronachs_alive[targetUnitId] = nil ------------- remove atro from table
            if not OCH.status.jynorah_got_sparking_enfeeblement and not isTank and OCH.status.jynorah_sparking_surge_stacks < 4 then ---------------- play alert if applicable
              CombatAlerts.Alert(nil, "Get Seeking Fire", 0x03AFFF, SOUNDS.CHAMPION_POINTS_COMMITTED, hitValue, 2500)
            end
          end
        end
      end

    end
   
    ----------------------------- Gather titans IDs
    if OCH.savedVariables.show_jynorah_titan_hp then
      if OCH.status.myrinax_id == nil then
        if string.match(sourceName, OCH.data.myrinax_name) then
          OCH.status.myrinax_id = sourceUnitId
        elseif string.match(targetName, OCH.data.myrinax_name) then
          OCH.status.myrinax_id = targetUnitId
        end
      end
      if OCH.status.valneer_id == nil then
        if string.match(sourceName, OCH.data.valneer_name) then
          OCH.status.valneer_id = sourceUnitId
        elseif string.match(targetName, OCH.data.valneer_name) then
          OCH.status.valneer_id = targetUnitId
        end
      end
    end

    --------------------- Accumulate Valneer Damage
    if OCH.savedVariables.show_jynorah_titan_hp
      and targetUnitId == OCH.status.valneer_id
      and OCH.data.hpDamageActionResults[result] ~= nil then
      OCH.status.current_valneer_hp = OCH.status.current_valneer_hp - hitValue
      if OCH.status.current_valneer_hp < 0 then
        OCH.status.current_valneer_hp = 0
      end
    end

        --------------------- Accumulate Myrinax Damage
    if OCH.savedVariables.show_jynorah_titan_hp
      and targetUnitId == OCH.status.myrinax_id
      and OCH.data.hpDamageActionResults[result] ~= nil then
      OCH.status.current_myrinax_hp = OCH.status.current_myrinax_hp - hitValue
      if OCH.status.current_myrinax_hp < 0 then
        OCH.status.current_myrinax_hp = 0
      end
    end

  end
  ------------------------------------ Jynorah and Skorknif --------------------------------------

  ------------------------------------- Overfiend Kazpian -----------------------------------------
  if OCH.status.is_kazpian then

    ---------------------- agonizer bomb spawn
    if not OCH.status.kazpian_bombs_spawned and abilityId == OCH.data.agonizer_bomb_spawn_cast_id and OCH.savedVariables.show_kazpian_bombs then
      OCH.status.kazpian_bombs_spawned = true
      OCHYellowAlertLabel:SetText("Bombs spawned")
      OCHYellowAlertLabel:SetHidden(false)
      OCHYellowAlert:SetHidden(false)
      PlaySound(SOUNDS.CHAMPION_POINTS_COMMITTED)
      EVENT_MANAGER:RegisterForUpdate(OCH.name .. "HideBombsAlert", 3000,
                                  function()
                                   EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "HideBombsAlert")
                                   OCHYellowAlertLabel:SetHidden(true)
                                   OCHYellowAlert:SetHidden(true)
                                  end)
      EVENT_MANAGER:RegisterForUpdate(OCH.name .. "ResetBombsSpawn", 20000,
                                  function()
                                    EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "ResetBombsSpawn")
                                    OCH.status.kazpian_bombs_spawned = false
                                  end)
    end

    --------------------- Tether Alert
    if abilityId == OCH.data.kazpian_chains_cast and result == ACTION_RESULT_BEGIN and OCH.savedVariables.show_kazpian_chains then
      OCHRedAlertLabel:SetText("Tether !")
      OCHRedAlertLabel:SetHidden(false)
      OCHRedAlert:SetHidden(false)
      PlaySound(SOUNDS.OBJECTIVE_DISCOVERED)
      EVENT_MANAGER:RegisterForUpdate(OCH.name .. "HideTetherText", 4000,
                                      function()
                                     EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "HideTetherText")
                                     OCHRedAlertLabel:SetHidden(true)
                                     OCHRedAlert:SetHidden(true)
                                      end)
    end

    ------------------------- Biting Blaze alert

    if OCH.savedVariables.show_kazpian_curse_alert and OCH.data.kazpian_curse_cast_ids[abilityId] ~= nil and not OCH.status.kazpian_curse_spawned then
      OCH.status.kazpian_curse_spawned = true
      if OCH.savedVariables.show_kazpian_curse_alert_only_player then
        if targetType == COMBAT_UNIT_TYPE_PLAYER and isDPS then
          CombatAlerts.Alert("", "Blaze on you, STACK", 0xFF0000FF, nil, 3000)
          LibCombatAlerts.PlaySounds("SCRYING_ACTIVATE_BOMB", 10, nil)
        end
      else
        if targetType == COMBAT_UNIT_TYPE_PLAYER and isDPS then
          CombatAlerts.Alert("", "Blaze on you, STACK", 0xFF0000FF, nil, 3000)
          LibCombatAlerts.PlaySounds("SCRYING_ACTIVATE_BOMB", 10, nil)
        else
          CombatAlerts.Alert("", "Biting Blaze starts", 0xFF0000FF, nil, 3000)
          LibCombatAlerts.PlaySounds("SCRYING_ACTIVATE_BOMB", 10, nil)
        end
      end
      EVENT_MANAGER:RegisterForUpdate(OCH.name .. "ResetCurseSpawn", 3000,
                                  function()
                                    EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "ResetCurseSpawn")
                                    OCH.status.kazpian_curse_spawned = false
                                  end)
    end

    --------------------- frenzy tank swap
    if abilityId == OCH.data.kazpian_frenzy_cast and not OCH.status.kazpian_frenzy_alert_queued and OCH.savedVariables.show_kazpian_frenzy_alert and isTank then
      OCH.status.kazpian_frenzy_alert_queued = true
      if OCH.savedVariables.show_kazpian_frenzy_timer then
        EVENT_MANAGER:RegisterForUpdate(OCH.name .. "ShowSwapTimer", 4000,
                                      function()
                                     EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "ShowSwapTimer")
                                     OCHSwapAlertLabel:SetText("Swap in : 5")
                                     OCHSwapAlertLabel:SetHidden(false)
                                     OCHSwapAlert:SetHidden(false)
                                     OCH.status.kazpian_frenzy_alert_playing = true
                                     OCH.status.kazpian_frenzy_alert_start = GetGameTimeSeconds()
                                      end)
      else
        EVENT_MANAGER:RegisterForUpdate(OCH.name .. "ShowSwapAlert", 5000,
          function()
          EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "ShowSwapAlert")

          OCHSwapAlertLabel:SetText("You should swap")
          OCHSwapAlertLabel:SetHidden(false)
          OCHSwapAlert:SetHidden(false)
          OCH.status.kazpian_frenzy_alert_queued = false
          LibCombatAlerts.PlaySounds("SCRYING_ACTIVATE_BOMB", 10, nil)
          EVENT_MANAGER:RegisterForUpdate(OCH.name .. "ShowSwapAlert", 3000,
              function()
              EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "ShowSwapAlert")
              OCHSwapAlertLabel:SetHidden(true)
              OCHSwapAlert:SetHidden(true)
              end)
          end)
      end
    end

  end

end
