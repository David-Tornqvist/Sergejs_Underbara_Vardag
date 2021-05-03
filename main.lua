--local jsonText = love.filesystem.read("test.json");

--local json = require("json");

--local jsonTable = json.decode(jsonText);


--print(jsonTable.layers[1]);

local level = require "level";

level.load("test_2");

--local image = love.graphics.newImage("levels/" .. currentLevel .. "/" .. levels[1].table.layers[1].folder .. "/" .. levels[1].table.layers[1].decals[1].texture);

love.draw = function ()
    
    --love.graphics.draw(image, levels[level.getIndex(currentLevel)].table.layers[1].decals[1].x, levels[1].table.layers[1].decals[1].y);

    level.draw(currentLevel);

end