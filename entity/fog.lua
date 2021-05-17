local string = require "dependencies.split"

local fog = {}

fog.draw = function ()

    for i = 1, #Drawables do
        if Drawables[i].status == false then
            local buttonNumber = string.split(Drawables[i].name, "_")[2];

            love.graphics.setColor(0,0,0,0.8);

            local rect = {x = 0, y = 0, width = 0, height = 0};
            

            if buttonNumber == "1" then
                rect = {x = 27, y = 11, width = 90, height = 133};
            end

            if buttonNumber == "2" then
                rect = {x = 27, y = 19, width = 92, height = 133};
            end

            love.graphics.rectangle("fill",rect.x,rect.y,rect.width,rect.height);

            love.graphics.setColor(1,1,1,1);
        end
    end

end

return fog;