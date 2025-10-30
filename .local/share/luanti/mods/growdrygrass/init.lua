--[[
    Grow Dry Grass — Makes dry grass spread on savanna dirt.
    Written in 2023-2024 by Silver Sandstone <@SilverSandstone@craftodon.social>

    To the extent possible under law, the author has dedicated all copyright
    and related and neighbouring rights to this software to the public
    domain worldwide. This software is distributed without any warranty.

    You should have received a copy of the CC0 Public Domain Dedication
    along with this software. If not, see
    <https://creativecommons.org/publicdomain/zero/1.0/>.
]]


growdrygrass = {};


growdrygrass.SPREAD_FROM = {'default:dry_dirt_with_dry_grass', 'group:spreading_dirt_type'};


--- Returns true if dry grass should grow on the node at the specified position.
-- @param pos [vector]  The position of the node.
-- @return    [boolean] true if the node should grow dry grass.
function growdrygrass.should_grow(pos)
    local pos_above = vector.add(pos, vector.new(0, 1, 0));

    -- Don't spread in darkness:
    local light = minetest.get_node_light(pos_above) or 0;
    if light < 13 then
        return false;
    end;

    -- Grow from grass above:
    local node_above = minetest.get_node(pos_above);
    if minetest.get_item_group(node_above.name, 'dry_grass') > 0 then
        return true;
    end;

    -- Spread from nearby nodes:
    if minetest.find_node_near(pos, 1, growdrygrass.SPREAD_FROM) then
        return true;
    end;

    return false;
end;


--- The ABM action for growing dry grass.
-- @param pos  [vector] The position of the node.
-- @param node [Node]   The node currently at that position.
function growdrygrass.abm(pos, node)
    if growdrygrass.should_grow(pos) then
        minetest.swap_node(pos, {name = 'default:dry_dirt_with_dry_grass'});
    end;
end;


minetest.register_abm(
{
    label     = 'Dry grass spread';
    nodenames = {'default:dry_dirt'};
    neighbors = {'air', 'group:grass', 'group:spreading_dirt_type'};
    interval  = 12;
    chance    = 50;
    catch_up  = false;
    action    = growdrygrass.abm;
});
