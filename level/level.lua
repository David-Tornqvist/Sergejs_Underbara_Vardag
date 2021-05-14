local json = require "dependencies/json";
local decals = require "level.decals";
local tiles = require "level.tiles";
local player = require "entity.player"

local level = {};

Levels = {};
TileSetImg = {};

level.getIndex = function (name)

    for i = 1, #Levels do
        if Levels[i].name == name then
            return i;
        end
    end
    
end

local loadDrawables = function (name)

    local index = level.getIndex(name);
    local level = Levels[index];

    decals.load(level);
    decals.createDrawables(level);
    
end

level.load = function (name)
   
    Levels[#Levels + 1] = { name = name,
                            text = love.filesystem.read("content/levels/" .. name .. ".json")};

    Levels[#Levels].table = json.decode(Levels[#Levels].text);
    CurrentLevel = name;

    local index = level.getIndex(name);
    local level = Levels[index];

    tiles.load(level);

    Drawables = {};
    loadDrawables(CurrentLevel);
    player.load();

end

local drawDrawables = function ()

   for i = 1, #Drawables do
       Drawables[i].draw(i);
   end
    
end

local sortDrawables = function ()
    
    table.sort(Drawables, function (a,b)
        return a.y < b.y;
    end);

end

level.draw = function (name)

    local level = Levels[level.getIndex(name)];

    tiles.draw(level);

    sortDrawables();
    drawDrawables();

end

return level;