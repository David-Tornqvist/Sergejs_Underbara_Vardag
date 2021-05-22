local string = require "dependencies.split";
local quest = require "quest";
local credits = require "credits";

local container = {};

container.disableGlow = function ()

    for i = 1, #Drawables do
        
        local name = Drawables[i].name

        if name ~= nil then
           
            local entityType = string.split(name,"_")[1];

            if entityType == "container" then
                Drawables[i].animation.pointer.x = 1;
            end
        end
    end
end

container.load = function (entityType,thisDecal)

    Sorted = 0;

    if entityType == "container" then
        thisDecal.distance = 35; 
    end

end

container.interract = function (type,drawableIndex)
    Drawables[drawableIndex].animation.pointer.x = 2;

    if love.keyboard.isDown("space") and SpacePressed == false then

        if Player.hold ~= "none" then
            if type == "glassColored" and Player.hold == "bottle"  then
                PlayerProgress.recycle = PlayerProgress.recycle + 1;
            elseif type == "paper" and Player.hold == "milk" then
                PlayerProgress.recycle = PlayerProgress.recycle + 1;
            elseif type == "plastic" and Player.hold == "ketchup" then
                PlayerProgress.recycle = PlayerProgress.recycle + 1;
            elseif type == "metal" and Player.hold == "tincan" then
                PlayerProgress.recycle = PlayerProgress.recycle + 1;        
            end
            Sorted = Sorted + 1;
        end
        
        quest.set({"#TERVINN",Sorted .. "/8",""});
        Player.removeHolding();
        SpacePressed = true; 
        if Sorted == 8 then
            credits.load();
        end
    end
end

return container;