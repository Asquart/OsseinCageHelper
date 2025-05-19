OCH = OCH or {}
local OCH = OCH

-------------------------------------------- Trash
function OCH.SetTrashNumberIcons() ----------------------- show pack numbers
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.trash_numbers_enabled then
    OCH.status.trash_numbers_enabled = true
  else
    return
  end

  for i=1, OCH.icons_data.num_pack_coords do
    table.insert(OCH.status.trash_number_icons, OSI.CreatePositionIcon(
      OCH.icons_data.pack_number_coords[i][1],
      OCH.icons_data.pack_number_coords[i][2] + 400,
      OCH.icons_data.pack_number_coords[i][3],
      OCH.icons_data.pack_number_textures[i],
      OSI.GetIconSize() * 2))
  end
end

function OCH.HideTrashNumberIcons()
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.trash_numbers_enabled then
    for _, icon in ipairs(OCH.status.trash_number_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.trash_number_icons = {}
    OCH.status.trash_numbers_enabled = false
  end
end

function OCH.SetTrashStackIcons() ------------------------ show stack positions
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.trash_stacks_enabled then
    OCH.status.trash_stacks_enabled = true
  else
    return
  end

  for _, coord in ipairs(OCH.icons_data.trash_pack_stack_positions) do
    table.insert(OCH.status.trash_stacks_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.stack_texture,
        OSI.GetIconSize()))
  end

  for _, coord in ipairs(OCH.icons_data.trash_pack_ot_stack_positions) do
    table.insert(OCH.status.trash_stacks_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.ot_stack_texture,
        OSI.GetIconSize()))
  end

end

function OCH.HideTrashStackIcons()
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.trash_stacks_enabled then
    for _, icon in ipairs(OCH.status.trash_stacks_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.trash_stacks_icons = {}
    OCH.status.trash_stacks_enabled = false;
  end
end

function OCH.SetTrashSlayerIcons() --------------------- show trash slayer positions
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.trash_slayers_enabled then
    OCH.status.trash_slayers_enabled = true
  else
    return
  end

  for _, coord in ipairs(OCH.icons_data.trash_pack_left_slayer_positions) do
    table.insert(OCH.status.trash_slayer_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.left_slayer_texture,
        OSI.GetIconSize()))
  end

  for _, coord in ipairs(OCH.icons_data.trash_pack_right_slayer_positions) do
    table.insert(OCH.status.trash_slayer_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.right_slayer_texture,
        OSI.GetIconSize()))
  end
end

function OCH.HideTrashSlayerIcons()
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.trash_slayers_enabled then
    for _, icon in ipairs(OCH.status.trash_slayer_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.trash_slayer_icons = {}
    OCH.status.trash_slayers_enabled = false
  end
end

--------------------------------------- Mini bosses
function OCH.SetMiniBossIcons()
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.mini_bosses_markers_enabled then
    OCH.status.mini_bosses_markers_enabled = true
  else
    return
  end

  for _, coord in ipairs(OCH.icons_data.mini_boss_stack_positions) do
    table.insert(OCH.status.mini_boss_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.stack_texture,
        OSI.GetIconSize()))
  end

  for _, coord in ipairs(OCH.icons_data.mini_boss_left_slayer_positions) do
    table.insert(OCH.status.mini_boss_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.left_slayer_texture,
        OSI.GetIconSize()))
  end

  for _, coord in ipairs(OCH.icons_data.mini_boss_right_slayer_positions) do
    table.insert(OCH.status.mini_boss_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.right_slayer_texture,
        OSI.GetIconSize()))
  end

  table.insert(OCH.status.mini_boss_icons, OSI.CreatePositionIcon(
    OCH.icons_data.witch_phantom_left_back[1],
    OCH.icons_data.witch_phantom_left_back[2],
    OCH.icons_data.witch_phantom_left_back[3],
    OCH.icons_data.phantom_left_back_texture,
    OSI.GetIconSize()))
  table.insert(OCH.status.mini_boss_icons, OSI.CreatePositionIcon(
    OCH.icons_data.witch_phantom_left_front[1],
    OCH.icons_data.witch_phantom_left_front[2],
    OCH.icons_data.witch_phantom_left_front[3],
    OCH.icons_data.phantom_left_front_texture,
    OSI.GetIconSize()))
  table.insert(OCH.status.mini_boss_icons, OSI.CreatePositionIcon(
    OCH.icons_data.witch_phantom_right_back[1],
    OCH.icons_data.witch_phantom_right_back[2],
    OCH.icons_data.witch_phantom_right_back[3],
    OCH.icons_data.phantom_right_back_texture,
    OSI.GetIconSize()))
  table.insert(OCH.status.mini_boss_icons, OSI.CreatePositionIcon(
    OCH.icons_data.witch_phantom_right_front[1],
    OCH.icons_data.witch_phantom_right_front[2],
    OCH.icons_data.witch_phantom_right_front[3],
    OCH.icons_data.phantom_right_front_texture,
    OSI.GetIconSize()))
