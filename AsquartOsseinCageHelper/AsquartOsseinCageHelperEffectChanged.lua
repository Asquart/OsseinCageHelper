OCH = OCH or {}
local OCH = OCH

function OCH.EffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, sourceType )
  OCH.IdentifyUnit(unitTag, unitName, unitId)
  local isDPS, _, isTank = GetPlayerRoles()

  --------------- Trash alerts
  if changeType == EFFECT_RESULT_GAINED and unitTag == "player" and abilityId == OCH.data.deadraiser_cursed_terrain_debuff_id and OCH.savedVariables.show_deadraiser_cursed_terrain then
    OCHPurpleAlert:SetHidden(false)
    OCHPurpleAlertLabel:SetHidden(false)
    OCHPurpleAlertLabel:SetText("Cursed Terrain !")
    PlaySound(SOUNDS.DUEL_START)
  end

  if changeType == EFFECT_RESULT_FADED and abilityId == OCH.data.deadraiser_cursed_terrain_debuff_id then
    OCHPurpleAlert:SetHidden(true)
  end

  if changeType == EFFECT_RESULT_GAINED and unitTag == "player" and abilityId == OCH.data.soul_devourer_detonate_soul_debuff and OCH.savedVariables.show_soul_devourer_detonate_soul then
    OCHPurpleAlertLabel:SetText("Detonate Soul on You!")
    OCHPurpleAlertLabel:SetHidden(false)
    OCHPurpleAlert:SetHidden(false)
  end

  if changeType == EFFECT_RESULT_FADED and abilityId == OCH.data.soul_devourer_detonate_soul_debuff then
    OCHPurpleAlert:SetHidden(true)
  end

  if unitTag == "player" and abilityId == OCH.data.soul_devourer_life_drain_debuff and OCH.savedVariables.show_soul_devourer_life_drain then
    if changeType == EFFECT_RESULT_GAINED then
      if OCH.status.life_drain_alert_id == nil then
        OCH.status.life_drain_alert_id = CombatAlerts.Alert("", "Got Life Drain, cleanse!", 0x14FEFFFF, SOUNDS.DUEL_START, 10000)
      end
    elseif changeType == EFFECT_RESULT_FADED then
      CombatAlerts.DisableBanner(OCH.status.life_drain_alert_id)
      OCH.status.life_drain_alert_id = nil
    end
  end

  if changeType == EFFECT_RESULT_GAINED and abilityId == OCH.data.carrion_reaper_corvid_swarm_debuff and OCH.savedVariables.show_carrion_reaper_corvid_swarm then
    OCHPurpleAlert:SetHidden(false)
    OCHPurpleAlertLabel:SetHidden(false)
    OCHPurpleAlertLabel:SetText("Corvid Swarm !")
  end

  if changeType == EFFECT_RESULT_FADED and abilityId == OCH.data.carrion_reaper_corvid_swarm_debuff then
    OCHPurpleAlert:SetHidden(true)
  end

  if OCH.data.caustic_carrion_ids[abilityId] == true then
    if (changeType == EFFECT_RESULT_GAINED or changeType == EFFECT_RESULT_UPDATED) then
      OCH.status.carrion_stacks_data[unitId] = stackCount
      -- to fix the issue when tracker becomes hidden when entering portal for some reason
      if OCH.savedVariables.show_boss_carrion_stacks and OCH.status.is_kazpian then
        OCHStatus:SetHidden(false)
        OCHStatusBossCarrionTrackerLabel:SetHidden(false)
        OCHStatusBossCarrionTrackerLabelValue:SetHidden(false)
      end
    end
    if changeType == EFFECT_RESULT_FADED then
      OCH.status.carrion_stacks_data[unitId] = 0
    end
  end

  if OCH.status.is_Hall_of_Fleshcraft then
    ------------- gather channeler - do it here in addition to CombatEvents - the faster we get an id - more precise portal percent display will be - every tick matters
    if OCH.savedVariables.show_fleshcraft_portal_percent and string.match(unitName, OCH.data.channeler_name) then
      if OCH.status.channelers_alive[unitId] == nil then
        OCH.status.channelers_alive[unitId] = OCH.GetChannelerHP()
      end
    end
    ------------- same for daedroths
    if OCH.savedVariables.show_daedroth_spawn and isTank and string.match(unitName, OCH.data.daedroth_name) ~= nil then
      if OCH.status.spawned_daedroths[unitId] == nil then
        OCH.status.spawned_daedroths[unitId] = true
        CombatAlerts.Alert("", "Daedroth Spawned !", 0xFF0000FF, SOUNDS.CHAMPION_POINTS_COMMITTED, 3000)
      end
    end
  end

  if OCH.status.is_jynorah_and_skorkhif then

    ------------------- Gather titan ids ----------- same as in CombatEvent() - the earlier we get it - the better
    if OCH.savedVariables.show_jynorah_titan_hp then 
      if OCH.status.valneer_id == nil then
        if string.match(unitName, OCH.data.valneer_name) then
          OCH.status.valneer_id = unitId
        end
      end
      if OCH.status.myrinax_id == nil then
        if string.match(unitName, OCH.data.myrinax_name) then
          OCH.status.myrinax_id = unitId
        end
      end
    end

    if OCH.status.is_hm_boss then
      ---------------------------- Enfeeblement debuff gained & boss swap alert
      if abilityId == OCH.data.jynorah_blazing_enfeeblement then
        if changeType == EFFECT_RESULT_GAINED then
          -- If player gets the debuff
          if unitTag == "player" then
            OCH.status.jynorah_got_blazing_enfeeblement = true
            OCH.status.jynorah_got_sparking_enfeeblement = false
            if OCH.savedVariables.show_jynorah_enfeeblement_swap and isDPS then
              CombatAlerts.Alert("", "Move to Blue Boss", 0x03AFFF, SOUNDS.CHAMPION_POINTS_COMMITTED, 3000)
            end
          -- If someone else gets enfeeblement but player is a DD and is dead - swap the color so an appropriate alert will spawn when ressurected
          elseif not OCH.status.enfeeblement_swapped_while_dead and isDPS and IsUnitDead("player") then
            if OCH.status.jynorah_got_blazing_enfeeblement then
              OCH.status.jynorah_got_blazing_enfeeblement = false
              OCH.status.jynorah_got_sparking_enfeeblement = true
              OCH.status.enfeeblement_swapped_while_dead = true
            elseif OCH.status.jynorah_got_sparking_enfeeblement then
              OCH.status.jynorah_got_sparking_enfeeblement = false
              OCH.status.jynorah_got_blazing_enfeeblement = true
              OCH.status.enfeeblement_swapped_while_dead = true
            end
          end
        end
      end

      if abilityId == OCH.data.jynorah_sparkling_enfeeblement then
        if changeType == EFFECT_RESULT_GAINED then
          -- If player gets the debuff
          if unitTag == "player" then
            OCH.status.jynorah_got_sparking_enfeeblement = true
            OCH.status.jynorah_got_blazing_enfeeblement = false
            if OCH.savedVariables.show_jynorah_enfeeblement_swap and isDPS then
              CombatAlerts.Alert("", "Move to Red Boss", 0xCC3B0E, SOUNDS.CHAMPION_POINTS_COMMITTED, 3000)
            end
          -- If someone else gets enfeeblement but player is a DD and is dead - swap the color so an appropriate alert will spawn when ressurected
          elseif not OCH.status.enfeeblement_swapped_while_dead and isDPS and IsUnitDead("player") then
            if OCH.status.jynorah_got_blazing_enfeeblement then
              OCH.status.jynorah_got_blazing_enfeeblement = false
              OCH.status.jynorah_got_sparking_enfeeblement = true
              OCH.status.enfeeblement_swapped_while_dead = true
            elseif OCH.status.jynorah_got_sparking_enfeeblement then
              OCH.status.jynorah_got_sparking_enfeeblement = false
              OCH.status.jynorah_got_blazing_enfeeblement = true
              OCH.status.enfeeblement_swapped_while_dead = true
            end
          end
        end
      end
      
          --------------------- Gather seeking surge stacks
      if changeType == EFFECT_RESULT_GAINED and abilityId == OCH.data.jynorah_seeking_forge_fire_debuff_id and unitTag == "player" then
        OCH.data.jynorah_blazing_surge_stacks = OCH.data.jynorah_blazing_surge_stacks + 1
      end
      if changeType == EFFECT_RESULT_GAINED and abilityId == OCH.data.jynorah_seeking_spark_surge_debuff_id and unitTag == "player" then
        OCH.data.jynorah_sparking_surge_stacks = OCH.data.jynorah_sparking_surge_stacks + 1
      end
    end

  end

  if OCH.status.is_kazpian then
    ------------------------------- Tether Alert
    if changeType == EFFECT_RESULT_GAINED and unitTag == "player" and (abilityId == OCH.data.kazpian_chains_debuff_1 or abilityId == OCH.data.kazpian_chains_debuff_2) and OCH.savedVariables.show_kazpian_chains then
      OCHRedAlertLabel:SetText("Tether on YOU!")
    end

    ----------------------------------- Portal phase start/end
    if abilityId == OCH.data.kazpian_portal_phase_buff_id then
      if changeType == EFFECT_RESULT_GAINED then
        OCH.status.kazpian_portal_ongoing = true
        OCHStatusBossCarrionTrackerLabel:SetHidden(false)
        OCHStatusBossCarrionTrackerLabelValue:SetHidden(false)
      elseif changeType == EFFECT_RESULT_FADED then
        OCH.status.kazpian_portal_ongoing = false
        OCHStatusBossCarrionTrackerLabel:SetHidden(true)
        OCHStatusBossCarrionTrackerLabelValue:SetHidden(true)
      end
    end
  end
  
end