local entity = require "entity.entity";
local player = require "entity.player";
local quest = require "screen.quest";
local loadAnim = require "screen.loadAnim";

local cartFunc = {}

cartFunc.disableGlow = function ()
    local index = entity.findDrawableEntityIndex("cart");

    if index ~= nil then
        Drawables[index].animation.pointer.x = 3;
        Drawables[index].animation.pointer.y = 2;
    end
end

cartFunc.load = function (x,y)

    Cart = {items = {},distance = 20,drive = false};

    CreateEntityDrawable("cart",x,y,"vagn.png",6,3,0);

    local index = entity.findDrawableEntityIndex("cart");

    Drawables[index].animation.pointer.x = 3;
    Drawables[index].animation.pointer.y = 2;

    Cart.interract = function ()
        local index = entity.findDrawableEntityIndex("cart");

        Drawables[index].animation.pointer.x = 6;
        Drawables[index].animation.pointer.y = 2;

        if love.keyboard.isDown("space") and Player.hold == "none" and SpacePressed == false then
            Cart.drive = true;
            Player.hitbox = {width = 24, height = 12, yOffset = 5,xOffset = 7};
            SpacePressed = true;
            
            Player.coords.x = Drawables[index].x - 10;
            Player.coords.y = Drawables[index].y + 3;
        end

        if Cart.drive then
            Drawables[index].x = Player.coords.x + 10;
            Drawables[index].y = Player.coords.y - 3;
        end

        if love.keyboard.isDown("space") and SpacePressed == false then
            Cart.items[#Cart.items+1] = Player.hold;
            quest.set({"HANDLA MED VAGN",#Cart.items .. "/4",""});
            Player.removeHolding();
            SpacePressed = true; 
            if #Cart.items == 4 then
                PlayerProgress.wares = Cart.items;
                loadAnim.load(700,-Window.height);
                NextLoad = true;
            end
        end

    end
end

return cartFunc;