end

function OCH.HideMiniBossIcons()
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.mini_bosses_markers_enabled then
    for _, icon in ipairs(OCH.status.mini_boss_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.mini_boss_icons = {}
    OCH.status.mini_bosses_markers_enabled = false
  end
end

------------------------------------------- Fleshcraft
function OCH.SetFleshcraftStackIcons()
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.fleshcraft_stacks_enabled then
    OCH.status.fleshcraft_stacks_enabled = true
  else
    return
  end

  local coords_table = {}
  if OCH.savedVariables.show_hall_of_flesh_arcanist_positions then
    coords_table = OCH.icons_data.hall_of_flesh_stack_positions_arc
  else
    coords_table = OCH.icons_data.hall_of_flesh_stack_positions
  end

  for _, coord in ipairs(coords_table) do
    table.insert(OCH.status.fleshcraft_stack_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.stack_texture,
        OSI.GetIconSize()))
  end
end

function OCH.HideFleshcraftStackIcons()
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.fleshcraft_stacks_enabled then
    for _, icon in ipairs(OCH.status.fleshcraft_stack_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.fleshcraft_stack_icons = {}
    OCH.status.fleshcraft_stacks_enabled = false
  end
end

function OCH.SetFleshcraftSlayerIcons()
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.fleshcraft_slayers_enabled then
    OCH.status.fleshcraft_slayers_enabled = true
  else
    return
  end

  local coords_table = {}
  if OCH.savedVariables.show_hall_of_flesh_arcanist_positions then
    coords_table = OCH.icons_data.hall_of_flesh_left_slayer_positions_arc
  else
    coords_table = OCH.icons_data.hall_of_flesh_left_slayer_positions
  end

  for _, coord in ipairs(coords_table) do
    table.insert(OCH.status.fleshcraft_slayer_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.left_slayer_texture,
        OSI.GetIconSize()))
  end

  if OCH.savedVariables.show_hall_of_flesh_arcanist_positions then
    coords_table = OCH.icons_data.hall_of_flesh_right_slayer_positions_arc
  else
    coords_table = OCH.icons_data.hall_of_flesh_right_slayer_positions
  end

  for _, coord in ipairs(coords_table) do
    table.insert(OCH.status.fleshcraft_slayer_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.right_slayer_texture,
        OSI.GetIconSize()))
  end
end

function OCH.HideFleshcraftSlayerIcons()
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.fleshcraft_slayers_enabled then
    for _, icon in ipairs(OCH.status.fleshcraft_slayer_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.fleshcraft_slayer_icons = {}
    OCH.status.fleshcraft_slayers_enabled = false
  end
end

function OCH.SetFleshcraftAddIcons()
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.fleshcraft_add_markers_enabled then
    OCH.status.fleshcraft_add_markers_enabled = true
  else
    return
  end

  table.insert(OCH.status.fleshcraft_add_icons, OSI.CreatePositionIcon(
    OCH.icons_data.hall_of_flesh_add_spawn_locations[1][1],
    OCH.icons_data.hall_of_flesh_add_spawn_locations[1][2],
    OCH.icons_data.hall_of_flesh_add_spawn_locations[1][3],
        OCH.icons_data.harvester_spawn_texture_1,
        OSI.GetIconSize()))
  table.insert(OCH.status.fleshcraft_add_icons, OSI.CreatePositionIcon(
    OCH.icons_data.hall_of_flesh_add_spawn_locations[2][1],
    OCH.icons_data.hall_of_flesh_add_spawn_locations[2][2],
    OCH.icons_data.hall_of_flesh_add_spawn_locations[2][3],
        OCH.icons_data.harvester_spawn_texture_2,
        OSI.GetIconSize()))
end

function OCH.HideFleshcraftAddIcons()
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.fleshcraft_add_markers_enabled then
    for _, icon in ipairs(OCH.status.fleshcraft_add_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.fleshcraft_add_icons = {}
    OCH.status.fleshcraft_add_markers_enabled = false
  end
end

--------------------------------------- jynorah and Skorknif

function OCH.SetJynorahStackIcons() --------------------- boss stacks
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.jynorah_stacks_enabled then
    OCH.status.jynorah_stacks_enabled = true
  else
    return
  end

  for _, coord in ipairs(OCH.icons_data.jynorah_blue_boss_positions) do
    table.insert(OCH.status.jynorah_stacks_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.jynorah_stack_texture,
        OSI.GetIconSize()))
  end
  for _, coord in ipairs(OCH.icons_data.jynorah_red_boss_positions) do
    table.insert(OCH.status.jynorah_stacks_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.skorknif_stack_texture,
        OSI.GetIconSize()))
  end
