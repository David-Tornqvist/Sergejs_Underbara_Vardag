local crate = require "entity.crate"
local string = require "dependencies.split"
local switch = require "entity.switch"
local entity = {}

entity.load = function (level)
    Identifier = 1;
    entity.createDrawables(level);

    InterractFunctions = {
        crate = function (item,drawableIndex)
            crate.interract(item,drawableIndex);
        end,
        switch = function (type,drawableIndex)
            switch.interract(type,drawableIndex);
        end
    }

    for i = 1, #level.table.layers do
        local thisLayer = level.table.layers[i];
        if thisLayer.decals ~= nil then
            for b = 1, #thisLayer.decals do
                local thisDecal = thisLayer.decals[b];
    
                local type = thisDecal.values.type;
                local entityType = string.split(type,"_")[1];
    
                crate.load(entityType,thisDecal);
                switch.load(entityType,thisDecal);

            end    
        end 
    end
    
end

entity.animationLoad = function (img,width,height,time)
    
    local animation = {};

    animation.texture = love.graphics.newImage("content/animations/" .. img);

    animation.frames = {};

    animation.t = 0;
    animation.maxt = time;
    animation.width = width;
    animation.height = height;

    

    for anim = 1, height do
        animation.frames[anim] = {};
    end


    local pointer = {x = 0, y = 0};
    local cellWidth = animation.texture:getWidth() / width;
    local cellHeight = animation.texture:getHeight() / height;

    for anim = 1, height do
        for frame = 1, width do
            animation.frames[anim][frame] = love.graphics.newQuad(pointer.x, pointer.y, cellWidth, cellHeight, animation.texture:getDimensions());
            pointer.x = pointer.x + cellWidth;
        end    
        pointer.x = 0;
        pointer.y = pointer.y + cellHeight;
    end

    animation.pointer = {x = 1, y = 1};
    animation.frametime = animation.maxt/animation.width;
    animation.cellWidth = cellWidth;
    animation.cellHeight = cellHeight;

    return animation;

end

CreateEntityDrawable = function (name,x,y,img,animWidth,animHeight,time)

    local type = string.split(name,"_")[1];

    Drawables[#Drawables+1] = { name = name, x = x, y = y, animation = entity.animationLoad(img,animWidth,animHeight,time),
                                draw = function (i)

                                    love.graphics.draw( Drawables[i].animation.texture, Drawables[i].animation.frames[Drawables[i].animation.pointer.y][Drawables[i].animation.pointer.x], 
                                    Drawables[i].x - Drawables[i].animation.cellWidth/2, Drawables[i].y - Drawables[i].animation.cellHeight/2);
                                    
                                end};
    
end

entity.createDrawables = function (level)

    for i = 1, #level.table.layers do
        
        local thisLayer = level.table.layers[i];

        if thisLayer.decals ~= nil then

            for b = 1, #thisLayer.decals do
            
                local thisDecal = thisLayer.decals[b];

                if thisDecal.values.animated == true then

                    local name = thisDecal.values.type .. "_" .. Identifier
                    if thisDecal.values.type == "floor" then
                        name = "floor"
                    end
                    if thisDecal.values.type == "house" then
                        name = "house"
                    end

                    CreateEntityDrawable(  name, thisDecal.x, thisDecal.y, thisDecal.texture, 
                                            thisDecal.values.animWidth, thisDecal.values.animHeight, thisDecal.values.animTime);
                    thisDecal.identifier = Identifier;
                    Identifier = Identifier + 1;
                                   
                end
            end     
        end
    end
    
end



entity.findDrawableEntityIndex = function (name)
    
    for i = 1, #Drawables do
        if name == Drawables[i].name then
            return i;
        end
    end
end

FindDrawableEntityIndex = entity.findDrawableEntityIndex;
    
entity.interract = function (type,identifier)

    local arr = string.split(type,"_");
    local entityType = arr[1];
    local argument = arr[2];

    local drawableIndex = entity.findDrawableEntityIndex(type .. "_" .. identifier);

    InterractFunctions[entityType](argument,drawableIndex);
    
    
end

return entity