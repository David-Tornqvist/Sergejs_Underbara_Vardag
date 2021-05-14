local level = require "level";
local camera = require "dependencies.camera";
local entity = require "entity"
local mathFunc = require "dependencies.mathFunc"

love.load = function ()
    camera.load();
    
    Window = {  width = love.graphics.getWidth()/ScreenScale/Zoom,
                height = love.graphics.getHeight()/ScreenScale/Zoom}
                
    
    level.load("room");
    entity.playerLoad();

end

love.keypressed = function (key)

    if key == "escape" then
        love.event.quit();
    end

    if key == "l" then
        if(Player.animation.pointer.x ~= 6) then
            Player.animation.pointer.x = Player.animation.pointer.x + 1;
        end 
    end
    
    if key == "k" then
        if(Player.animation.pointer.x ~= 1) then
            Player.animation.pointer.x = Player.animation.pointer.x - 1;
        end    
    end

    if key == "u" then
        if(Player.animation.pointer.y ~= 12) then
            Player.animation.pointer.y = Player.animation.pointer.y + 1;
        end
        
    end
    
    if key == "j" then
        if(Player.animation.pointer.y ~= 1) then
            Player.animation.pointer.y = Player.animation.pointer.y - 1;
        end
        
    end

end

love.update = function (dt)
    
    Player.input();

    Player.speedUpdate();

    


    Player.animationUpdate(dt);

    

   Player.collide(dt);

    

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