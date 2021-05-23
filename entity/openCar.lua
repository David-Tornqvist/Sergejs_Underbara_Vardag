local string = require "dependencies.split";
local mathFunc = require "dependencies.mathFunc";

local openCar = {};

openCar.disableGlow = function ()
    for i = 1, #Drawables do
        
        local name = Drawables[i].name;

        if name ~= nil then
           
            local entityType = string.split(name,"_")[1];

            if entityType == "openCar" then
                Drawables[i].animation.pointer.x = 1;
            end
        end
    end
end

openCar.load = function (entityType,thisDecal)
    if entityType == "openCar" then
        thisDecal.distance = 30; 
    end
end

openCar.trash = {"bottle","jar","ketchup","milk","tincan"};

openCar.interract = function (drawableIndex)
    Drawables[drawableIndex].animation.pointer.x = 2;

    if love.keyboard.isDown("space") and SpacePressed == false then
        Player.removeHolding();
        local trash = openCar.trash[mathFunc.random(1,#openCar.trash + 1)]
        Player.hold = trash;
        CreateEntityDrawable("item",Player.coords.x, Player.coords.y, trash .. ".png",2,1,0);
        SpacePressed = true; 
    end
end

return openCar;