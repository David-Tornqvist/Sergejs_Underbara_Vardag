local string = require "dependencies.split";

local fog = {};

fog.draw = function ()
    for i = 1, #Drawables do
        if Drawables[i].status == false then
            local buttonNumber = string.split(Drawables[i].name, "_")[2];

            local origin = {x = 0, y = 0}

            love.graphics.setColor(0,0,0,0.6);

            if buttonNumber == "1" then
                love.graphics.rectangle("fill",27 + origin.x,11 + origin.y,90,133);
            end

            if buttonNumber == "2" then
                love.graphics.rectangle("fill",27 + origin.x,0 + origin.y,93,152);
            end

            if buttonNumber == "4" then
                love.graphics.rectangle("fill",115 + origin.x,152 + origin.y,93,100);
            end

            if buttonNumber == "3" then
                love.graphics.rectangle("fill",120 + origin.x,0 + origin.y,88,152);
            end

            if buttonNumber == "5" then
                love.graphics.rectangle("fill",208 + origin.x,32 + origin.y,72,152);
            end

            love.graphics.setColor(1,1,1,1);
        end
    end
end

return fog;