-- control.lua

-- 1. Defina a string do seu LIVRO DE BLUEPRINT aqui
-- Substitua 'SUA_STRING_DE_LIVRO_DE_BLUEPRINT_AQUI' pela string real do seu livro de blueprint.
-- Lembre-se que as strings de livros de blueprint também começam com "0eNq..."
local my_blueprint_string = "0eNqVlNuO..." -- EXEMPLO: Use a string do seu LIVRO DE BLUEPRINT aqui!

-- Função para dar o blueprint (ou livro de blueprint) ao jogador no início do jogo
local function give_blueprint_to_player(event)
    local player = game.get_player(event.player_index)

    if player then
        if not my_blueprint_string or my_blueprint_string == "" then
            game.print({"mod-message.blueprint-string-empty", player.name})
            log("Erro (mod Blueprint Inicial): A string do blueprint está vazia ou inválida! (Jogador: " .. player.name .. ")")
            return
        end

        local blueprint_object = nil
        local success_decode, error_message = pcall(function()
            blueprint_object = game.decode_blueprint(my_blueprint_string)
        end)

        if success_decode and blueprint_object then
            local item_to_insert_name
            -- Verifica se o objeto decodificado é um livro de blueprint ou um blueprint individual
            if blueprint_object.blueprints then -- Livros de blueprint têm uma propriedade 'blueprints'
                item_to_insert_name = "blueprint-book"
            else
                item_to_insert_name = "blueprint"
            end

            -- Tenta inserir o item (blueprint ou livro) no inventário do jogador
            local inserted_items = player.insert({name = item_to_insert_name, blueprint = blueprint_object})

            if inserted_items > 0 then
                game.print({"mod-message.blueprint-given-success", player.name})
            else
                game.print({"mod-message.blueprint-given-fail", player.name})
                log("Erro (mod Blueprint Inicial): Não foi possível dar o " .. item_to_insert_name .. " ao jogador " .. player.name .. ". Inventário cheio?")
            end
        else
            game.print({"mod-message.blueprint-decode-fail", player.name})
            log("Erro (mod Blueprint Inicial): Falha ao decodificar o blueprint. Mensagem de erro: " .. tostring(error_message))
        end
    end
end

script.on_event(defines.events.on_player_created, give_blueprint_to_player)

log("Mod 'Blueprint Inicial' carregado e pronto para dar blueprints!")

script.on_event(defines.events.on_init, function()
    game.print({"mod-message.mod-loaded"})
end)