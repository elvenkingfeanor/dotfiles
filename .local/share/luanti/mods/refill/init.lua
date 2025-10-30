-- refill/init.lua
-- Refill your hand slot after using up all items in that slot

local basket_enabled =
    core.get_modpath("basket") and core.settings:get_bool("refill_from_baskets", false)
    and true or false

local function do_refill(name, slot_no, itemname)
    local player = core.get_player_by_name(name)
    if not player or player:get_wield_index() ~= slot_no
        or not player:get_wielded_item():is_empty() then
        return false
    end

    local inv = player:get_inventory()
    local baskets = {}

    for i, item in ipairs(inv:get_list("main")) do
        if item:get_name() == itemname then
            inv:set_stack("main", i, "")
            player:set_wielded_item(item)
            return true
        end

        if basket_enabled and item:get_name() == "basket:basket" then
            baskets[#baskets + 1] = i
        end
    end

    for _, i in ipairs(baskets) do
        local basket_item = inv:get_stack("main", i)
        local basket_data = basket.get_basket_from_item(basket_item) or { items = {} }
        local basket_inv = basket_data.items

        local empty_count = 1
        local basket_found = false

        for j, item in ipairs(basket_inv) do
            if not basket_found and item:get_name() == itemname then
                basket_inv[j] = ""
                basket_found = true
                player:set_wielded_item(item)
            elseif item:is_empty() then
                empty_count = empty_count + 1
            end
        end

        if basket_found then
            if empty_count == #basket_inv then
                inv:set_stack("main", i, ItemStack("basket:basket_craftitem"))
            else
                basket_item = basket.get_basket_itemstack(basket_data)
                inv:set_stack("main", i, basket_item)
            end

            return true
        end
    end
end

local player_last_slot = {}
local player_last_item = {}

core.register_globalstep(function()
    for _, player in pairs(core.get_connected_players()) do
        local name = player:get_player_name()
        local control = player:get_player_control()
        local rmb = control.place
        local slot = player:get_wield_index()
        local item = player:get_wielded_item()

        if rmb
            and player_last_item[name] and player_last_slot[name] == slot
            and item:is_empty() then
            local def = core.registered_items[player_last_item[name]]
            if def and def.stack_max ~= 1 then
                core.after(0.2, do_refill, name, player_last_slot[name], player_last_item[name])
            end
        end

        player_last_slot[name] = slot
        player_last_item[name] = not item:is_empty() and item:get_name() or nil
    end
end)

core.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    player_last_slot[name] = nil
    player_last_item[name] = nil
end)
