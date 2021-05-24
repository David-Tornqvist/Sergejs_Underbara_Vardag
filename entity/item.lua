local level = require "level.level";

local item = {};

local itemAnimation = 0;
local itemAnimationSpeed = 5;

item.update = function (dt)
    itemAnimation = itemAnimation + dt * itemAnimationSpeed;

    local index = level.getDrawableIndex("item");
    
    if index ~= -1 then
       
        Drawables[index].x = Player.coords.x + math.cos(itemAnimation) * 12;
        Drawables[index].y = Player.coords.y + 2 + math.sin(itemAnimation) * 12;

    end
end

return item;