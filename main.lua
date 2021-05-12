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


    print(Window.width,Window.height);

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

    Player.animation.t = Player.animation.t + dt
    if Player.animation.t > Player.animation.maxt then
        Player.animation.t = 0;
    end
    
    if love.keyboard.isDown("w") and love.keyboard.isDown("d") then
        Player.direction = 2;
        Player.isMoving = true;
    elseif love.keyboard.isDown("w") and love.keyboard.isDown("a") then
        Player.direction = 8;
        Player.isMoving = true;
    elseif love.keyboard.isDown("s") and love.keyboard.isDown("d") then
        Player.direction = 4;
        Player.isMoving = true;
    elseif love.keyboard.isDown("s") and love.keyboard.isDown("a") then
        Player.direction = 6;
        Player.isMoving = true;   
    elseif love.keyboard.isDown("w") then
        Player.direction = 1;
        Player.isMoving = true;
    elseif love.keyboard.isDown("s") then
        Player.direction = 5;
        Player.isMoving = true;
    elseif love.keyboard.isDown("a") then
        Player.direction = 7;
        Player.isMoving = true;
    elseif love.keyboard.isDown("d") then
        Player.direction = 3;
        Player.isMoving = true;
    else
        Player.isMoving = false;  
    end




    local diagonalSpeed = mathFunc.pythagoras(Player.moveSpeed)


    if Player.direction == 1 then
        if Player.isMoving then
            Player.speed.y = -Player.moveSpeed;
            Player.speed.x = 0;
            Player.animation.pointer.y = 5;     
        else
            Player.animation.pointer.y = 11;
        end
    elseif Player.direction == 2 then
        if Player.isMoving then
            Player.speed.y = -diagonalSpeed;
            Player.speed.x = diagonalSpeed;
            Player.animation.pointer.y = 4;
        else
            Player.animation.pointer.y = 10;    
        end
    elseif Player.direction == 3 then
        if Player.isMoving then
            Player.speed.x = Player.moveSpeed;
            Player.speed.y = 0;
            Player.animation.pointer.y = 3;
        else
            Player.animation.pointer.y = 9;
        end
    elseif Player.direction == 4 then
        if Player.isMoving then
            Player.speed.y = diagonalSpeed;
            Player.speed.x = diagonalSpeed;
            Player.animation.pointer.y = 3;
        else
            Player.animation.pointer.y = 9;    
        end
    elseif Player.direction == 5 then
        if Player.isMoving then
            Player.speed.y = Player.moveSpeed;
            Player.speed.x = 0;
            Player.animation.pointer.y = 2;
        else
            Player.animation.pointer.y = 8; 
        end
    elseif Player.direction == 6 then
        if Player.isMoving then
            Player.speed.y = diagonalSpeed;
            Player.speed.x = -diagonalSpeed;
            Player.animation.pointer.y = 1;
        else
            Player.animation.pointer.y = 7; 
        end    
    elseif Player.direction == 7 then
        if Player.isMoving then
            Player.speed.x = -Player.moveSpeed;
            Player.speed.y = 0;
            Player.animation.pointer.y = 1;
        else
            Player.animation.pointer.y = 7;    
        end
    elseif Player.direction == 8 then
        if Player.isMoving then
            Player.speed.y = -diagonalSpeed;
            Player.speed.x = -diagonalSpeed;
            Player.animation.pointer.y = 6;
        else
            Player.animation.pointer.y = 12;    
        end                
    end

    if Player.isMoving == false then
        Player.speed.y = 0;
        Player.speed.x = 0;

        Player.animation.maxt = 3;
        Player.animation.frametime = Player.animation.maxt/Player.animation.width; 
        if Player.animation.t > Player.animation.maxt then
            Player.animation.t = 0;
        end
    else
        Player.animation.maxt = Player.moveSpeed/80;
        Player.animation.frametime = Player.animation.maxt/Player.animation.width;
        if Player.animation.t > Player.animation.maxt then
            Player.animation.t = 0;
        end
    end


    Player.animation.pointer.x = math.floor(Player.animation.t / Player.animation.frametime + 1);    

    

    if level.isCollide(CurrentLevel,Player.speed.x * dt,Player.speed.y * dt) == false then
        Player.coords.y = Player.coords.y + Player.speed.y * dt;
        Player.coords.x = Player.coords.x + Player.speed.x * dt;
    elseif level.isCollide(CurrentLevel,Player.speed.x * dt,0) == false then    
        Player.coords.x = Player.coords.x + Player.speed.x * dt;
    elseif level.isCollide(CurrentLevel,0,Player.speed.y * dt) == false then    
        Player.coords.y = Player.coords.y + Player.speed.y * dt;
    end

    

end


love.draw = function ()
    
    love.graphics.scale(ScreenScale, ScreenScale);
    love.graphics.scale(Zoom, Zoom);

    love.graphics.translate((Window.width/2 ), (Window.height/2));
    
    love.graphics.translate(-Player.coords.x, -Player.coords.y);
    level.draw(CurrentLevel);
    Player.draw();

    --love.graphics.circle("fill",0,0,"20");

    --love.graphics.translate(-(Player.coords.x), -(Player.coords.y));
    --love.graphics.translate(-(Window.width/2 - Player.spawn.x), -(Window.height/2 - Player.spawn.y));
end