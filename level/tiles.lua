local tiles = {}

tiles.load = function (level)

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

tiles.draw = function (level)
    for layer = 1, #level.table.layers do

        local thisLayer = level.table.layers[layer];

        if thisLayer.data2D ~= nil and thisLayer.name == "ground" then

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

    for layer = 1, #level.table.layers do

        local thisLayer = level.table.layers[layer];

        if thisLayer.data2D ~= nil  and thisLayer.name ~= "ground" then

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

tiles.collide = function (level,dx,dy)

    local collide = false

    for layer = 1, #level.table.layers do

        local thisLayer = level.table.layers[layer];

        if thisLayer.name == "collide" then
            for row = 1, #thisLayer.data2D do
                for collumn = 1, #thisLayer.data2D[row] do

                    if thisLayer.data2D[row][collumn] ~= -1  then

                        if  ((Player.coords.x + Player.hitbox.xOffset - Player.hitbox.width/2 + dx) < ((collumn) * thisLayer.gridCellWidth)) and 
                            ((Player.coords.x + Player.hitbox.xOffset + Player.hitbox.width/2 + dx) > ((collumn - 1) * thisLayer.gridCellWidth)) and
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

return tiles