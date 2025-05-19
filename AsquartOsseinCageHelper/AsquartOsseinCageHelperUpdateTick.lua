OCH = OCH or {}
local OCH = OCH

function OCH.UpdateTick(gameTimeMs)
  local timeSec = GetGameTimeSeconds()

  -- update icons even out of combat
  -- check if OdySupportIcons is active
  if OCH.hasOSI() then
      -- [!] search for group members with custom timer
      for i = 1, GROUP_SIZE_MAX do
          local name = GetUnitDisplayName( "group" .. i )
          local icon = OSI.GetIconForPlayer( name )
          -- [!] update custom label if icon and timer are available
          if icon and icon.myTimer and timeSec <= icon.myTimer then
            local timeLeft = icon.myTimer - timeSec
            if timeLeft < 3 then
              if math.fmod(zo_floor(timeLeft*10), 10) < 5 then
                icon.myLabel:SetColor(0.9,0.9,0.9,0.85)
              else
                icon.myLabel:SetColor(0.9,0,0,0.85)
              end
            end
            icon.myLabel:SetText(tostring(zo_floor(timeLeft)))
            OCH.AdjustLabelForIcon(icon)
          end
      end
  end
  
  if IsUnitInCombat("boss1") or IsUnitInCombat("boss2") or IsUnitInCombat("boss3") or IsUnitInCombat("boss4") or IsUnitInCombat("boss5") or IsUnitInCombat("boss6") then
    OCH.status.inCombat = true
  end

  if OCH.status.is_trash then
    OCH.SetTrashIcons()

    --------------------- Abductor Spawn
    if OCH.savedVariables.show_abductor_spawn and OCH.status.abductor_spawned and not OCH.status.abductor_notification_played then
      CombatAlerts.Alert("", "Abductor Spawned !", 0xFF0000FF, SOUNDS.CHAMPION_POINTS_COMMITTED, 4000)
      OCH.status.abductor_notification_played = true
    end
  end

  if OCH.savedVariables.show_boss_carrion_stacks or OCH.savedVariables.block_carrion_synergy then
      local maxStacks = 0
      for _, stacksNum in pairs(OCH.status.carrion_stacks_data) do
        if stacksNum > maxStacks then
          maxStacks = stacksNum
        end
      end
      OCH.status.carrion_stacks_num = maxStacks
      OCHStatusBossCarrionTrackerLabelValue:SetText(tostring(maxStacks))
  end

  --------------------------------   Genda Relvel
  if OCH.status.is_Gedna_Relvel then
    OCH.SetGlobalMiniBossIcons()
    -- Update phantasms phase timer
    if OCH.savedVariables.show_witch_summon_phantasms_timer then
      local phantasms_timer = OCH.data.witch_summon_phantasms_initial_countdown
      if not OCH.status.witch_is_first_countdown then
        phantasms_timer = OCH.data.witch_summon_phantasms_consecutive_countdown
      end
      local phase_duration = timeSec - OCH.status.witch_last_phantasms_time

      if phase_duration < phantasms_timer then
        local time_to_phantasms = phantasms_timer - phase_duration
        local txtDuration = tostring(string.format("%.0f", time_to_phantasms))
        OCHStatusGednaRelvelTimerLabelValue:SetText(txtDuration .. "s")
      else
        OCHStatusGednaRelvelTimerLabelValue:SetText("In Progress")
      end
    end
  end

  -- Tortured Ranyu
  if OCH.status.is_Tortured_Ranyu then
    OCH.SetGlobalMiniBossIcons()
    -- Update phantasms phase timer
    if OCH.savedVariables.show_ranyu_jump_timer then
      local jump_timer = OCH.data.ranyu_jump_countdown
      if not OCH.status.ranyu_has_jumped then
        jump_timer = OCH.data.witch_summon_phantasms_consecutive_countdown
        local phase_duration = timeSec - OCH.status.ranyu_last_jump_time

        if phase_duration < jump_timer then
          local time_to_jump = jump_timer - phase_duration
          local txtDuration = tostring(string.format("%.0f", time_to_jump))
          OCHStatusGednaRelvelTimerLabelValue:SetText(txtDuration .. "s")
        else  
          OCHStatusGednaRelvelTimerLabelValue:SetText("Jump Incoming")
        end
      else
        OCHStatusGednaRelvelTimerLabel:SetHidden(true)
        OCHStatusGednaRelvelTimerLabelValue:SetHidden(true)
      end
    end
  end

  -- Blood Drinker Thisa
  if OCH.status.is_Blood_Drinker_Thisa then
    OCH.SetGlobalMiniBossIcons()
  end

  ----------------------------------------- Hall of Fleshcraft----------------------------------------
  if OCH.status.is_Hall_of_Fleshcraft then
    OCH.SetHallOfFleshcraftIcons()

    ------------------------------------ Process channeler damage and update UI------------------------------------------------
    if OCH.savedVariables.show_fleshcraft_portal_percent then
      if OCH.status.initial_channeler_dead then ------------ if initial channeler killed
        if OCH.status.fleshcraft_portal_percent < 1 and OCH.status.fleshcraft_portal_percent > 0 then --------- if portal in progress
          ------------------- Show UI
          if OCH.status.fleshcraft_portal_UI_hidden then
            OCHStatusRedWarningLabel1:SetHidden(false)
            OCH.status.fleshcraft_portal_UI_hidden = false
          end
          ------------------- Update UI
          local txtPercent = tostring(string.format("%.1f", OCH.status.fleshcraft_portal_percent * 100))
          OCHStatusRedWarningLabel1:SetText("Portal percent : " .. txtPercent .. "%")
        elseif OCH.status.fleshcraft_portal_percent <= 0 then --------------------- finish portal
          if not OCH.status.fleshcraft_portal_UI_hidden then
            OCHStatusRedWarningLabel1:SetHidden(true)
            OCH.status.fleshcraft_portal_UI_hidden = true
          end
        end
      else -------------------- Initial channeler still alive
        if not OCH.status.fleshcraft_portal_UI_hidden then
          OCH.status.fleshcraft_portal_UI_hidden = true
          OCHStatusRedWarningLabel1:SetHidden(true)
        end
      end
    end
    ------------------------------------ Process channeler damage and update UI------------------------------------------------


  end
  ----------------------------------------- Hall of Fleshcraft ----------------------------------------
  
  ----------------------------------------- Jynorah and Skorknif ---------------------------------------------------
  if OCH.status.is_jynorah_and_skorkhif then
    OCH.SetJynorahIcons()

    local jynorahHP, maxJynorahHP, _ = GetUnitPower("boss1", POWERTYPE_HEALTH)
    local skorknifHP, maxSkorknifHP, _ = GetUnitPower("boss2", POWERTYPE_HEALTH)

    OCH.status.current_jyronah_percent = jynorahHP / maxJynorahHP
    OCH.status.current_skorknif_percent = skorknifHP / maxSkorknifHP

    local totalBossPercent = (OCH.status.current_jyronah_percent + OCH.status.current_skorknif_percent) / 2

    local txtPercentNum = tostring(string.format("%.0f", OCH.status.current_jyronah_percent * 100))
    ----------------- hp counters update
    if OCH.savedVariables.show_jynorah_boss_hp then
      if OCHStatusJynorahHpCounterLabel:IsHidden() then
        OCHStatusJynorahHpCounterLabel:SetHidden(false)
      end
      OCHStatusJynorahHpCounterLabel:SetText("Jynorah HP: " .. txtPercentNum .. "%")

      txtPercentNum = tostring(string.format("%.0f", OCH.status.current_skorknif_percent * 100))
      if OCHStatusSkorknifHpCounterLabel:IsHidden() then
        OCHStatusSkorknifHpCounterLabel:SetHidden(false)
      end
      OCHStatusSkorknifHpCounterLabel:SetText("Skorknif HP: " .. txtPercentNum .. "%")
    end

    ----------------- portal countdown
    if OCH.savedVariables.show_jynorah_portal_countdown then
      local portalLeft = 0
      if 0.704 < totalBossPercent and totalBossPercent < 0.8  then
        portalLeft = (totalBossPercent - 0.704)*100
      elseif 0.404 < totalBossPercent and totalBossPercent < 0.5 then
        portalLeft = (totalBossPercent - 0.404)*100
      else
        portalLeft = 0
      end

      if portalLeft > 0 and not OCH.status.jynorah_titanic_clash_ongoing then
        local txtPercentNum = tostring(string.format("%.1f", portalLeft))
        OCHPurpleAlert:SetHidden(false)
        OCHPurpleAlertLabel:SetHidden(false)
        OCHPurpleAlertLabel:SetText("Portals in: " .. txtPercentNum .. "%")
      else
        OCHPurpleAlert:SetHidden(true)
      end
    end

    ------------------------ Update curse timer
    if OCH.savedVariables.show_jynorah_curse_timer and not OCH.status.jynorah_titanic_clash_ongoing then
      local timeToNextCurse = OCH.status.jynorah_next_curse - timeSec
      if not OCH.status.inCombat then
        OCHStatusJynorahCurseTimerLabelValue:SetText("Pending")
      elseif OCH.status.jynorah_curse_ongoing then
        OCHStatusJynorahCurseTimerLabelValue:SetText("In progress")
      elseif timeToNextCurse > 0 then
        local txtTime = tostring(string.format("%.0f", timeToNextCurse))
        OCHStatusJynorahCurseTimerLabelValue:SetText(txtTime .. "s")
      else
        OCHStatusJynorahCurseTimerLabelValue:SetText("Incoming")
      end
    end

    ----------------------- Update titans HP
    if OCH.savedVariables.show_jynorah_titan_hp then
       --------------------- Crutch-way of tracking titans HP cuz well... they are not bosses it seems
      local myrinaxPercentage = OCH.status.current_myrinax_hp / OCH.status.titan_max_hp
      local valneerPercentage = OCH.status.current_valneer_hp / OCH.status.titan_max_hp
      ------------------- Update UI
      local txtPercentNum = tostring(string.format("%.1f", valneerPercentage * 100))
      if OCHStatusValneerHpCounterLabel:IsHidden() then
        OCHStatusValneerHpCounterLabel:SetHidden(false)
      end
      OCHStatusValneerHpCounterLabel:SetText("Valneer HP : " .. txtPercentNum .. "%")

      txtPercentNum = tostring(string.format("%.1f", myrinaxPercentage * 100))
      if OCHStatusMyrinaxHpCounterLabel:IsHidden() then
        OCHStatusMyrinaxHpCounterLabel:SetHidden(false)
      end
      OCHStatusMyrinaxHpCounterLabel:SetText("Myrinax HP : " .. txtPercentNum .. "%")
    end

  end
  ----------------------------------------- Jynorah and Skorknif ---------------------------------------------------

  ----------------------------------------- Overfiend Kazpian ------------------------------------------------------
  if OCH.status.is_kazpian then
    local kazpianHP, maxKazpianHP, _ = GetUnitPower("boss1", POWERTYPE_HEALTH)
    local kazpianPercentage = kazpianHP / maxKazpianHP

    OCH.status.is_kazpian_start_arena = true
    OCH.status.is_low_warden_arena = false
    OCH.status.is_molag_kena_arena = false
    OCH.status.is_krogo_arena = false

    --------------- set current arena
    if kazpianPercentage > 0.85 then
      OCH.status.is_kazpian_start_arena = true
      OCH.status.is_low_warden_arena = false
      OCH.status.is_molag_kena_arena = false
      OCH.status.is_krogo_arena = false
    elseif kazpianPercentage > 0.55 then
      OCH.status.is_kazpian_start_arena = false
      OCH.status.is_low_warden_arena = true
      OCH.status.is_molag_kena_arena = false
      OCH.status.is_krogo_arena = false
    elseif kazpianPercentage > 0.35 then
      OCH.status.is_kazpian_start_arena = false
      OCH.status.is_low_warden_arena = false
      OCH.status.is_molag_kena_arena = true
      OCH.status.is_krogo_arena = false
    else
      OCH.status.is_kazpian_start_arena = false
      OCH.status.is_low_warden_arena = false
      OCH.status.is_molag_kena_arena = false
      OCH.status.is_krogo_arena = true
    end
    OCH.SetKazpianIcons()

    ----------------- portal countdown
    if OCH.savedVariables.show_kazpian_portal_countdown then
      local portalLeft = 0
      if 0.858 < kazpianPercentage and kazpianPercentage < 0.9  then
        portalLeft = (kazpianPercentage - 858)*100
      elseif 0.558 < kazpianPercentage and kazpianPercentage < 0.6 then
        portalLeft = (kazpianPercentage - 0.558)*100
      elseif 0.358 < kazpianPercentage and kazpianPercentage < 0.4 then
        portalLeft = (kazpianPercentage - 0.358)*100
      else
        portalLeft = 0
      end

      if portalLeft > 0 then
        local txtPercentNum = tostring(string.format("%.1f", portalLeft))
        OCHPurpleAlertLabel:SetText("Portal in: " .. txtPercentNum .. "%")
        OCHPurpleAlert:SetHidden(false)
        OCHPurpleAlertLabel:SetHidden(false)
      else
        OCHPurpleAlert:SetHidden(true)
      end
    end

    ---------------- tank swap alert
    if OCH.savedVariables.show_kazpian_frenzy_alert and OCH.savedVariables.show_kazpian_frenzy_timer and OCH.status.kazpian_frenzy_alert_playing then
      local alertTime = timeSec - OCH.status.kazpian_frenzy_alert_start
      if alertTime < 5 then
        local txtTime = tostring(string.format("%d", 6 - alertTime))
        OCHSwapAlertLabel:SetText("Swap in : " .. txtTime)
      else
        OCH.status.kazpian_frenzy_alert_playing = false
        OCH.status.kazpian_frenzy_alert_queued = false
        OCHSwapAlertLabel:SetText("Swap")
        PlaySound(SOUNDS.DUEL_START)
        EVENT_MANAGER:RegisterForUpdate(OCH.name .. "HideSwapAlert", 1000,
                                      function()
                                     EVENT_MANAGER:UnregisterForUpdate(OCH.name .. "HideSwapAlert")
                                     OCHSwapAlertLabel:SetHidden(true)
                                     OCHSwapAlert:SetHidden(true)
                                      end)
      end
    end
  end
  ----------------------------------------- Overfiend Kazpian ------------------------------------------------------
end