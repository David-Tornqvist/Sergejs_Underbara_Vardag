--David Törnqvist

local camera = {};



camera.load = function ()
    local gameWidth = 1920;

    ScreenScale = (love.graphics.getWidth()/gameWidth);
    Zoom = 5;
    Translate = {x = 0, y = 0};
    
    local isPan = false;

    love.graphics.setDefaultFilter("nearest","nearest");
    
end



camera.screenToWorldcords = function (x, y)
    
    return {x = x/ScreenScale/Zoom - Translate.x, y = y/ScreenScale/Zoom - Translate.y};

end



camera.worldToScreencords = function (x, y)
    
    return {x = x*ScreenScale*Zoom - Translate.x, y = y*ScreenScale*Zoom - Translate.y};

end



local function scrl(y)

    --mouse-screencoords Translated to mouse-worldcoords before Zoom 
    local bmouse = camera.screenToWorldcords(love.mouse.getX(), love.mouse.getY());

    Zoom = Zoom + 0.1*y;

    if Zoom > 4 then
        Zoom = 4;
    end

    if Zoom < 0.06 then
        Zoom = 0.06
    end
 
    --mouse-screencoords Translated to mouse-worldcoords before Zoom
    local amouse = camera.screenToWorldcords(love.mouse.getX(), love.mouse.getY());

    --diffrence to Translate by such that mouse-worldcoords are unnafected
    local d = {x = amouse.x - bmouse.x, y = amouse.y - bmouse.y}; 


    Translate.x = Translate.x + d.x;
    Translate.y = Translate.y + d.y;

end



local function setPan(button)

    if(button == 3) then isPan = true; end

end



local function resPan(button)

    if(button == 3) then isPan = false; end

end



local function updatePan ()

    local mouse = {x = love.mouse.getX() / ScreenScale, y = love.mouse.getY() / ScreenScale;}; 

    if(isPan) then
        Translate.x = Translate.x + (mouse.x - PrevX)/ScreenScale/Zoom;
        Translate.y = Translate.y + (mouse.y - PrevY)/ScreenScale/Zoom;
    end    

    PrevX = mouse.x;
    PrevY = mouse.y;

end  



camera.update = function (type, value)
    
    if(type == "scrl") then scrl(value);
    elseif(type == "mPush") then setPan(value);
    elseif(type == "mRel") then resPan(value);
    elseif(type == "pan") then updatePan(); end    

end



return camera;