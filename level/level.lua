local json = require "dependencies/json";
local decals = require "level.decals";
local tiles = require "level.tiles";
local entity = require "entity.entity";
local player = require "entity.player";
local cart = require "entity.cartFunc";
local switch = require "entity.switch"

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

    if name == "ICA" then
        player.load(40,90);
        cart.load();
    end

    if name == "house" then
        player.load(52,52);
    end

end

local drawDrawables = function ()

    for i = 1, #Drawables do
        Drawables[i].draw(i);
    end

end

local sortDrawables = function ()
    
    table.sort(Drawables, function (a,b)
        
        if a.name == "floor" then
            return true;
        elseif b.name == "floor" then
            return false;    
        else
            return a.y < b.y;    
        end
        
    end);

    if Cart ~= nil then
        if Cart.drive then
            local playerIndex = entity.findDrawableEntityIndex("player");
            local cartIndex = entity.findDrawableEntityIndex("cart");
            local player = Drawables[playerIndex];
            Drawables[playerIndex] = Drawables[cartIndex];
            Drawables[cartIndex] = player;
        end 
    end
end

level.draw = function (name)

    local level = Levels[level.getIndex(name)];

    tiles.draw(level);

    sortDrawables();
    drawDrawables();

end

level.getDrawableIndex = function (name)
    
    for i = 1, #Drawables do
        if name == Drawables[i].name then
            return i;
        end
    end

    return -1;
    
end

GetDrawableIndex = level.getDrawableIndex;

return level;