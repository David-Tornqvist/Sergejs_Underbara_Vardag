local level = require "level.level";
local camera = require "dependencies.camera";
local entity = require "entity.entity"

love.load = function ()
    camera.load();
    
    Window = {  width = love.graphics.getWidth()/ScreenScale/Zoom,
                height = love.graphics.getHeight()/ScreenScale/Zoom}
                
    
    level.load("room");
    entity.load(Levels[level.getIndex(CurrentLevel)]);

end

love.keypressed = function (key)

    if key == "escape" then
        love.event.quit();
    end
end

love.update = function (dt)
    
    Player.input();

    Player.speedUpdate();

    


    Player.animationUpdate(dt);

   
    

   Player.collide(dt,Levels[level.getIndex(CurrentLevel)]);

    

end


love.draw = function ()
    
    love.graphics.scale(ScreenScale, ScreenScale);
    love.graphics.scale(Zoom, Zoom);

    love.graphics.translate((Window.width/2 ), (Window.height/2));
    
    love.graphics.translate(-Player.coords.x, -Player.coords.y);
    level.draw(CurrentLevel);
    --Player.draw();

    --love.graphics.circle("fill",0,0,"20");

    --love.graphics.translate(-(Player.coords.x), -(Player.coords.y));
    --love.graphics.translate(-(Window.width/2 - Player.spawn.x), -(Window.height/2 - Player.spawn.y));
end