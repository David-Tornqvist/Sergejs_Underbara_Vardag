local json = require("dependencies/json");

local level = {};

levels = {};

level.getIndex = function (name)

    for i = 1, #levels do
        if levels[i].name == name then
            return i;
        end
    end
    
end

local loadImgs = function (name)
    
    local index = level.getIndex(name);
    local level = levels[index];

    for i = 1, #level.table.layers do
        
        for b = 1, #level.table.layers[i].decals do
            
            levels[index].table.layers[i].decals[b].image = 
            love.graphics.newImage("levels/" .. "/" .. level.table.layers[1].folder .. "/" .. level.table.layers[i].decals[b].texture);

        end

    end

end

level.load = function (name)
   
    levels[#levels + 1] = { name = name,
                            text = love.filesystem.read("levels/" .. name .. "/" .. name .. ".json")};

    levels[#levels].table = json.decode(levels[#levels].text);
    currentLevel = name;

    loadImgs(name);
end

level.draw = function (name)

    local level = levels[level.getIndex(name)];

    for layer = 1, #level.table.layers do
        for decal = 1, #level.table.layers[layer].decals do
            love.graphics.draw(level.table.layers[layer].decals[decal].image, level.table.layers[layer].decals[decal].x, level.table.layers[layer].decals[decal].y);
        end
    end

end

return level;