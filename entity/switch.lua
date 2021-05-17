local string = require "dependencies.split";

local switch = {};

switch.load = function (entityType,thisDecal)

    if entityType == "switch" then
        thisDecal.distance = 10;
        local buttonNumber = string.split(thisDecal.values.type, "_")[2];

        print(buttonNumber);

        if buttonNumber == "1" then
            Drawables[FindDrawableEntityIndex(thisDecal.values.type .. "_" .. thisDecal.identifier)].animation.pointer.x = 1; 
            Drawables[FindDrawableEntityIndex(thisDecal.values.type .. "_" .. thisDecal.identifier)].status = false;
        else
            Drawables[FindDrawableEntityIndex(thisDecal.values.type .. "_" .. thisDecal.identifier)].animation.pointer.x = 3; 
            Drawables[FindDrawableEntityIndex(thisDecal.values.type .. "_" .. thisDecal.identifier)].status = true;
        end
    end
    
end

switch.interract = function (number,drawableIndex)
    
    if love.keyboard.isDown("space") and SpacePressed == false then

        Drawables[drawableIndex].status = not Drawables[drawableIndex].status;

        if Drawables[drawableIndex].status then
            Drawables[drawableIndex].animation.pointer.x = 3;
        else
            Drawables[drawableIndex].animation.pointer.x = 1;  
        end 
        
        
        SpacePressed = true; 

        if number == "1" then
            LevelLoad("house");
        end
    end    

end

return switch;