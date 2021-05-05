local level = require "level";

level.load("room");

love.draw = function ()

    level.draw(CurrentLevel);

end