local string = require "dependencies.split";

local switch = {};

switch.numberOn = function ()

    local on = 0

    for i = 1, #Drawables do
        if Drawables[i].status then
            on = on + 1;
        end
    end

    return on;
end

switch.disableGlow = function ()

    for i = 1, #Drawables do
        
        local name = Drawables[i].name

        if name ~= nil then
           
            local entityType = string.split(name,"_")[1];

            if entityType == "switch" then
                if Drawables[i].status then
                    Drawables[i].animation.pointer.x = 3;
                else
                    Drawables[i].animation.pointer.x = 1;    
                end
                
            end
        end
    end
end

switch.load = function (entityType,thisDecal)

    if entityType == "switch" then
        thisDecal.distance = 14;
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

    if Drawables[drawableIndex].animation.pointer.x == 3 then
        Drawables[drawableIndex].animation.pointer.x = 5;
    end

    if Drawables[drawableIndex].animation.pointer.x == 1 then
        Drawables[drawableIndex].animation.pointer.x = 4;
    end
    
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