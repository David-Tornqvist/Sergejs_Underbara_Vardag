local entity = require "entity.entity"
local player = require "entity.player"
local cartFunc = {}

cartFunc.disableGlow = function ()
    local index = entity.findDrawableEntityIndex("cart");

    Drawables[index].animation.pointer.x = 3;
    Drawables[index].animation.pointer.y = 2;
end

cartFunc.load = function ()

    Cart = {items = {},distance = 20,drive = false};

    CreateEntityDrawable("cart",60,100,"vagn.png",6,3,0);

    local index = entity.findDrawableEntityIndex("cart");

    Drawables[index].animation.pointer.x = 3;
    Drawables[index].animation.pointer.y = 2;

    Cart.interract = function ()
        local index = entity.findDrawableEntityIndex("cart");

        Drawables[index].animation.pointer.x = 6;
        Drawables[index].animation.pointer.y = 2;

        if love.keyboard.isDown("space") then

            
            if Player.hold == "none" then
                Drawables[index].x = Player.coords.x + 10;
                Drawables[index].y = Player.coords.y - 3;
                Cart.drive = true; 
            end
        end

    end
end

return cartFunc;