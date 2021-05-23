local string = require "dependencies.split";
local loadAnim = require "screen.loadAnim";

local vehicles = {};

vehicles.disableGlow = function ()
    for i = 1, #Drawables do
        
        local name = Drawables[i].name;

        if name ~= nil then
           
            local entityType = string.split(name,"_")[1];

            if entityType == "car" or entityType == "moped" or entityType == "bike" then
                Drawables[i].animation.pointer.x = 1;
            end
        end
    end
end

vehicles.load = function (entityType,thisDecal)
    if entityType == "car" then
        thisDecal.distance = 20; 
    end

    if entityType == "bike" then
        thisDecal.distance = 20; 
    end

    if entityType == "moped" then
        thisDecal.distance = 20; 
    end
end

vehicles.interract = function (vehicle,drawableIndex)
    Drawables[drawableIndex].animation.pointer.x = 2;

    if love.keyboard.isDown("space") and SpacePressed == false then
        PlayerProgress.vehicle = vehicle;
        SpacePressed = true; 
        loadAnim.load(700,-Window.height);
        NextLoad = true;
    end
end

return vehicles;