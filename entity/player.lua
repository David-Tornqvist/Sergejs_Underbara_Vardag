local decals = require "level.decals";
local tiles = require "level.tiles";
local entity = require "entity.entity";
local mathFunc = require "dependencies.mathFunc";
local level = require "level.level";

local player = {}

player.load = function (x,y)

    Player = {};

    Player.spawn = {x = x, y = y};

    Player.coords = {x = Player.spawn.x, y = Player.spawn.y};

    Player.speed = {x = 0, y = 0};

    Player.moveSpeed = 40;

    Player.animation = entity.animationLoad("sergej.png",6,12,Player.moveSpeed/80);

    CreateEntityDrawable("player",Player.spawn.x,Player.spawn.y,"sergej.png",6,12,Player.moveSpeed/80);

    Player.direction = 5;

    Player.isMoving = false;

    Player.hitbox = {width = 10, height = 4, yOffset = 6};

    Player.hold = "none";

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
        local diagonalSpeed = mathFunc.pythagoras(Player.moveSpeed,0,0,"leg")


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

    Player.isCollide = function (level,dx,dy) -- checks wether the new position would collide
    
        local collide = false;
    
        if decals.collide(level,dx,dy) or tiles.collide(level,dx,dy) then
            collide = true;
        end
        
        return collide
    
    end

    Player.collide = function (dt,level)
        if Player.isCollide(level,Player.speed.x * dt,Player.speed.y * dt) == false then
            Player.coords.y = Player.coords.y + Player.speed.y * dt;
            Player.coords.x = Player.coords.x + Player.speed.x * dt;
        elseif Player.isCollide(level,Player.speed.x * dt,0) == false then    
            Player.coords.x = Player.coords.x + Player.speed.x * dt;
        elseif Player.isCollide(level,0,Player.speed.y * dt) == false then    
            Player.coords.y = Player.coords.y + Player.speed.y * dt;
        end

        Drawables[entity.findDrawableEntityIndex("player")].x = Player.coords.x;
        Drawables[entity.findDrawableEntityIndex("player")].y = Player.coords.y;

    end

    Player.interact = function (level)

        for i = 1, #level.table.layers do
            local thisLayer = level.table.layers[i];
            
            if thisLayer.decals ~= nil then
                for b = 1, #thisLayer.decals do
                    local thisDecal = thisLayer.decals[b]; 
                    if thisDecal.values.interact then

                        if mathFunc.distance(Player.coords.x,Player.coords.y,thisDecal.x,thisDecal.y) < thisDecal.distance then

                            entity.interract(thisDecal.values.type,thisDecal.identifier);
                            
                        end
                    end
                end 
            end
        end

        if mathFunc.distance(Player.coords.x,Player.coords.y,Drawables[entity.findDrawableEntityIndex("cart")].x,Drawables[entity.findDrawableEntityIndex("cart")].y) < Cart.distance then
            Cart.interract();
        end

    end

    Player.removeHolding = function ()

        Player.hold = "none"
        table.remove(Drawables,level.getDrawableIndex("item"));
        
    end

end

return player;