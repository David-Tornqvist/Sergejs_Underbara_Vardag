local menu = require "dependencies.mainmenu";
local camera = require "dependencies.camera";
local font = require "dependencies.font";

love.load = function ()

    camera.load();
    font.load();

    Line = 0; -- end credits value
    Music = true;

    Soundtack = love.audio.newSource("content/audio/tetris.mp3", "stream");
    Soundtack:setLooping(true);
    Soundtack:play();

    LoadMainMenu();
end