end

function OCH.HideJynorahStackIcons()
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.jynorah_stacks_enabled then
    for _, icon in ipairs(OCH.status.jynorah_stacks_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.jynorah_stacks_icons = {}
    OCH.status.jynorah_stacks_enabled = false
  end
end

function OCH.SetJynorahCurseIcons() ----------------------------- curse icons
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.is_hm_boss and not OCH.status.jynorah_curse_markers_enabled then
    OCH.status.jynorah_curse_markers_enabled = true
  else
    return
  end

  for _, coord in ipairs(OCH.icons_data.jynorah_blue_healer_positions) do -- healer blue
    table.insert(OCH.status.jynorah_curse_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.healer_blue_texture,
        OSI.GetIconSize()))
  end
  for _, coord in ipairs(OCH.icons_data.jynorah_red_healer_positions) do -- healer red
    table.insert(OCH.status.jynorah_curse_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.healer_red_texture,
        OSI.GetIconSize()))
  end
  for _, coord in ipairs(OCH.icons_data.jynorah_blue_dd1_positions) do -- dd 1 blue
    table.insert(OCH.status.jynorah_curse_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.dd_blue_1_texture,
        OSI.GetIconSize()))
  end
  for _, coord in ipairs(OCH.icons_data.jynorah_blue_dd2_positions) do -- dd 2 blue
    table.insert(OCH.status.jynorah_curse_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.dd_blue_2_texture,
        OSI.GetIconSize()))
  end
  for _, coord in ipairs(OCH.icons_data.jynorah_blue_dd3_positions) do -- dd 3 blue
    table.insert(OCH.status.jynorah_curse_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.dd_blue_3_texture,
        OSI.GetIconSize()))
  end
  for _, coord in ipairs(OCH.icons_data.jynorah_blue_dd4_positions) do -- dd 4 blue
    table.insert(OCH.status.jynorah_curse_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.dd_blue_4_texture,
        OSI.GetIconSize()))
  end
  for _, coord in ipairs(OCH.icons_data.jynorah_red_dd1_positions) do -- dd 1 red
    table.insert(OCH.status.jynorah_curse_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.dd_red_1_texture,
        OSI.GetIconSize()))
  end
  for _, coord in ipairs(OCH.icons_data.jynorah_red_dd2_positions) do -- dd 2 red
    table.insert(OCH.status.jynorah_curse_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.dd_red_2_texture,
        OSI.GetIconSize()))
  end
  for _, coord in ipairs(OCH.icons_data.jynorah_red_dd3_positions) do -- dd 3 red
    table.insert(OCH.status.jynorah_curse_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.dd_red_3_texture,
        OSI.GetIconSize()))
  end
  for _, coord in ipairs(OCH.icons_data.jynorah_red_dd4_positions) do -- dd 4 red
    table.insert(OCH.status.jynorah_curse_icons, OSI.CreatePositionIcon(
        coord[1],
        coord[2],
        coord[3],
        OCH.icons_data.dd_red_4_texture,
        OSI.GetIconSize()))
  end
end

