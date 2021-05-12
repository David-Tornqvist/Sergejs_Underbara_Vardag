local json = require("dependencies/json");
local entity = require("entity");

local level = {};

levels = {};
TileSetImg = {};

level.getIndex = function (name)

    for i = 1, #levels do
        if levels[i].name == name then
            return i;
        end
    end
    
end

local loadDrawableImages = function (level)

    for i = 1, #level.table.layers do

        local thisLayer = level.table.layers[i];

        if thisLayer.decals ~= nil then
            for b = 1, #thisLayer.decals do
            
                local thisDecal = thisLayer.decals[b];

                thisDecal.image = 
                love.graphics.newImage("content" ..  thisLayer.folder:gsub('%.', '') .. "/" .. thisDecal.texture);
    
            end
        end
    end
end

local createDecalDrawables = function (level)

    for i = 1, #level.table.layers do
        
        local thisLayer = level.table.layers[i];

        if thisLayer.decals ~= nil then

            for b = 1, #thisLayer.decals do
            
                local thisDecal = thisLayer.decals[b];

                if thisDecal.values.entity == false then
                    Drawables[#Drawables+1] = {
                        x = thisDecal.x,
                        y = thisDecal.y,
                        image = thisDecal.image,
                        draw = function (i)
                            love.graphics.draw(Drawables[i].image, Drawables[i].x - Drawables[i].image:getWidth()/2, Drawables[i].y - Drawables[i].image:getHeight()/2);
                        end
                    }                    
                end
            end     
        end
    end
end

local loadTiles = function (name)

    local index = level.getIndex(name);
    local level = levels[index];
    Quads = {};

    for i = 1, #level.table.layers do

        local thisLayer = level.table.layers[i];

        if thisLayer.data2D ~= nil then
    
            TileSetImg[i] = love.graphics.newImage("content/tiles/" .. thisLayer.tileset .. ".png");
            local tileWidth = TileSetImg[i]:getWidth() / thisLayer.gridCellWidth;
            local tileHeight = TileSetImg[i]:getHeight() /  thisLayer.gridCellHeight;
        
            Quads[i] = {};
            
            local tileX = 1;
            local tilY = 1;
        
            for b = 1, tileWidth * tileHeight do
                Quads[i][b] = love.graphics.newQuad(   (tileX - 1) * thisLayer.gridCellWidth, (tilY - 1) * thisLayer.gridCellHeight, 
                                                        thisLayer.gridCellWidth, thisLayer.gridCellHeight, TileSetImg[i]:getDimensions());
        
                tileX = tileX + 1;

                if tileX > tileWidth then
                    tileX = 1;
                    tilY = tilY + 1;
                end
            end
        end
    end  
end

local loadDrawables = function (name)

    local index = level.getIndex(name);
    local level = levels[index];

    loadDrawableImages(level);
    createDecalDrawables(level);
    entity.playerLoad();
    
end

level.load = function (name)
   
    levels[#levels + 1] = { name = name,
                            text = love.filesystem.read("content/levels" ..  "/" .. name .. ".json")};

    levels[#levels].table = json.decode(levels[#levels].text);
    CurrentLevel = name;

    loadTiles(CurrentLevel);

    Drawables = {};
    loadDrawables(CurrentLevel);

end

local drawTiles = function (level)
    for layer = 1, #level.table.layers do

        local thisLayer = level.table.layers[layer];

        if thisLayer.data2D ~= nil then

            local coords = {x = 0, y = 0};

            for i = 1, #thisLayer.data2D do
                for b = 1, #thisLayer.data2D[i] do

                    if thisLayer.data2D[i][b] ~= -1 then

                        love.graphics.draw(TileSetImg[layer], Quads[layer][thisLayer.data2D[i][b] + 1], coords.x, coords.y);

                    end

                    coords.x = coords.x + thisLayer.gridCellWidth;
                    
                    if ((coords.x + thisLayer.gridCellWidth) > (thisLayer.gridCellsX * thisLayer.gridCellWidth)) then
                       
                        coords.x = 0;
                        coords.y = coords.y + thisLayer.gridCellHeight;

                    end
                end
            end
        end
    end
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

    local level = levels[level.getIndex(name)];

    drawTiles(level);

    sortDrawables();
    drawDrawables();

end



local decalCollide = function (level,dx,dy)

    local collide = false;

    for layer = 1, #level.table.layers do

        local thisLayer = level.table.layers[layer];

        if thisLayer.decals ~= nil then
            for decal = 1, #thisLayer.decals do
    
                local thisDecal = thisLayer.decals[decal];
    
                if thisDecal.values.collide then
                    if  ((Player.coords.x - Player.hitbox.width/2 + dx) < (thisDecal.x + thisDecal.values.width/2 + thisDecal.values.hox)) and
                        ((Player.coords.x + Player.hitbox.width/2 + dx) > (thisDecal.x - thisDecal.values.width/2 + thisDecal.values.hox)) and
                        ((Player.coords.y + Player.hitbox.yOffset - Player.hitbox.height/2 + dy) < (thisDecal.y + thisDecal.values.height/2 + thisDecal.values.hoy)) and
                        ((Player.coords.y + Player.hitbox.yOffset + Player.hitbox.height/2 + dy) > (thisDecal.y - thisDecal.values.height/2 + thisDecal.values.hoy)) then
                        collide = true;
                    end  
                end
            end
        end
    end    

    return collide;

end

local tileCollide = function (level,dx,dy)

    local collide = false

    for layer = 1, #level.table.layers do

        local thisLayer = level.table.layers[layer];

        if thisLayer.name == "collide" then
            for row = 1, #thisLayer.data2D do
                for collumn = 1, #thisLayer.data2D[row] do

                    if thisLayer.data2D[row][collumn] ~= -1  then

                        if  ((Player.coords.x - Player.hitbox.width/2 + dx) < ((collumn) * thisLayer.gridCellWidth)) and 
                            ((Player.coords.x + Player.hitbox.width/2 + dx) > ((collumn - 1) * thisLayer.gridCellWidth)) and
                            ((Player.coords.y + Player.hitbox.yOffset - Player.hitbox.height/2 + dy) < ((row) * thisLayer.gridCellHeight)) and 
                            ((Player.coords.y + Player.hitbox.yOffset + Player.hitbox.height/2 + dy) > ((row - 1) * thisLayer.gridCellHeight)) then

                            collide = true;
                        end
                    end
                end
            end
        end   
    end

    return collide;

end

level.isCollide = function (name,dx,dy) -- checks wether the new position would collide

    local index = level.getIndex(name);
    local level = levels[index];

    local collide = false;

    if decalCollide(level,dx,dy) or tileCollide(level,dx,dy) then
        collide = true;
    end
    
    return collide

end

return level;