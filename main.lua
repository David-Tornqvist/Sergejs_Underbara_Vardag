local level = require "level";
local camera = require "dependencies.camera";

love.load = function ()
    camera.load();
    level.load("room");
    

end

love.keypressed = function (key)

    if key == "escape" then
        love.event.quit();
    end
    
end



love.draw = function ()
    
    love.graphics.scale(screenScale, screenScale);
    love.graphics.scale(zoom, zoom);

    level.draw(CurrentLevel);

end