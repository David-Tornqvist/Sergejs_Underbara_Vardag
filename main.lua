local camera = require "dependencies.camera";
local font = require "dependencies.font";
local menu = require "dependencies.mainmenu";

love.load = function ()

    camera.load();
    font.load();

    Line = 0; -- end credits value
    Music = true;

    Soundtack = love.audio.newSource("content/audio/tetris.mp3", "stream");
    Soundtack:setLooping(true);
    Soundtack:setVolume(0.3);
    Soundtack:play();

    LoadMainMenu();
end