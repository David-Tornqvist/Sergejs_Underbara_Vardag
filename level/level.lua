local json = require "dependencies/json";
local decals = require "level.decals";
local tiles = require "level.tiles";
local entity = require "entity.entity";
local player = require "entity.player";
local cart = require "entity.cartFunc";
local fog = require "entity.fog";
local string = require "dependencies.split";
local loadAnim = require "loadAnim"

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

local GetIndex = level.getIndex;

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

    if name == "ICA2" then
        player.load(100,100);
        cart.load(100,90);
    end

    if name == "bedroom" then
        loadAnim.load(700);
        player.load(52,52);
        Cutscene.start();
    end

    if name == "house" then
       player.load(Player.coords.x,Player.coords.y + 8); 
    end

    if name == "outside" then
        loadAnim.load(700);
        player.load(200,220);
    end

    entity.load(Levels[GetIndex(CurrentLevel)]);

end

LevelLoad = level.load;

local drawDrawables = function ()

    for i = 1, #Drawables do
        Drawables[i].draw(i);
    end

end

local sortDrawables = function ()
    
    table.sort(Drawables, function (a,b)
        local AY = a.y;
        local BY = b.y;
        if a.name == "tree" then
            AY = AY + a.hoy;
        end

        if b.name == "tree" then
            BY = BY + b.hoy;
        end
        
        if string.split(a.name, "_")[1] == "floor" then
            return true;
        elseif string.split(b.name, "_")[1] == "floor" then
            return false;  
        elseif a.name == "mark" then
            return false;
        elseif b.name == "mark" then
            return true;
        else
            return AY < BY;    
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
    fog.draw();

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