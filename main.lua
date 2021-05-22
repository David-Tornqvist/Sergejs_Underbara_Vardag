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
local font = require "font";
local carpet = require "entity.carpet";
local quest = require "quest";
local switch = require "entity.switch"
local vehicles = require "entity.vehicles"
local openCar = require "entity.openCar";
local container = require "entity.container";
local credits = require "credits";

love.load = function ()
    camera.load();
    font.load();
    quest.set();

    Line = 0; -- end credits variable
    
    
    Window = {  width = love.graphics.getWidth()/ScreenScale/Zoom,
                height = love.graphics.getHeight()/ScreenScale/Zoom}          
    
    cutscene.load();
    level.load("bedroom");
    

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

    Cutscene.update(key);

    
    Line = Line + 1;
    

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
    switch.disableGlow();
    vehicles.disableGlow();
    openCar.disableGlow();
    container.disableGlow();

    if Cutscene.status == false then
        Player.input();
        Player.interact(Levels[level.getIndex(CurrentLevel)]);
    end
   

    Player.speedUpdate();

    Player.animationUpdate(dt);

    Player.collide(dt,Levels[level.getIndex(CurrentLevel)]);

    

    carpet.update();

    items.update(dt);

    loadAnim.update(dt);

    level.next(dt);
    
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
    quest.draw();

    
    loadAnim.draw();

end

--credits.load();