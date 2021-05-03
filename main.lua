local jsonText = love.filesystem.read("test.json");

local json = require("json");

local jsonTable = json.decode(jsonText);


print(jsonTable.layers[1]);

local image = love.graphics.newImage(jsonTable.layers[1].folder .. "/" .. jsonTable.layers[1].decals[1].texture);

love.draw = function ()
    
    love.graphics.draw(image, jsonTable.layers[1].decals[1].x, jsonTable.layers[1].decals[1].y);

end