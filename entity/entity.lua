
local entity = {}

entity.load = function (level)
    Identifier = 1;
    entity.createDrawables(level);
    
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

entity.createDrawable = function (name,x,y,img,animWidth,animHeight,time)

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

                    entity.createDrawable(  thisDecal.values.type .. Identifier, thisDecal.x, thisDecal.y, thisDecal.texture, 
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
    
return entity