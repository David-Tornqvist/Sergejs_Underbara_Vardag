local string = require "dependencies.split";
local crate = {}

crate.load = function (entityType,thisDecal)

    if entityType == "crate" then
        thisDecal.distance = 30; 
    end

end

crate.interract = function (item,drawableIndex)

    Drawables[drawableIndex].animation.pointer.x = 2;

    if love.keyboard.isDown("space") then
        Player.removeHolding();
        Player.hold = item;
        CreateEntityDrawable("item",Player.coords.x, Player.coords.y, item .. ".png",2,1,0);
    end
end

crate.disableGlow = function ()

    for i = 1, #Drawables do
        
        local name = Drawables[i].name

        if name ~= nil then
           
            local entityType = string.split(name,"_")[1];

            if entityType == "crate" then
                Drawables[i].animation.pointer.x = 1;
            end
        end
    end
end

return crate;