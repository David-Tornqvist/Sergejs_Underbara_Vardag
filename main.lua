local level = require "level";

level.load("test_level_04");

love.draw = function ()

    level.draw(CurrentLevel);

end