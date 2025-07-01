-- control.lua

-- 1. Defina a string do seu blueprint aqui
-- Substitua 'SUA_STRING_DE_BLUEPRINT_AQUI' pela string real do seu blueprint.
local my_blueprint_string = "0eJx9j82OwjAMhN9lzgmiBQTNcV8DIZQGC6xt3KpJEVXVdydpEdrT3vwz/sYzoW4G6nqWCDOBXSsB5jwh8F1sk2dx7AgGHMlDQazPnQ2BfN2w3LW37sFCusCswHKjF0wxXxRIIkemlfffnULXhiRtJfulc73dHBTGtUjUG/fk1v32wx2vMvia+uSlkLa8PGmH2HqblTo4JnGkO+t+kd9ZApg/eRWe1IeFWp6K/bEqj/uyqnZVIja2ppQeP1/1PL8BTqdjag=="

-- 2. Função para posicionar o blueprint
local function place_blueprint_around_player(event)
    local player = game.get_player(event.player_index) -- Obtém o objeto do jogador que foi criado

    if player then
        local player_position = player.position -- Posição atual do jogador (centro)

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
game.print("Mod 'Blueprint Inicial' carregado!")