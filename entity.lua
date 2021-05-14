local mathFunc = require "dependencies.mathFunc"
local level = require "level"

local entity = {}

local animationLoad = function (img,width,height,time)
    
    local animation = {};

    animation.texture = love.graphics.newImage("content/animations/" .. img .. ".png");

    animation.frames = {};

    animation.t = 0;
    animation.maxt = time;
    animation.width = width;
    animation.height = height;

    

    for anim = 1, height do
        animation.frames[anim] = {};
    end


    local pointer = {x = 0, y = 0};
    local cellWidth = animation.texture:getWidth() / width;
    local cellHeight = animation.texture:getHeight() / height;

    for anim = 1, height do
        for frame = 1, width do
            animation.frames[anim][frame] = love.graphics.newQuad(pointer.x, pointer.y, cellWidth, cellHeight, animation.texture:getDimensions());
            pointer.x = pointer.x + cellWidth;
        end    
        pointer.x = 0;
        pointer.y = pointer.y + cellHeight;
    end

    animation.pointer = {x = 1, y = 1};
    animation.frametime = animation.maxt/animation.width;
    animation.cellWidth = cellWidth;
    animation.cellHeight = cellHeight;

    return animation;

end

entity.createDrawable = function (name,x,y,img,animWidth,animHeight,time)

    Drawables[#Drawables+1] = { name = name, x = x, y = y, animation = animationLoad(img,animWidth,animHeight,time),
                                draw = function (i)

                                    love.graphics.draw( Drawables[i].animation.texture, Drawables[i].animation.frames[Drawables[i].animation.pointer.y][Drawables[i].animation.pointer.x], 
                                    Drawables[i].x - Drawables[i].animation.cellWidth/2, Drawables[i].y - Drawables[i].animation.cellHeight/2);
                                    
                                end};
    
end

entity.playerLoad = function ()

    Player = {};

    Player.spawn = {x = 32, y = 85};

    Player.coords = {x = Player.spawn.x, y = Player.spawn.y};

    Player.speed = {x = 0, y = 0};

    Player.moveSpeed = 40;

    Player.animation = animationLoad("sergej",6,12,Player.moveSpeed/80);

    entity.createDrawable("player",Player.spawn.x,Player.spawn.y,"sergej",6,12,Player.moveSpeed/80);

    Player.direction = 1;

    Player.isMoving = false;

    Player.hitbox = {width = 10, height = 4, yOffset = 6};

    Player.animationUpdate = function (dt)

        Player.animation.t = Player.animation.t + dt
        if Player.animation.t > Player.animation.maxt then
            Player.animation.t = 0;
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
    end

    Player.input = function ()
        
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
    end

    Player.speedUpdate = function ()
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

        Drawables[entity.findDrawableEntityIndex("player")].animation.pointer.y = Player.animation.pointer.y;
        Drawables[entity.findDrawableEntityIndex("player")].animation.pointer.x = Player.animation.pointer.x;

    end

    Player.collide = function (dt)
        if level.isCollide(CurrentLevel,Player.speed.x * dt,Player.speed.y * dt) == false then
            Player.coords.y = Player.coords.y + Player.speed.y * dt;
            Player.coords.x = Player.coords.x + Player.speed.x * dt;
        elseif level.isCollide(CurrentLevel,Player.speed.x * dt,0) == false then    
            Player.coords.x = Player.coords.x + Player.speed.x * dt;
        elseif level.isCollide(CurrentLevel,0,Player.speed.y * dt) == false then    
            Player.coords.y = Player.coords.y + Player.speed.y * dt;
        end

        Drawables[entity.findDrawableEntityIndex("player")].x = Player.coords.x;
        Drawables[entity.findDrawableEntityIndex("player")].y = Player.coords.y;

    end
end

entity.findDrawableEntityIndex = function (name)
    
    for i = 1, #Drawables do
        if name == Drawables[i].name then
            return i;
        end
    end
end
    
return entity