function OCH.HideJynorahCurseIcons()
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.jynorah_curse_markers_enabled then
    for _, icon in ipairs(OCH.status.jynorah_curse_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.jynorah_curse_icons = {}
    OCH.status.jynorah_curse_markers_enabled = false
  end
end

--------------------------------------- Overfiend Kazpian

function SetKazpianEntranceStackIcons() --------------------- entrance boss stacks
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.kazpian_entrance_stacks_enabled then
    OCH.status.kazpian_entrance_stacks_enabled = true
  else
    return
  end

  table.insert(OCH.status.kazpian_entrance_stack_icons, OSI.CreatePositionIcon(
    OCH.icons_data.kazpian_entrance_stack_pos[1],
    OCH.icons_data.kazpian_entrance_stack_pos[2],
    OCH.icons_data.kazpian_entrance_stack_pos[3],
    OCH.icons_data.stack_texture,
    OSI.GetIconSize()))
end

function SetKazpianLowWardenStackIcons() --------------------- low warden boss stacks
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.kazpian_low_warden_stacks_enabled then
    OCH.status.kazpian_low_warden_stacks_enabled = true
  else
    return
  end

  table.insert(OCH.status.kazpian_low_warden_stack_icons, OSI.CreatePositionIcon(
    OCH.icons_data.kazpian_low_warden_boss_pos[1],
    OCH.icons_data.kazpian_low_warden_boss_pos[2],
    OCH.icons_data.kazpian_low_warden_boss_pos[3],
    OCH.icons_data.kazpian_stack_texture,
    OSI.GetIconSize()))

  table.insert(OCH.status.kazpian_low_warden_stack_icons, OSI.CreatePositionIcon(
    OCH.icons_data.kazpian_low_warden_add_pos[1],
    OCH.icons_data.kazpian_low_warden_add_pos[2],
    OCH.icons_data.kazpian_low_warden_add_pos[3],
    OCH.icons_data.low_warden_stack_texture,
    OSI.GetIconSize()))
end

function SetKazpianMolagKenaStackIcons() --------------------- molag kena boss stacks
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.kazpian_molag_kena_stacks_enabled then
    OCH.status.kazpian_molag_kena_stacks_enabled = true
  else
    return
  end

  table.insert(OCH.status.kazpian_molag_kena_stack_icons, OSI.CreatePositionIcon(
    OCH.icons_data.kazpian_molag_kena_boss_pos[1],
    OCH.icons_data.kazpian_molag_kena_boss_pos[2],
    OCH.icons_data.kazpian_molag_kena_boss_pos[3],
    OCH.icons_data.kazpian_stack_texture,
    OSI.GetIconSize()))

  table.insert(OCH.status.kazpian_molag_kena_stack_icons, OSI.CreatePositionIcon(
    OCH.icons_data.kazpian_molag_kena_add_pos[1],
    OCH.icons_data.kazpian_molag_kena_add_pos[2],
    OCH.icons_data.kazpian_molag_kena_add_pos[3],
    OCH.icons_data.molag_kena_stack_texture,
    OSI.GetIconSize()))
end

function SetKazpianKrogoStackIcons() --------------------- krogo boss stacks
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.kazpian_krogo_stacks_enabled then
    OCH.status.kazpian_krogo_stacks_enabled = true
  else
    return
  end

  table.insert(OCH.status.kazpian_krogo_stack_icons, OSI.CreatePositionIcon(
    OCH.icons_data.kazpian_krogo_boss_pos[1],
    OCH.icons_data.kazpian_krogo_boss_pos[2],
    OCH.icons_data.kazpian_krogo_boss_pos[3],
    OCH.icons_data.kazpian_stack_texture,
    OSI.GetIconSize()))

  table.insert(OCH.status.kazpian_krogo_stack_icons, OSI.CreatePositionIcon(
    OCH.icons_data.kazpian_krogo_add_pos[1],
    OCH.icons_data.kazpian_krogo_add_pos[2],
    OCH.icons_data.kazpian_krogo_add_pos[3],
    OCH.icons_data.krogo_stack_texture,
    OSI.GetIconSize()))
end

function HideKazpianEntranceStackIcons() --------------------hide kazpian entrance boss stacks
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.kazpian_entrance_stacks_enabled  then
    for _, icon in ipairs(OCH.status.kazpian_entrance_stack_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.kazpian_entrance_stack_icons = {}
    OCH.status.kazpian_entrance_stacks_enabled = false
  end
end

function HideKazpianLowWardenStackIcons() --------------------hide kazpian low warden boss stacks
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.kazpian_low_warden_stacks_enabled  then
    for _, icon in ipairs(OCH.status.kazpian_low_warden_stack_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.kazpian_low_warden_stack_icons = {}
    OCH.status.kazpian_low_warden_stacks_enabled = false
  end
end

function HideKazpianMolagKenaStackIcons() --------------------hide kazpian molag kena boss stacks
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.kazpian_molag_kena_stacks_enabled  then
    for _, icon in ipairs(OCH.status.kazpian_molag_kena_stack_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.kazpian_molag_kena_stack_icons = {}
    OCH.status.kazpian_molag_kena_stacks_enabled = false
  end
end

function HideKazpianKrogoStackIcons() --------------------hide kazpian krogo boss stacks
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.kazpian_krogo_stacks_enabled  then
    for _, icon in ipairs(OCH.status.kazpian_krogo_stack_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.kazpian_krogo_stacks_enabled = {}
    OCH.status.kazpian_krogo_stacks_enabled = false
  end
end

function SetKazpianEntanceSlayerIcons() --------------------- entrance slayer stacks
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.kazpian_entrance_slayers_enabled then
    OCH.status.kazpian_entrance_slayers_enabled = true
  else
    return
  end

  table.insert(OCH.status.kazpian_entrance_slayer_icons, OSI.CreatePositionIcon(
    OCH.icons_data.kazpian_entrance_left_slayer_pos[1],
    OCH.icons_data.kazpian_entrance_left_slayer_pos[2],
    OCH.icons_data.kazpian_entrance_left_slayer_pos[3],
    OCH.icons_data.left_slayer_texture,
    OSI.GetIconSize()))

    table.insert(OCH.status.kazpian_entrance_slayer_icons, OSI.CreatePositionIcon(
      OCH.icons_data.kazpian_entrance_right_slayer_pos[1],
      OCH.icons_data.kazpian_entrance_right_slayer_pos[2],
      OCH.icons_data.kazpian_entrance_right_slayer_pos[3],
      OCH.icons_data.right_slayer_texture,
      OSI.GetIconSize()))
end

function SetKazpianLowWardenSlayerIcons() --------------------- low warden slayer stacks
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.kazpian_low_warden_slayers_enabled then
    OCH.status.kazpian_low_warden_slayers_enabled = true
  else
    return
  end

  table.insert(OCH.status.kazpian_low_warden_slayer_icons, OSI.CreatePositionIcon(
    OCH.icons_data.kazpian_low_warden_left_slayer_pos[1],
    OCH.icons_data.kazpian_low_warden_left_slayer_pos[2],
    OCH.icons_data.kazpian_low_warden_left_slayer_pos[3],
    OCH.icons_data.left_slayer_texture,
    OSI.GetIconSize()))

    table.insert(OCH.status.kazpian_low_warden_slayer_icons, OSI.CreatePositionIcon(
      OCH.icons_data.kazpian_low_warden_right_slayer_pos[1],
      OCH.icons_data.kazpian_low_warden_right_slayer_pos[2],
      OCH.icons_data.kazpian_low_warden_right_slayer_pos[3],
      OCH.icons_data.right_slayer_texture,
      OSI.GetIconSize()))
end

function SetKazpianMolagKenaSlayerIcons() --------------------- molag kena slayer stacks
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.kazpian_molag_kena_slayers_enabled then
    OCH.status.kazpian_molag_kena_slayers_enabled = true
  else
    return
  end

  table.insert(OCH.status.kazpian_molag_kena_slayer_icons, OSI.CreatePositionIcon(
    OCH.icons_data.kazpian_molag_kena_left_slayer_pos[1],
    OCH.icons_data.kazpian_molag_kena_left_slayer_pos[2],
    OCH.icons_data.kazpian_molag_kena_left_slayer_pos[3],
    OCH.icons_data.left_slayer_texture,
    OSI.GetIconSize()))

    table.insert(OCH.status.kazpian_molag_kena_slayer_icons, OSI.CreatePositionIcon(
      OCH.icons_data.kazpian_molag_kena_right_slayer_pos[1],
      OCH.icons_data.kazpian_molag_kena_right_slayer_pos[2],
      OCH.icons_data.kazpian_molag_kena_right_slayer_pos[3],
      OCH.icons_data.right_slayer_texture,
      OSI.GetIconSize()))
end

function SetKazpianKrogoSlayerIcons() --------------------- krogo slayer stacks
  if not OCH.hasOSI() then
    return
  end
  if not OCH.status.kazpian_krogo_slayers_enabled then
    OCH.status.kazpian_krogo_slayers_enabled = true
  else
    return
  end

  table.insert(OCH.status.kazpian_krogo_slayer_icons, OSI.CreatePositionIcon(
    OCH.icons_data.kazpian_krogo_left_slayer_pos[1],
    OCH.icons_data.kazpian_krogo_left_slayer_pos[2],
    OCH.icons_data.kazpian_krogo_left_slayer_pos[3],
    OCH.icons_data.left_slayer_texture,
    OSI.GetIconSize()))

    table.insert(OCH.status.kazpian_krogo_slayer_icons, OSI.CreatePositionIcon(
      OCH.icons_data.kazpian_krogo_right_slayer_pos[1],
      OCH.icons_data.kazpian_krogo_right_slayer_pos[2],
      OCH.icons_data.kazpian_krogo_right_slayer_pos[3],
      OCH.icons_data.right_slayer_texture,
      OSI.GetIconSize()))
end

function HideKazpianEntranceSlayerStackIcons() --------------------hide kazpian entrance slayer stacks
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.kazpian_entrance_slayers_enabled then
    for _, icon in ipairs(OCH.status.kazpian_entrance_slayer_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.kazpian_entrance_slayer_icons = {}
    OCH.status.kazpian_entrance_slayers_enabled = false
  end
end

function HideKazpianLowWardenSlayerStackIcons() --------------------hide kazpian low warden slayer stacks
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.kazpian_low_warden_slayers_enabled then
    for _, icon in ipairs(OCH.status.kazpian_low_warden_slayer_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.kazpian_low_warden_slayer_icons = {}
    OCH.status.kazpian_low_warden_slayers_enabled = false
  end
end

function HideKazpianMolagKenaSlayerStackIcons() --------------------hide kazpian molag kena slayer stacks
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.kazpian_molag_kena_slayers_enabled then
    for _, icon in ipairs(OCH.status.kazpian_molag_kena_slayer_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.kazpian_molag_kena_slayer_icons = {}
    OCH.status.kazpian_molag_kena_slayers_enabled = false
  end
end

function HideKazpianKrogoSlayerStackIcons() --------------------hide kazpian krogo slayer stacks
  if not OCH.hasOSI() then
    return
  end
  if OCH.status.kazpian_krogo_slayers_enabled then
    for _, icon in ipairs(OCH.status.kazpian_krogo_slayer_icons) do
      if icon ~= nil then
        OSI.DiscardPositionIcon(icon)
      end
    end
    OCH.status.kazpian_krogo_slayer_icons = {}
    OCH.status.kazpian_krogo_slayers_enabled = false
  end
end

function OCH.HideKazpianIcons()
  HideKazpianEntranceStackIcons()
  HideKazpianLowWardenStackIcons()
  HideKazpianMolagKenaStackIcons()
  HideKazpianKrogoStackIcons()
  HideKazpianEntranceSlayerStackIcons()
  HideKazpianLowWardenSlayerStackIcons()
  HideKazpianMolagKenaSlayerStackIcons()
  HideKazpianKrogoSlayerStackIcons()
end

function OCH.SetTrashIcons()
  if OCH.savedVariables.show_trash_pack_icons then
    OCH.SetTrashNumberIcons()
  end
  if OCH.savedVariables.show_trash_stack_positions then
    OCH.SetTrashStackIcons()
  end
  if OCH.savedVariables.show_trash_slayer_positions then
    OCH.SetTrashSlayerIcons()
  end
  
  OCH.HideMiniBossIcons()

  OCH.HideFleshcraftStackIcons()
  OCH.HideFleshcraftAddIcons()
  OCH.HideFleshcraftSlayerIcons()

  OCH.HideJynorahStackIcons()
  OCH.HideJynorahCurseIcons()

  OCH.HideKazpianIcons()
end

function OCH.SetGlobalMiniBossIcons()
  if OCH.savedVariables.show_mini_boss_markers then
    OCH.SetMiniBossIcons()
  end
  
  OCH.HideTrashNumberIcons()
  OCH.HideTrashStackIcons()
  OCH.HideTrashSlayerIcons()

  OCH.HideFleshcraftStackIcons()
  OCH.HideFleshcraftAddIcons()
  OCH.HideFleshcraftSlayerIcons()

  OCH.HideJynorahStackIcons()
  OCH.HideJynorahCurseIcons()

  OCH.HideKazpianIcons()
end

function OCH.SetHallOfFleshcraftIcons()
  if OCH.savedVariables.show_hall_of_flesh_stack_positions then
    OCH.SetFleshcraftStackIcons()
  end
  if OCH.savedVariables.show_hall_of_flesh_add_positions then
    OCH.SetFleshcraftAddIcons()
  end
  if OCH.savedVariables.show_hall_of_flesh_slayer_positions then
    OCH.SetFleshcraftSlayerIcons()
  end
  
  OCH.HideTrashNumberIcons()
  OCH.HideTrashStackIcons()
  OCH.HideTrashSlayerIcons()

  OCH.HideMiniBossIcons()

  OCH.HideJynorahStackIcons()
  OCH.HideJynorahCurseIcons()

  OCH.HideKazpianIcons()
end

function OCH.SetJynorahIcons()
  if OCH.savedVariables.show_jynorah_boss_positions then
    OCH.SetJynorahStackIcons()
  end
  if OCH.savedVariables.show_jynorah_curse_positions then
    OCH.SetJynorahCurseIcons()
  end
  
  OCH.HideTrashNumberIcons()
  OCH.HideTrashStackIcons()
  OCH.HideTrashSlayerIcons()

  OCH.HideMiniBossIcons()

  OCH.HideFleshcraftStackIcons()
  OCH.HideFleshcraftAddIcons()
  OCH.HideFleshcraftSlayerIcons()

  OCH.HideKazpianIcons()
end

function OCH.SetKazpianIcons()
  if OCH.savedVariables.show_kazpian_stack_positions then
    if OCH.status.is_kazpian_start_arena then
      SetKazpianEntranceStackIcons()
      HideKazpianMolagKenaStackIcons()
      HideKazpianLowWardenStackIcons()
      HideKazpianKrogoStackIcons()
    elseif OCH.status.is_low_warden_arena then
      HideKazpianEntranceStackIcons()
      SetKazpianLowWardenStackIcons()
      HideKazpianMolagKenaStackIcons()
      HideKazpianKrogoStackIcons()
    elseif OCH.status.is_molag_kena_arena then
      HideKazpianEntranceStackIcons()
      HideKazpianLowWardenStackIcons()
      SetKazpianMolagKenaStackIcons()
      HideKazpianKrogoStackIcons()
    elseif OCH.status.is_krogo_arena then
      HideKazpianEntranceStackIcons()
      HideKazpianMolagKenaStackIcons()
      HideKazpianLowWardenStackIcons()
      SetKazpianKrogoStackIcons()
    end
  end

  if OCH.savedVariables.show_kazpian_slayer_positions then
    if OCH.status.is_kazpian_start_arena then
      SetKazpianEntanceSlayerIcons()
      HideKazpianLowWardenSlayerStackIcons()
      HideKazpianMolagKenaSlayerStackIcons()
      HideKazpianKrogoSlayerStackIcons()
    elseif OCH.status.is_low_warden_arena then
      HideKazpianEntranceSlayerStackIcons()
      SetKazpianLowWardenSlayerIcons()
      HideKazpianMolagKenaSlayerStackIcons()
      HideKazpianKrogoSlayerStackIcons()
    elseif OCH.status.is_molag_kena_arena then
      HideKazpianEntranceSlayerStackIcons()
      HideKazpianLowWardenSlayerStackIcons()
      SetKazpianMolagKenaSlayerIcons()
      HideKazpianKrogoSlayerStackIcons()
    elseif OCH.status.is_krogo_arena then
      HideKazpianEntranceSlayerStackIcons()
      HideKazpianLowWardenSlayerStackIcons()
      HideKazpianMolagKenaSlayerStackIcons()
      SetKazpianKrogoSlayerIcons()
    end
  end
  
  OCH.HideTrashNumberIcons()
  OCH.HideTrashStackIcons()
  OCH.HideTrashSlayerIcons()

  OCH.HideMiniBossIcons()

  OCH.HideFleshcraftStackIcons()
  OCH.HideFleshcraftAddIcons()
  OCH.HideFleshcraftSlayerIcons()

  OCH.HideJynorahStackIcons()
  OCH.HideJynorahCurseIcons()
end