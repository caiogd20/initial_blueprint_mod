function research_drone_tech(player)
    if player and player.force then
        -- List of technologies to be researched
        local technologies = {
            "construction-robotics", -- Robôs de construção
            "logistic-robotics" -- Robôs logísticos
        }

        for _, tech in pairs(technologies) do
            if player.force.technologies[tech] then
                player.force.technologies[tech].researched = true
            else
                log("Technology '" .. tech .. "' does not exist.")
            end
        end
    end
end
function build_starter_base(surface, player)
    
    if not surface then
        return
    end

    -- Define the area for the starter base
    local start_x = 0
    local start_y = 0
    local width = 10
    local height = 10

    -- Create a rectangle of tiles
    for x = start_x, start_x + width - 1 do
        for y = start_y, start_y + height - 1 do
            surface.set_tiles({{name = "grass-1", position = {x, y},force = player.force}})
        end
    end
    -- plece roboport com smol etitric pole e solar panal
    local roboport_position = {start_x + 3, start_y + 1}
    surface.create_entity({
        name = "roboport",
        position = roboport_position,
        force = player.force
    })
    local small_electric_pole_position = {start_x + 5, start_y + 1}
    surface.create_entity({
        name = "small-electric-pole",
        position = small_electric_pole_position,
        force = player.force
    })
    local solar_panel_position = {start_x + 7, start_y + 1}
    surface.create_entity({
        name = "solar-panel",
        position = solar_panel_position,
        force = player.force
    })
    --insert a few drones on the roboport
    local roboport = surface.find_entity("roboport", roboport_position)
    if roboport then
        for i = 1, 5 do
            roboport.insert({name = "construction-robot"})
        end
    else
        log("Roboport not found at position: " .. serpent.line(roboport_position))
    end
    if roboport then
        for i = 1, 5 do
            roboport.insert({name = "logistic-robot"})
        end
    else
        log("Roboport not found at position: " .. serpent.line(roboport_position))
    end

    


    


end

script.on_event(defines.events.on_player_created, function(event)
    -- NOTE on coordinates:
    -- blueprints are from where you select, not just the parts in it
    -- positive X and Y are down and to the rights
    local player = game.players[event.player_index]
    local surface = player.surface

    -- start with basic stuff researched
    research_drone_tech(player)
    build_starter_base(surface, player)
end)