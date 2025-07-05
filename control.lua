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

script.on_event(defines.events.on_player_created, function(event)
    -- NOTE on coordinates:
    -- blueprints are from where you select, not just the parts in it
    -- positive X and Y are down and to the rights
    local player = game.players[event.player_index]
    local surface = player.surface

    -- start with basic stuff researched
    research_drone_tech(player)
    --build_starter_base(surface)
end)