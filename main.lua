local level = require "level.level";
local camera = require "dependencies.camera";
local entity = require "entity.entity";
local crate = require "entity.crate";
local player = require "entity.player";
local items = require "entity.item";
local cart = require "entity.cartFunc";
local cartFunc = require "entity.cartFunc";
local loadAnim = require "loadAnim";
local cutscene = require "cutscene";

love.load = function ()
    camera.load();
    
    Window = {  width = love.graphics.getWidth()/ScreenScale/Zoom,
                height = love.graphics.getHeight()/ScreenScale/Zoom}          
    
    cutscene.load();
    level.load("outside_copy");
    

    SpacePressed = false;

end

love.keypressed = function (key)

    if key == "escape" then
        love.event.quit();
    end

    if key == "k" then
        for i = 1, #Cart.items do
            print(Cart.items[i]);
        end
    end

    Cutscene.update();

end

love.keyreleased = function (key)
    if key == "space" then
        SpacePressed = false;

        if Cart ~= nil then
            Cart.drive = false;  
            Player.hitbox = {width = 10, height = 4, yOffset = 6,xOffset = 0};
        end
    end
end

love.update = function (dt)

    crate.disableGlow();
    cartFunc.disableGlow();

    if Cutscene.status == false then
        Player.input();
    end
   

    Player.speedUpdate();

    Player.animationUpdate(dt);

    Player.collide(dt,Levels[level.getIndex(CurrentLevel)]);

    Player.interact(Levels[level.getIndex(CurrentLevel)]);

    items.update(dt);

    loadAnim.update(dt);
    
end


love.draw = function ()
    
    love.graphics.scale(ScreenScale, ScreenScale);
    love.graphics.scale(Zoom, Zoom);

    love.graphics.push();

    love.graphics.translate((Window.width/2 ), (Window.height/2));
    
    love.graphics.translate(-Player.coords.x, -Player.coords.y);
    level.draw(CurrentLevel);


    love.graphics.pop();

    Cutscene.draw();
    
    loadAnim.draw();

end