-- control.lua

-- 1. Defina a string do seu blueprint aqui
-- Substitua 'SUA_STRING_DE_BLUEPRINT_AQUI' pela string real do seu blueprint.
local my_blueprint_string = "0eJytl81qwzAQhN9lz1qQZEFqHfsapQcl3rQCRza2WpoavXvlxJRCD6WMj/4bvhlmZXahY/8m4xRTJr9QPA1pJv+00BxfUujXe/k6CnmKWS6kKIXLejXJOSbp+DV8hqnj+tlpkixUFMXUyQd5U54V5djLXW8c5pjjkFbF+tQqupJnV/5S5F7Oucr+UmhghY2hgRkABQ27MLCChl0YWIFxG7wDBV5LxlvFeLUZbyY7nMLtRmHxLBCJjcLgFICEhX3gSVjYxV45aBQBELgTwCEgdXKoB4ZT2BjwocBzwI8H/HTAT3z8z4W4sDCDgRkMyqBRBI0SwCHAGcBVgJsAj9Q/56FuGrf1xP/YZhS9yzTfJO2DcYfWHpxt26at+fbhKHW3ocfvt0v5AqQFX5A="

-- 2. Função para posicionar o blueprint
local function place_blueprint_around_player(event)
    local player = game.get_player(event.player_index)

    if player then
        local player_position = player.position

        -- VERIFICAÇÃO ADICIONAL:
        if not my_blueprint_string or my_blueprint_string == "" then
            game.print("Erro: A string do blueprint está vazia ou inválida!")
            return -- Sai da função se a string for inválida
        end

        -- Decodifica a string do blueprint
        local blueprint = game.decode_blueprint(my_blueprint_string)

        if blueprint then
            -- Calcula a posição para colocar o blueprint.
            -- A posição do blueprint é geralmente o canto superior esquerdo ou o centro,
            -- dependendo de como ele foi salvo. Para centralizar no jogador,
            -- pode ser necessário ajustar o offset.
            -- Para um blueprint de 3x3, por exemplo, você pode querer subtrair 1.5 de x e y.
            -- Para blueprints maiores, pode ser necessário um cálculo mais complexo
            -- ou usar a propriedade 'position' do blueprint se disponível.
            local offset_x = blueprint.width / 2 or 0 -- Se o blueprint tiver largura definida
            local offset_y = blueprint.height / 2 or 0 -- Se o blueprint tiver altura definida

            -- Se o blueprint não tiver width/height (alguns blueprints mais antigos ou simples podem não ter),
            -- você pode precisar de um offset manual ou deixar 0,0 e testar.
            -- Para um blueprint pequeno centrado, um offset fixo como -2, -2 pode funcionar para 5x5
            local target_position_x = player_position.x - offset_x
            local target_position_y = player_position.y - offset_y

            -- Cria o blueprint no mundo
            -- O último argumento 'force' indica a força (player.force para o jogador)
            -- O penúltimo argumento 'direction' (optional) pode ser usado para rotacionar o blueprint
            local result = player.surface.create_entity({
                name = "blueprint", -- O nome da entidade para colocar um blueprint
                position = {x = target_position_x, y = target_position_y},
                force = player.force,
                blueprint = blueprint
            })

            if result then
                game.print("Blueprint inicial posicionado com sucesso!")
            else
                game.print("Falha ao posicionar o blueprint inicial. Verifique se não há obstáculos.")
            end
        else
            game.print("Erro: Não foi possível decodificar o blueprint. Verifique a string.")
        end
    end
end

-- 3. Registra o evento
-- Isso diz ao Factorio para chamar a função 'place_blueprint_around_player'
-- sempre que um novo jogador for criado.
script.on_event(defines.events.on_player_created, place_blueprint_around_player)

-- Opcional: Adicionar um log para depuração ao carregar o mod
--game.print("Mod 'Blueprint Inicial' carregado!")