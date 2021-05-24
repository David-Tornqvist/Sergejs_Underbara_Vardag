local decals = {}

decals.load = function (level)
    for i = 1, #level.table.layers do

        local thisLayer = level.table.layers[i];

        if thisLayer.decals ~= nil then
            for b = 1, #thisLayer.decals do
            
                local thisDecal = thisLayer.decals[b];

                if thisDecal.values.animated == false then
                    thisDecal.image = 
                    love.graphics.newImage("content" ..  thisLayer.folder:gsub('%.', '') .. "/" .. thisDecal.texture); 
                end
            end
        end
    end
end

decals.createDrawables = function (level)
    for i = 1, #level.table.layers do
        
        local thisLayer = level.table.layers[i];

        if thisLayer.decals ~= nil then

            for b = 1, #thisLayer.decals do
            
                local thisDecal = thisLayer.decals[b];

                if thisDecal.values.animated == false then
                    Drawables[#Drawables+1] = {
                        name = "decal",
                        x = thisDecal.x,
                        y = thisDecal.y,
                        hox = thisDecal.values.hox,
                        hoy = thisDecal.values.hoy,
                        image = thisDecal.image,
                        draw = function (i)
                            love.graphics.draw(Drawables[i].image, Drawables[i].x - Drawables[i].image:getWidth()/2, Drawables[i].y - Drawables[i].image:getHeight()/2);
                        end
                    }
                    if thisDecal.values.type ~= nil then
                        Drawables[#Drawables].name = thisDecal.values.type; 
                    end                      
                end
            end     
        end
    end
end

decals.collide = function (level,dx,dy)
    local collide = false;

    for layer = 1, #level.table.layers do

        local thisLayer = level.table.layers[layer];

        if thisLayer.decals ~= nil then
            for decal = 1, #thisLayer.decals do
    
                local thisDecal = thisLayer.decals[decal];
    
                if thisDecal.values.collide then
                    if  ((Player.coords.x + Player.hitbox.xOffset - Player.hitbox.width/2 + dx) < (thisDecal.x + thisDecal.values.width/2 + thisDecal.values.hox)) and
                        ((Player.coords.x + Player.hitbox.xOffset + Player.hitbox.width/2 + dx) > (thisDecal.x - thisDecal.values.width/2 + thisDecal.values.hox)) and
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

return decals;