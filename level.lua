local json = require("dependencies/json");

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

local loadImgs = function (name)
    
    local index = level.getIndex(name);
    local level = levels[index];

    Quads = {};

    for i = 1, #level.table.layers do

        if level.table.layers[i].decals ~= nil then
            for b = 1, #level.table.layers[i].decals do
            
                levels[index].table.layers[i].decals[b].image = 
                love.graphics.newImage("content" ..  level.table.layers[1].folder:gsub('%.', '') .. "/" .. level.table.layers[i].decals[b].texture);
    
            end
        end

        if level.table.layers[i].data2D ~= nil then

            TileSetImg[i] = love.graphics.newImage("content/tiles/" .. level.table.layers[i].tileset .. ".png");
            local tileWidth = TileSetImg[i]:getWidth() / level.table.layers[i].gridCellWidth;
            local tileHeight = TileSetImg[i]:getHeight() /  level.table.layers[i].gridCellHeight;


            

        
            Quads[i] = {};
            
            local tileX = 1;
            local tilY = 1;

            for b = 1, tileWidth * tileHeight do
                Quads[i][b] = love.graphics.newQuad(   (tileX - 1) * level.table.layers[i].gridCellWidth, (tilY - 1) * level.table.layers[i].gridCellHeight, 
                                                    level.table.layers[i].gridCellWidth, level.table.layers[i].gridCellHeight, TileSetImg[i]:getDimensions());

                tileX = tileX + 1;
                if tileX > tileWidth then
                    tileX = 1;
                    tilY = tilY + 1;
                end

            end
        end
    end
end

level.load = function (name)
   
    levels[#levels + 1] = { name = name,
                            text = love.filesystem.read("content/levels" ..  "/" .. name .. ".json")};

    levels[#levels].table = json.decode(levels[#levels].text);
    CurrentLevel = name;

    loadImgs(name);
end

level.draw = function (name)

    local level = levels[level.getIndex(name)];

    for layer = 1, #level.table.layers do
        if level.table.layers[layer].data2D ~= nil then

            local coords = {x = 0, y = 0};

            for i = 1, #level.table.layers[layer].data2D do
                for b = 1, #level.table.layers[layer].data2D[i] do

                    if level.table.layers[layer].data2D[i][b] ~= -1 then

                        love.graphics.draw(TileSetImg[layer], Quads[layer][level.table.layers[layer].data2D[i][b] + 1], coords.x, coords.y);

                    end

                    
                    coords.x = coords.x + level.table.layers[layer].gridCellWidth;
                    
                    if ((coords.x + level.table.layers[layer].gridCellWidth) > (level.table.layers[layer].gridCellsX * level.table.layers[layer].gridCellWidth)) then
                       
                        coords.x = 0;
                        coords.y = coords.y + level.table.layers[layer].gridCellHeight;

                    end
                end
            end
        end
    end

    for layer = 1, #level.table.layers do
        if level.table.layers[layer].decals ~= nil then


            for decal = 1, #level.table.layers[layer].decals do

                local d = level.table.layers[layer].decals[decal];
                love.graphics.draw(d.image, d.x - d.image:getWidth()/2, d.y - d.image:getHeight()/2);

            end 
        end
    end
end

return level;