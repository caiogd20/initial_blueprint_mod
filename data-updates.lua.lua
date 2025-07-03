-- data-updates.lua

-- Desbloquear a tecnologia de Robótica (Construction Robots)
if data.raw.technology["robotics"] then
  data.raw.technology["robotics"].enabled = true
  data.raw.technology["robotics"].hidden = true
  data.raw.technology["robotics"].research_unit_ingredients = {}
  data.raw.technology["robotics"].prerequisites = {}
end

-- Desbloquear a tecnologia de Sistema Robótico de Logística (Logistic Robots)
if data.raw.technology["logistic-system"] then
  data.raw.technology["logistic-system"].enabled = true
  data.raw.technology["logistic-system"].hidden = true
  data.raw.technology["logistic-system"].research_unit_ingredients = {}
  data.raw.technology["logistic-system"].prerequisites = {}
end

-- Opcional: Desbloquear o Porto de Robôs (Roboport)
if data.raw.item["roboport"] then
    data.raw.item["roboport"].enabled = true
end

-- Opcional: Desbloquear o Robô de Construção (Construction Robot)
if data.raw.item["construction-robot"] then
    data.raw.item["construction-robot"].enabled = true
end

-- Opcional: Desbloquear o Robô de Logística (Logistic Robot)
if data.raw.item["logistic-robot"] then
    data.raw.item["logistic-robot"].enabled = true
end