local switch = {};

switch.load = function (entityType,thisDecal)

    if entityType == "switch" then
        thisDecal.distance = 10;
        thisDecal.status = true;
        Drawables[FindDrawableEntityIndex(thisDecal.values.type .. "_" .. thisDecal.identifier)].animation.pointer.x = 3; 
    end
    
end

switch.interract = function (type,drawableIndex)
    
    if love.keyboard.isDown("space") and SpacePressed == false then
        

        if Drawables[drawableIndex].status then
            Drawables[drawableIndex].animation.pointer.x = 3;
        else
            Drawables[drawableIndex].animation.pointer.x = 1;  
        end 
        Drawables[drawableIndex].status = not Drawables[drawableIndex].status;
        
        SpacePressed = true; 
    end    
    
end

return switch;